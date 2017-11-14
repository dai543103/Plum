#include "FDPool.h"
#include <vcruntime.h>
#include <assert.h>


void CInternalServerPool::Initialize()
{
    m_uiInternalServerNumber = 0;
    m_pDefaultSocket = nullptr;
}

TInternalServerSocket* CInternalServerPool::GetSocketByFD(int iFD)
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

TInternalServerSocket* CInternalServerPool::GetSocketByInternalServerIP(unsigned int uiInternalServerIP,unsigned short ushListenedPort)
{
    for(int i = 0; i < m_uiInternalServerNumber; ++i)
    {
        if(uiInternalServerIP == m_astInternalServerSocket[i].m_uiSrcIP &&
            ushListenedPort == m_astInternalServerSocket[i].m_ushListenedPort)
        {
            return &m_astInternalServerSocket[i];
        }
    }

    return nullptr ;
}

TInternalServerSocket* CInternalServerPool::GetSocketByTypeAndID(unsigned short ushServerType,unsigned short ushServerID)
{
    for(int i = 0; i < (int)m_uiInternalServerNumber; ++i)
    {
        if(ushServerType == m_astInternalServerSocket[i].m_ushServerType &&
            ushServerID == m_astInternalServerSocket[i].m_ushServerID)
        {
            return &m_astInternalServerSocket[i];
        }
    }

    return nullptr;
}

