#include "FDPool.h"
#include <vcruntime.h>
#include <assert.h>



void CFDPool::Initialize()
{
	memset(m_auiSocketFlag, 0, sizeof(m_auiSocketFlag));

	m_uiInternalServerNumber = 0;
	m_pDefaultSocket = nullptr;

	for (unsigned int i = 0; i < FD_SIZE; i++)
	{
		m_astExternalSocket[i].m_iSocketFD = -1;
		m_astExternalSocket[i].m_pPrevSocket = nullptr;
		m_astExternalSocket[i].m_pNextSocket = nullptr;
	}
	m_pFirstSocket = nullptr;
}

void CFDPool::SetFDInactive(int iFD)
{
	assert(iFD > 0 && iFD < (int)FD_SIZE);

	m_astExternalSocket[iFD].m_iSocketFD = -1;

	TExternalClientSocket* pstPrevSocket = m_astExternalSocket[iFD].m_pPrevSocket;
	TExternalClientSocket* pstNextSocket = m_astExternalSocket[iFD].m_pNextSocket;

	if (pstPrevSocket)
	{
		pstPrevSocket->m_pNextSocket = pstNextSocket;
	}

	if (pstNextSocket)
	{
		pstNextSocket->m_pPrevSocket = pstPrevSocket;
	}

	if (m_pFirstSocket == &m_astExternalSocket[iFD])
	{
		m_pFirstSocket = pstNextSocket;
	}

	m_astExternalSocket[iFD].m_pPrevSocket = nullptr;
	m_astExternalSocket[iFD].m_pNextSocket = nullptr;

}

void CFDPool::SetFDActive(int iFD)
{
	assert(iFD > 0 && iFD < (int)FD_SIZE);

	m_astExternalSocket[iFD].m_pPrevSocket = nullptr;
	m_astExternalSocket[iFD].m_pNextSocket = nullptr;

	if (m_pFirstSocket == nullptr)
	{
		m_pFirstSocket = &m_astExternalSocket[iFD];
		return;
	}

	m_astExternalSocket[iFD].m_pNextSocket = m_pFirstSocket;

	m_pFirstSocket->m_pPrevSocket = &m_astExternalSocket[iFD];

	m_pFirstSocket = &m_astExternalSocket[iFD];

}

bool CFDPool::IsListeningForExternalClient(int iFD)
{
	return (m_auiSocketFlag[iFD] & EPSF_ListeningForExternalClient);
}

bool CFDPool::IsListeningForInternalServer(int iFD)
{
	return (m_auiSocketFlag[iFD] & EPSF_ListeningForInternalServer);
}

void CFDPool::SetListeningForServer(int iFD,bool isInternal)
{
	m_auiSocketFlag[iFD] = isInternal ? EPSF_ListeningForInternalServer : EPSF_ListeningForExternalClient;
}


bool CFDPool::IsConnectedByExternalClient(int iFD)
{
	return (m_auiSocketFlag[iFD] & EPSF_ConnectedByExternalClient);
}

bool CFDPool::IsConnectedByInternalServer(int iFD)
{
	return (m_auiSocketFlag[iFD] & EPSF_ConnectedByInternalServer);
}

void CFDPool::SetConnectedByServer(int iFD, bool isInternal)
{
	m_auiSocketFlag[iFD] = isInternal ? EPSF_ConnectedByInternalServer : EPSF_ConnectedByExternalClient;
}

