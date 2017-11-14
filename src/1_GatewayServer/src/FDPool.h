#ifndef __INTERNALSERVER_POOL_H__
#define __INTERNALSERVER_POOL_H__

#include "PlumDefine.h"
#include <unordered_map>

#define MAX_SERVER_ENTITY_NUMBER  3 //内部服务数量

//内部进程间socket池
class CInternalServerPool
{
public:
	void Initialize();

	TInternalServerSocket* GetSocketByFD(int iFD);
	TInternalServerSocket* GetSocketByInternalServerIP(unsigned int uiInternalServerIP, unsigned short ushListenedPort);
	TInternalServerSocket* GetSocketByTypeAndID(unsigned short ushServerType, unsigned short ushServerID);

	int AddInternalServerIP(unsigned int uiInternalServerIP, unsigned short ushListenedPort, unsigned short ushServerType, unsigned short ushServerID);
    int ClearInternalServerByIPAndPort(unsigned int uiInternalServerIP, unsigned short ushListenPort);

	//设置默认内部套接字
	int SetDefaultSocket(unsigned short ushServerType, unsigned short ushServerID);
    int ClearDefaultSocket();

	//获取默认内部套接字
	TInternalServerSocket* GetDefaultSocket();
    
private:
	unsigned int m_uiInternalServerNumber;
	TInternalServerSocket m_astInternalServerSocket[MAX_SERVER_ENTITY_NUMBER];
	TInternalServerSocket* m_pDefaultSocket; //默认套接字
};

//外部socket池
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

	//初始化External、Internal套接字池
	void Initialize();


	//将指定FD设置为空
	void SetFDInactive(int iFD);

	// 设置激活
	void SetFDActive(int iFD);

	//是否是外部监听套接字
	bool IsListeningForExternalClient(int iFD);
	//设置为外部监听套接字
	void SetListeningForExternalClient(int iFD);
	//是否是内部监听套接字
	bool IsListeningForInternalServer(int iFD);
	//设置为内部监听套接字
	void SetListeningForInternalServer(int iFD);


	//是否是外部连接套接字
	bool IsConnectedByExternalClient(int iFD);
	//设置为外部连接套接字
	void SetConnectedByExternalClient(int iFD);
	//是否是内部连接套接字
	bool IsConnectedByInternalServer(int iFD);
	//设置为内部连接套接字
	void SetConnectedByInternalServer(int iFD);


	//增加内部Server地址
	int AddInternalServerIP(unsigned int uiInternalServerIP, unsigned short ushListenedPort,
		unsigned short ushServerType, unsigned short ushServerID);
	int ClearInternalServerByIPAndPort(unsigned int uiInternalServerIP, unsigned short ushListenedPort);

	TInternalServerSocket* GetInternalSocketByTypeAndID(unsigned short ushServerType, unsigned short ushServerID);
	TInternalServerSocket* GetInternalSocketByInternalServerIP(unsigned int uiInternalServerIP, unsigned short ushListenedPort);
	TInternalServerSocket* GetInternalSocketByFD(int iFD);
	TExternalClientSocket* GetExternalSocketByFD(int iFD);
	TExternalClientSocket* GetExternalFirstSocket();


	//设置默认内部套接字
	int SetDefaultInternalSocket(unsigned short ushServerType, unsigned short ushServerID);
	//获取默认内部套接字
	TInternalServerSocket* GetDefaultInternalSocket();
	//清除默认套接字
	int ClearDefaultInternalSocket();

private:
	unsigned int m_auiSocketFlag[FD_SIZE];
	CInternalServerPool m_stInternalServerPool;
	CExternalClientPool m_stExternalClientPool;

};




#endif