int CInternalServerPool::AddInternalServerIP(unsigned int uiInternalServerIP, unsigned short ushListenedPort,
                                             unsigned short ushServerType, unsigned short ushServerID)
{
    if(m_uiInternalServerNumber >= MAX_SERVER_ENTITY_NUMBER)
    {
        return -1;
    }

    for(int i = 0; i < m_uiInternalServerNumber; ++i)
    {
        if(m_astInternalServerSocket[i].m_uiSrcIP == uiInternalServerIP &&
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



//设置默认内部套接字
int CInternalServerPool::SetDefaultSocket(unsigned short ushServerType, unsigned short ushServerID)
{
    for(int i = 0; i < m_uiInternalServerNumber; ++i)
    {
        if(ushServerType == m_astInternalServerSocket[i].m_ushServerType &&
			ushServerID == m_astInternalServerSocket[i].m_ushServerID)
        {
            m_pDefaultSocket = &m_astInternalServerSocket[i];
            return 0;
        }
    }

    return -1;
}

int CInternalServerPool::ClearDefaultSocket()
{
    m_pDefaultSocket = nullptr;

    return 0;
}

TInternalServerSocket* CInternalServerPool::GetDefaultSocket()
{
    return m_pDefaultSocket;
}

int CInternalServerPool::ClearInternalServerByIPAndPort( unsigned int uiInternalServerIP, unsigned short ushListenPort )
{
    for(int i = 0; i < m_uiInternalServerNumber; ++i)
    {
        if(m_astInternalServerSocket[i].m_uiSrcIP == uiInternalServerIP &&
			m_astInternalServerSocket[i].m_ushListenedPort == ushListenPort)
        {
            if(i == m_uiInternalServerNumber - 1)
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

////////////////////////////////////////////
void CExternalClientPool::Initialize()
{
	for (unsigned int i = 0; i < FD_SIZE; i++)
	{
		m_astExternalSocket[i].m_iSocketFD = -1;
		m_astExternalSocket[i].m_pPrevSocket = NULL;
		m_astExternalSocket[i].m_pNextSocket = NULL;
	}

	m_pFirstSocket = NULL;
}

TExternalClientSocket* CExternalClientPool::GetSocketByFD(const int iFD)
{
	assert(iFD > 0 && iFD < (int)FD_SIZE);

	return &m_astExternalSocket[iFD];
}

TExternalClientSocket* CExternalClientPool::GetFirstSocket()
{
	return m_pFirstSocket;
}

void CExternalClientPool::DeleteSocketByFD(const int iFD)
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

	m_astExternalSocket[iFD].m_pPrevSocket = NULL;
	m_astExternalSocket[iFD].m_pNextSocket = NULL;

	return;
}

void CExternalClientPool::AddSocketByFD(const int iFD)
{
	assert(iFD > 0 && iFD < (int)FD_SIZE);

	m_astExternalSocket[iFD].m_pPrevSocket = NULL;
	m_astExternalSocket[iFD].m_pNextSocket = NULL;

	if (m_pFirstSocket == NULL)
	{
		m_pFirstSocket = &m_astExternalSocket[iFD];
		return;
	}

	m_astExternalSocket[iFD].m_pNextSocket = m_pFirstSocket;

	m_pFirstSocket->m_pPrevSocket = &m_astExternalSocket[iFD];

	m_pFirstSocket = &m_astExternalSocket[iFD];
}

/////////////////////////////////////////
void CFDPool::Initialize()
{
	memset(m_auiSocketFlag, 0, sizeof(m_auiSocketFlag));
	m_stInternalServerPool.Initialize();
	m_stExternalClientPool.Initialize();
}

void CFDPool::SetFDInactive(int iFD)
{
	assert(iFD > 0 && iFD < (int)FD_SIZE);

	// 为以防万一, internal和external的都关闭
	m_stExternalClientPool.DeleteSocketByFD(iFD);
	TInternalServerSocket *pInSocket = m_stInternalServerPool.GetSocketByFD(iFD);
	if (pInSocket)
	{
		pInSocket->m_iSocketFD = -1;
	}

	m_auiSocketFlag[iFD] = 0;

	return;
}

void CFDPool::SetFDActive(int iFD)
{
	assert(iFD > 0 && iFD < (int)FD_SIZE);

	m_stExternalClientPool.AddSocketByFD(iFD);

}

bool CFDPool::IsListeningForExternalClient(int iFD)
{
	return (m_auiSocketFlag[iFD] & ELSF_ListeningForExternalClient);
}

void CFDPool::SetListeningForExternalClient(int iFD)
{
	m_auiSocketFlag[iFD] = ELSF_ListeningForExternalClient;
}

bool CFDPool::IsListeningForInternalServer(int iFD)
{
	return (m_auiSocketFlag[iFD] & ELSF_ListeningForInternalServer);
}

void CFDPool::SetListeningForInternalServer(int iFD)
{
	m_auiSocketFlag[iFD] = ELSF_ListeningForInternalServer;
}


bool CFDPool::IsConnectedByExternalClient(int iFD)
{
	return (m_auiSocketFlag[iFD] & ELSF_ConnectedByExternalClient);
}

void CFDPool::SetConnectedByExternalClient(int iFD)
{
	m_auiSocketFlag[iFD] = ELSF_ConnectedByExternalClient;
}

bool CFDPool::IsConnectedByInternalServer(int iFD)
{
	return (m_auiSocketFlag[iFD] & ELSF_ConnectedByInternalServer);
}

void CFDPool::SetConnectedByInternalServer(int iFD)
{
	m_auiSocketFlag[iFD] = ELSF_ConnectedByInternalServer;
}

int CFDPool::AddInternalServerIP(unsigned int uiInternalServerIP, unsigned short ushListenedPort,
	unsigned short ushServerType, unsigned short ushServerID)
{
	return m_stInternalServerPool.AddInternalServerIP(uiInternalServerIP, ushListenedPort, ushServerType, ushServerID);
}

int CFDPool::ClearInternalServerByIPAndPort(unsigned int uiInternalServerIP, unsigned short ushListenedPort)
{
	return m_stInternalServerPool.ClearInternalServerByIPAndPort(uiInternalServerIP, ushListenedPort);
}

TInternalServerSocket* CFDPool::GetInternalSocketByTypeAndID(unsigned short ushServerType, unsigned short ushServerID)
{
	return m_stInternalServerPool.GetSocketByTypeAndID(ushServerType, ushServerID);
}

TInternalServerSocket* CFDPool::GetInternalSocketByInternalServerIP(unsigned int uiInternalServerIP, unsigned short ushListenedPort)
{
	return m_stInternalServerPool.GetSocketByInternalServerIP(uiInternalServerIP, ushListenedPort);
}

TInternalServerSocket* CFDPool::GetInternalSocketByFD(int iFD)
{
	return m_stInternalServerPool.GetSocketByFD(iFD);
}

TExternalClientSocket* CFDPool::GetExternalSocketByFD(int iFD)
{
	return m_stExternalClientPool.GetSocketByFD(iFD);
}

TExternalClientSocket* CFDPool::GetExternalFirstSocket()
{
	return m_stExternalClientPool.GetFirstSocket();
}

int CFDPool::SetDefaultInternalSocket(const unsigned short ushServerType, const unsigned short ushServerID)
{
	return m_stInternalServerPool.SetDefaultSocket(ushServerType, ushServerID);
}

int CFDPool::ClearDefaultInternalSocket()
{
	return m_stInternalServerPool.ClearDefaultSocket();
}

TInternalServerSocket* CFDPool::GetDefaultInternalSocket()
{
	return m_stInternalServerPool.GetDefaultSocket();
}
