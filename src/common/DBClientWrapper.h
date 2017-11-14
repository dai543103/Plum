#ifndef __DB_CLIENT_WRAPPER_H__
#define __DB_CLIENT_WRAPPER_H__

#include <stdlib.h>
#include <string.h>
#include <mysql.h>
#include <string>

#if MYSQL_VERSION_ID >= 4000
#define mysql_connect(m,h,u,p) mysql_real_connect((m),(h),(u),(p),NULL,0,NULL,0)
#endif

//MYSQL ���ݿ������
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

	//����select���ĵ��еĽ��������pstResult�����pLengths����������ÿ���ֶεĳ��ȣ�uFields���з����ֶε�����
	int FetchOneRow(MYSQL_ROW& pstResult, unsigned long*& pLengthes, unsigned int& uFields);

	//����Ӱ�������
	int GetAffectedRows();

	inline MYSQL& GetCurMysqlConn()
	{
		return m_stDBConn.stMySql;
	}

	inline int GetNumberRows()
	{
		return m_iResNum;
	}

	//��ȡ�ϴβ����AUTO_INCREMENT���ص�IDֵ
	inline unsigned GetLastInsertID()
	{
		return mysql_insert_id(&m_stDBConn.stMySql);
	}

private:
	//�ͷŲ����Ľ����
	int FreeResult();


private:
	MysqlConnection m_stDBConn;    //������MYSQL handler������

	MYSQL_RES* m_pstRes;           //��ǰ������RecordSet������
	int m_iResNum;                 //��ǰ������RecordSet����Ŀ
};

#endif
