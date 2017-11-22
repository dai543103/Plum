#ifndef __FD_POOL_H__
#define __FD_POOL_H__

#include "PlumDefine.h"
#include <unordered_map>

#define MAX_SERVER_ENTITY_NUMBER  3 //内部服务数量

/************************************************************************/
/* FD池，内部外部所有连接socket         
*/
/************************************************************************/
class CFDPool
{
public:
	void Initialize();
	//监听套接字
	bool IsListeningForExternalClient(int iFD);
	bool IsListeningForInternalServer(int iFD);
	void SetListeningForServer(int iFD,bool);
	//连接套接字
	bool IsConnectedByExternalClient(int iFD);
	bool IsConnectedByInternalServer(int iFD);
	void SetConnectedByServer(int iFD,bool);


	//外部socket
	void SetFDInactive(int iFD);
	void SetFDActive(int iFD);
	TExternalClientSocket* GetExternalSocketByFD(int iFD);
	TExternalClientSocket* GetExternalFirstSocket();

	//内部Socket
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
