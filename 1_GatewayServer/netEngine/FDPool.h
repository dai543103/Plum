#ifndef __FD_POOL_H__
#define __FD_POOL_H__

#include "PlumDefine.h"
#include <unordered_map>

#define MAX_SERVER_ENTITY_NUMBER  3 //�ڲ���������

/************************************************************************/
/* FD�أ��ڲ��ⲿ��������socket         
*/
/************************************************************************/
class CFDPool
{
public:
	void Initialize();
	//�����׽���
	bool IsListeningForExternalClient(int iFD);
	bool IsListeningForInternalServer(int iFD);
	void SetListeningForServer(int iFD,bool);
	//�����׽���
	bool IsConnectedByExternalClient(int iFD);
	bool IsConnectedByInternalServer(int iFD);
	void SetConnectedByServer(int iFD,bool);


	//�ⲿsocket
	void SetFDInactive(int iFD);
	void SetFDActive(int iFD);
	TExternalClientSocket* GetExternalSocketByFD(int iFD);
	TExternalClientSocket* GetExternalFirstSocket();

	//�ڲ�Socket
	int AddInternalServerIP(unsigned int uiInternalServerIP, unsigned short ushListenedPort, unsigned short ushServerType, unsigned short ushServerID);
	int ClearInternalServerByIPAndPort(unsigned int uiInternalServerIP, unsigned short ushListenedPort);
	TInternalServerSocket* GetInternalSocketByTypeAndID(unsigned short ushServerType, unsigned short ushServerID);
	TInternalServerSocket* GetInternalSocketByInternalServerIP(unsigned int uiInternalServerIP, unsigned short ushListenedPort);
	TInternalServerSocket* GetInternalSocketByFD(int iFD);
	int SetDefaultInternalSocket(unsigned short ushServerType, unsigned short ushServerID);
	TInternalServerSocket* GetDefaultInternalSocket();
	void ClearDefaultInternalSocket();

private:
	unsigned int m_auiSocketFlag[FD_SIZE];

	TExternalClientSocket m_astExternalSocket[FD_SIZE];
	TExternalClientSocket* m_pFirstSocket;

	unsigned int m_uiInternalServerNumber;
	TInternalServerSocket m_astInternalServerSocket[MAX_SERVER_ENTITY_NUMBER];
	TInternalServerSocket* m_pDefaultSocket;
};

#endif
