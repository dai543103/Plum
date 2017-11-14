#ifndef __INTERNALSERVER_POOL_H__
#define __INTERNALSERVER_POOL_H__

#include "PlumDefine.h"
#include <unordered_map>

#define MAX_SERVER_ENTITY_NUMBER  3 //�ڲ���������

//�ڲ����̼�socket��
class CInternalServerPool
{
public:
	void Initialize();

	TInternalServerSocket* GetSocketByFD(int iFD);
	TInternalServerSocket* GetSocketByInternalServerIP(unsigned int uiInternalServerIP, unsigned short ushListenedPort);
	TInternalServerSocket* GetSocketByTypeAndID(unsigned short ushServerType, unsigned short ushServerID);

	int AddInternalServerIP(unsigned int uiInternalServerIP, unsigned short ushListenedPort, unsigned short ushServerType, unsigned short ushServerID);
    int ClearInternalServerByIPAndPort(unsigned int uiInternalServerIP, unsigned short ushListenPort);

	//����Ĭ���ڲ��׽���
	int SetDefaultSocket(unsigned short ushServerType, unsigned short ushServerID);
    int ClearDefaultSocket();

	//��ȡĬ���ڲ��׽���
	TInternalServerSocket* GetDefaultSocket();
    
private:
	unsigned int m_uiInternalServerNumber;
	TInternalServerSocket m_astInternalServerSocket[MAX_SERVER_ENTITY_NUMBER];
	TInternalServerSocket* m_pDefaultSocket; //Ĭ���׽���
};

//�ⲿsocket��
class CExternalClientPool
{
public:
	void Initialize();

	TExternalClientSocket* GetSocketByFD(const int iFD);
	TExternalClientSocket* GetFirstSocket();

	void DeleteSocketByFD(const int iFD);
	void AddSocketByFD(const int iFD);

private:
	TExternalClientSocket m_astExternalSocket[FD_SIZE];

	TExternalClientSocket* m_pFirstSocket;
};


class CFDPool
{
public:

	//��ʼ��External��Internal�׽��ֳ�
	void Initialize();


	//��ָ��FD����Ϊ��
	void SetFDInactive(int iFD);

	// ���ü���
	void SetFDActive(int iFD);

	//�Ƿ����ⲿ�����׽���
	bool IsListeningForExternalClient(int iFD);
	//����Ϊ�ⲿ�����׽���
	void SetListeningForExternalClient(int iFD);
	//�Ƿ����ڲ������׽���
	bool IsListeningForInternalServer(int iFD);
	//����Ϊ�ڲ������׽���
	void SetListeningForInternalServer(int iFD);


	//�Ƿ����ⲿ�����׽���
	bool IsConnectedByExternalClient(int iFD);
	//����Ϊ�ⲿ�����׽���
	void SetConnectedByExternalClient(int iFD);
	//�Ƿ����ڲ������׽���
	bool IsConnectedByInternalServer(int iFD);
	//����Ϊ�ڲ������׽���
	void SetConnectedByInternalServer(int iFD);


	//�����ڲ�Server��ַ
	int AddInternalServerIP(unsigned int uiInternalServerIP, unsigned short ushListenedPort,
		unsigned short ushServerType, unsigned short ushServerID);
	int ClearInternalServerByIPAndPort(unsigned int uiInternalServerIP, unsigned short ushListenedPort);

	TInternalServerSocket* GetInternalSocketByTypeAndID(unsigned short ushServerType, unsigned short ushServerID);
	TInternalServerSocket* GetInternalSocketByInternalServerIP(unsigned int uiInternalServerIP, unsigned short ushListenedPort);
	TInternalServerSocket* GetInternalSocketByFD(int iFD);
	TExternalClientSocket* GetExternalSocketByFD(int iFD);
	TExternalClientSocket* GetExternalFirstSocket();


	//����Ĭ���ڲ��׽���
	int SetDefaultInternalSocket(unsigned short ushServerType, unsigned short ushServerID);
	//��ȡĬ���ڲ��׽���
	TInternalServerSocket* GetDefaultInternalSocket();
	//���Ĭ���׽���
	int ClearDefaultInternalSocket();

private:
	unsigned int m_auiSocketFlag[FD_SIZE];
	CInternalServerPool m_stInternalServerPool;
	CExternalClientPool m_stExternalClientPool;

};




#endif
