#include <stdio.h>

#include "DBClientWrapper.h"
#include <iostream>

DBClientWrapper::DBClientWrapper()
{
    m_pstRes = nullptr;
    m_iResNum = 0;
}

DBClientWrapper::~DBClientWrapper()
{
   
    FreeResult();
    //关闭所有到MYSQL服务器的连接
    CloseMysqlDB();
}

void DBClientWrapper::Init()
{
	mysql_init(&m_stDBConn.stMySql);
}

int DBClientWrapper::SetMysqlDBInfo(const char* pszHostAddr, const char* pszUserName, const char* pszPasswd, const char* pszDBName)
{
	if (m_stDBConn.szHostAddress.compare(pszHostAddr) != 0)
	{
		if (m_stDBConn.bDBIsConnect)
		{
			CloseMysqlDB();
		}

		if (mysql_connect(&m_stDBConn.stMySql, pszHostAddr, pszUserName, pszPasswd) == 0)
		{
			std::cout << "Fail to Connect to Mysql: %s\n" << mysql_error(&m_stDBConn.stMySql) << std::endl;
			return -1;
		}
		m_stDBConn.bDBIsConnect = true;
	}
	else
	{
		if (!m_stDBConn.bDBIsConnect)
		{
			//连接相同的DB，并且原来未连接
			if (mysql_connect(&m_stDBConn.stMySql, pszHostAddr, pszUserName, pszPasswd) == 0)
			{
				std::cout << "Fail to Connect to Mysql: %s\n" << mysql_error(&m_stDBConn.stMySql) << std::endl;
				return -1;
			}
			m_stDBConn.bDBIsConnect = true;
		}
	}



	if (m_stDBConn.szDBName.compare(pszDBName) != 0)
	{
		//需要重新选择DB
		if (mysql_select_db(&m_stDBConn.stMySql, pszDBName) < 0)
		{
			std::cout << "Cannot Select Database " << pszDBName << mysql_error(&m_stDBConn.stMySql) << std::endl;
			return -1;
		}
	}

	//对连接的内容赋值
	m_stDBConn.szDBName = pszDBName;
	m_stDBConn.szHostAddress = pszHostAddr;
	m_stDBConn.szUserName = pszUserName;
	m_stDBConn.szUserPasswd = pszPasswd;

	return 0;
}

int DBClientWrapper::CloseMysqlDB()
{
	FreeResult();
	mysql_close(&m_stDBConn.stMySql);
	m_stDBConn.bDBIsConnect = false;

    return 0;
}



int DBClientWrapper::ExecuteRealQuery(const char* pszQuery, int iLength, bool bIsSelect)
{
	//先释放
	FreeResult();

	if (!m_stDBConn.bDBIsConnect)
	{
		std::cout << "Has Not Connect to MYSQL DB Server!";
		return -1;
	}

	//确认当前DB可用，执行query
	int iRet = mysql_real_query(&m_stDBConn.stMySql, pszQuery, iLength);
	if (iRet != 0)
	{
		int iErrNo = mysql_errno(&m_stDBConn.stMySql);
		return iErrNo;
	}

	if (bIsSelect)
	{
		m_pstRes = mysql_store_result(&m_stDBConn.stMySql);
		if (!m_pstRes)
		{
			//获取结果集失败
			int iErrNo = mysql_errno(&m_stDBConn.stMySql);
			return iErrNo;
		}

		m_iResNum = mysql_num_rows(m_pstRes);
	}

	return 0;
}

int DBClientWrapper::FreeResult()
{
    if(m_pstRes)
    {
        mysql_free_result(m_pstRes);
        m_pstRes = nullptr;
    }

    return 0;
}

int DBClientWrapper::FetchOneRow(MYSQL_ROW& pstResult, unsigned long*& pLengthes, unsigned int& uFields)
{
    if(!m_pstRes)
    {
        std::cout<< "RecordSet is NULL!";
        return -1;
    }

    if(m_iResNum == 0)
    {
		std::cout << "RecordSet count=0!";
        return -2;
    }

    pstResult = mysql_fetch_row(m_pstRes);
    pLengthes = mysql_fetch_lengths(m_pstRes);
    uFields = mysql_num_fields(m_pstRes);

    if(!pstResult || !pLengthes)
    {
		std::cout << "Fail to fetch record row or length!";
        return -3;
    }

    return 0;
}

int DBClientWrapper::GetAffectedRows()
{
    if(!m_stDBConn.bDBIsConnect)
    {
        std::cout<< "Has Not Connect to DB Server!";
        return 0;
    }

    return mysql_affected_rows(&m_stDBConn.stMySql);
}


