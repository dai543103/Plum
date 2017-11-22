#include <unistd.h>
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <sys/socket.h>
#include <fcntl.h>
#include <string.h>
#include <stdio.h>
#include <errno.h>
#include "EpollWrapper.h"
#include "common/logger.h"


int CEpollWrapper::EpollCreate(int iFDSize)
{
	m_iEpollEventSize = iFDSize;
	m_iEpollFD = epoll_create(m_iEpollEventSize);
	if(m_iEpollFD < 0)
	{
		return -1;
	}

	memset(&m_stOneEpollEvent, 0, sizeof(m_stOneEpollEvent));
	m_stOneEpollEvent.events = EPOLLIN | EPOLLERR | EPOLLHUP;
	m_stOneEpollEvent.data.ptr = nullptr;
	m_stOneEpollEvent.data.fd  = -1;

	return 0;
}

int CEpollWrapper::EpollWait()
{
	auto iEpollEventNumber = epoll_wait(m_iEpollFD, &m_astEpollEvent[0], m_iEpollEventSize, m_iEpollWaitingTime);
	if(iEpollEventNumber < 0)
	{
		if (errno != EINTR)
		{
			SPDLOG_ERROR("epoll_wait Err!Errno={},ErrStr={}\n", errno, strerror(errno));
		}

		return -1;
	}

	int iFD;
	uint32_t  uiEpollEvent;
	for (int i = 0; i < iEpollEventNumber; ++i)
	{
		iFD = m_astEpollEvent[i].data.fd;
		uiEpollEvent = m_astEpollEvent[i].events;

		if (IsReadEvent(uiEpollEvent))
		{
			m_pfRead(iFD);
		}
		else if (IsWriteEvent(uiEpollEvent))
		{
			m_pfWrite(iFD);
		}
		else if (IsErrorEvent(uiEpollEvent))
		{
			m_pfError(iFD);
		}
	}

	return 0;
}

int CEpollWrapper::EpollAdd(int iFD)
{
	m_stOneEpollEvent.data.fd = iFD;
	return epoll_ctl(m_iEpollFD, EPOLL_CTL_ADD, iFD, &m_stOneEpollEvent);
}

int CEpollWrapper::EpollDelete(int iFD)
{
	return epoll_ctl(m_iEpollFD, EPOLL_CTL_DEL, iFD, &m_stOneEpollEvent);
}

//设置非阻塞
int CEpollWrapper::SetNonBlock(int iFD)
{
	int iFlags;
	iFlags = fcntl(iFD, F_GETFL, 0);
	iFlags |= O_NONBLOCK;
	fcntl(iFD, F_SETFL, iFlags);

	return 0;
}

//Nagle算法，用在小包处理
int CEpollWrapper::SetNagleOff(int iFD)
{
    /* Disable the Nagle (TCP No Delay) algorithm */ 
    int flag = 1; 
    setsockopt(iFD, IPPROTO_TCP, TCP_NODELAY, (char *)&flag, sizeof(flag));

    return 0;
}
