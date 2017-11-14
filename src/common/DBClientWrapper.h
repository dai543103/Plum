#ifndef __DB_CLIENT_WRAPPER_H__
#define __DB_CLIENT_WRAPPER_H__

#include <stdlib.h>
#include <string.h>
#include <mysql.h>
#include <string>

#if MYSQL_VERSION_ID >= 4000
#define mysql_connect(m,h,u,p) mysql_real_connect((m),(h),(u),(p),NULL,0,NULL,0)
#endif

//MYSQL 数据库的连接
struct MysqlConnection
{
	MYSQL stMySql;

    std::string szHostAddress;
	std::string szUserName;
	std::string szUserPasswd;
	std::string szDBName;
    bool bDBIsConnect; 
};

class DBClientWrapper
{
public:

	DBClientWrapper();

	~DBClientWrapper();

	void Init();

	int SetMysqlDBInfo(const char* pszHostAddr, const char* pszUserName, const char* pszPasswd, const char* pszDBName);

	int CloseMysqlDB();

	int ExecuteRealQuery(const char* pszQuery, int iLength, bool bIsSelect);

	//返回select到的单行的结果，返回pstResult结果，pLengths返回数组中每个字段的长度，uFields单行返回字段的数量
	int FetchOneRow(MYSQL_ROW& pstResult, unsigned long*& pLengthes, unsigned int& uFields);

	//返回影响的行数
	int GetAffectedRows();

	inline MYSQL& GetCurMysqlConn()
	{
		return m_stDBConn.stMySql;
	}

	inline int GetNumberRows()
	{
		return m_iResNum;
	}

	//获取上次插入的AUTO_INCREMENT返回的ID值
	inline unsigned GetLastInsertID()
	{
		return mysql_insert_id(&m_stDBConn.stMySql);
	}

private:
	//释放操作的结果集
	int FreeResult();


private:
	MysqlConnection m_stDBConn;    //操作的MYSQL handler的链表

	MYSQL_RES* m_pstRes;           //当前操作的RecordSet的内容
	int m_iResNum;                 //当前操作的RecordSet的数目
};

#endif