int CFDPool::AddInternalServerIP(unsigned int uiInternalServerIP, unsigned short ushListenedPort,
	unsigned short ushServerType, unsigned short ushServerID)
{
	if (m_uiInternalServerNumber >= MAX_SERVER_ENTITY_NUMBER)
	{
		return -1;
	}

	for (int i = 0; i < m_uiInternalServerNumber; ++i)
	{
		if (m_astInternalServerSocket[i].m_uiSrcIP == uiInternalServerIP &&
			m_astInternalServerSocket[i].m_ushListenedPort == ushListenedPort)
		{
			return 0;
		}
	}

	m_astInternalServerSocket[m_uiInternalServerNumber].m_uiSrcIP = uiInternalServerIP;
	m_astInternalServerSocket[m_uiInternalServerNumber].m_ushListenedPort = ushListenedPort;
	m_astInternalServerSocket[m_uiInternalServerNumber].m_iSocketFD = -1;
	m_astInternalServerSocket[m_uiInternalServerNumber].m_ushServerType = ushServerType;
	m_astInternalServerSocket[m_uiInternalServerNumber].m_ushServerID = ushServerID;
	m_uiInternalServerNumber++;

	return 0;
}

int CFDPool::ClearInternalServerByIPAndPort(unsigned int uiInternalServerIP, unsigned short ushListenedPort)
{
	for (int i = 0; i < m_uiInternalServerNumber; ++i)
	{
		if (m_astInternalServerSocket[i].m_uiSrcIP == uiInternalServerIP &&
			m_astInternalServerSocket[i].m_ushListenedPort == ushListenPort)
		{
			if (i == m_uiInternalServerNumber - 1)
			{
				m_uiInternalServerNumber--;
			}
			else
			{
				m_astInternalServerSocket[i] = m_astInternalServerSocket[m_uiInternalServerNumber - 1];
				m_uiInternalServerNumber--;
			}

			return 0;
		}
	}

	return 0;
}

TInternalServerSocket* CFDPool::GetInternalSocketByTypeAndID(unsigned short ushServerType, unsigned short ushServerID)
{
	for (int i = 0; i < (int)m_uiInternalServerNumber; ++i)
	{
		if (ushServerType == m_astInternalServerSocket[i].m_ushServerType &&
			ushServerID == m_astInternalServerSocket[i].m_ushServerID)
		{
			return &m_astInternalServerSocket[i];
		}
	}

	return nullptr;
}

TInternalServerSocket* CFDPool::GetInternalSocketByInternalServerIP(unsigned int uiInternalServerIP, unsigned short ushListenedPort)
{
	for (int i = 0; i < m_uiInternalServerNumber; ++i)
	{
		if (uiInternalServerIP == m_astInternalServerSocket[i].m_uiSrcIP &&
			ushListenedPort == m_astInternalServerSocket[i].m_ushListenedPort)
		{
			return &m_astInternalServerSocket[i];
		}
	}

	return nullptr;
}

TInternalServerSocket* CFDPool::GetInternalSocketByFD(int iFD)
{
	for (int i = 0; i < m_uiInternalServerNumber; ++i)
	{
		if (iFD == m_astInternalServerSocket[i].m_iSocketFD)
		{
			return &m_astInternalServerSocket[i];
		}
	}

	return nullptr;
}

TExternalClientSocket* CFDPool::GetExternalSocketByFD(int iFD)
{
	assert(iFD > 0 && iFD < (int)FD_SIZE);

	return &m_astExternalSocket[iFD];
}

TExternalClientSocket* CFDPool::GetExternalFirstSocket()
{
	return m_pFirstSocket;
}

int CFDPool::SetDefaultInternalSocket(const unsigned short ushServerType, const unsigned short ushServerID)
{
	for (int i = 0; i < m_uiInternalServerNumber; ++i)
	{
		if (ushServerType == m_astInternalServerSocket[i].m_ushServerType &&
			ushServerID == m_astInternalServerSocket[i].m_ushServerID)
		{
			m_pDefaultSocket = &m_astInternalServerSocket[i];
			return 0;
		}
	}

	return -1;
}

void CFDPool::ClearDefaultInternalSocket()
{
	m_pDefaultSocket = nullptr;
}

TInternalServerSocket* CFDPool::GetDefaultInternalSocket()
{
	return m_pDefaultSocket;
}
