#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>

#include "ListenerWrapper.h"

CListenerWrapper::CListenerWrapper()
{
	m_uiIP = 0;
	m_ushPort = 0;
	m_uiSendBufferSize = 0;
	m_bExternalClient = false;
	m_iState = emListenStatus::UnListen;
}

CListenerWrapper::~CListenerWrapper()
{

}

int CListenerWrapper::Init(unsigned int uiIP, unsigned short ushPort,
						 unsigned int uiSendBufferSize, bool bExternalClient)
{
	m_uiIP = uiIP;
	m_ushPort = ushPort;
	m_uiSendBufferSize = uiSendBufferSize;
	m_bExternalClient = bExternalClient;
	m_iState = emListenStatus::UnListen;

	return 0;
}

int CListenerWrapper::CreateTCPSocket()
{
	m_iListeningSocket = socket(AF_INET, SOCK_STREAM, 0);
	if(m_iListeningSocket < 0)
	{
		return -1;
	}

	return 0;
}

int CListenerWrapper::Bind(unsigned int uiIP, unsigned short ushPort)
{
	struct sockaddr_in stSocketAddress;
	memset(&stSocketAddress, 0, sizeof(stSocketAddress));
	stSocketAddress.sin_family = AF_INET;
	stSocketAddress.sin_port = htons(ushPort);
	stSocketAddress.sin_addr.s_addr = uiIP;

	int iRet = bind(m_iListeningSocket, (struct sockaddr *)&stSocketAddress, sizeof(stSocketAddress));
	if(iRet < 0)
	{
		printf("bind %d failed, %s\n", ushPort, strerror(errno));
		return -1;
	}

	return 0;
}

int CListenerWrapper::Listen()
{
	int iRet = listen(m_iListeningSocket, 1024);
	if(iRet < 0)
	{
		printf("listen %d connection error!\n", 1024);
		return -1;
	}

	m_iState = emListenStatus::Listen;
	return 0;
}


void CListenerWrapper::SetForEpoll()
{
	int iFlagReuse = 1;
	setsockopt(m_iListeningSocket, SOL_SOCKET, SO_REUSEADDR, &iFlagReuse, sizeof(iFlagReuse));

	int iFlagAlive = 1;
	setsockopt(m_iListeningSocket, SOL_SOCKET, SO_KEEPALIVE, &iFlagAlive, sizeof(iFlagAlive));

	struct linger stLinger;
	stLinger.l_onoff = 0;
	stLinger.l_linger = 0;
	setsockopt(m_iListeningSocket, SOL_SOCKET, SO_LINGER, &stLinger, sizeof(stLinger));
}

