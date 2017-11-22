#ifndef __EPOLL_WRAPPER_H__
#define __EPOLL_WRAPPER_H__

#include <sys/epoll.h>
#include <assert.h>
#include <functional>
#include "PlumDefine.h"


/************************************************************************/
/* epoll模型的简单封装
*/
/************************************************************************/
class CEpollWrapper
{
public:
	int EpollCreate(int iFDSize);
	int EpollWait();

	int EpollAdd(int iFD);
	int EpollDelete(int iFD);

	int SetNonBlock(int iFD);
    int SetNagleOff(int iFD);

	inline void SetEpollWaitingTime(int iEpollWaitingTime)
	{
		m_iEpollWaitingTime = iEpollWaitingTime;
	}

	inline void SetHandler_Error(std::function<int(int)> pfError)
	{
		m_pfError = pfError;
	}

	inline void SetHandler_Read(std::function<int(int)> pfRead)
	{
		m_pfRead = pfRead;
	}

	inline void SetHandler_Write(std::function<int(int)> pfWrite)
	{
		m_pfWrite = pfWrite;
	}

private:

	bool IsErrorEvent(unsigned int uiEvent)
	{
		return (EPOLLERR | EPOLLHUP) & uiEvent;
	}

	inline bool IsReadEvent(unsigned int uiEvent)
	{
		return (EPOLLIN)& uiEvent;
	}

	bool IsWriteEvent(unsigned int uiEvent)
	{
		return (EPOLLOUT)& uiEvent;
	}

private:
	int m_iEpollFD;
	int m_iEpollEventSize;
	int m_iEpollWaitingTime;

	epoll_event m_astEpollEvent[FD_SIZE];
	epoll_event m_stOneEpollEvent; 

	std::function<int(int)> m_pfError;
	std::function<int(int)> m_pfRead;
	std::function<int(int)> m_pfWrite;

};

#endif
