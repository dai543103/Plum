#ifndef __LISTENER_WRAPPER_H__
#define __LISTENER_WRAPPER_H__

enum class emListenStatus
{
	UnListen,
	Listen,
};

class CListenerWrapper
{
public:
	CListenerWrapper();
	~CListenerWrapper();
	
	int Init(unsigned int uiIP, unsigned short ushPort,
		unsigned int uiSendBufferSize, bool bExternalClient);

	int CreateTCPSocket();
	int Bind(unsigned int uiIP, unsigned short ushPort);
	int Listen();


	void SetForEpoll();

	inline int GetFD()
	{
		return m_iListeningSocket;
	}

	unsigned int m_uiIP;
	unsigned short m_ushPort;
	unsigned int m_uiSendBufferSize;
	bool m_bExternalClient;
	emListenStatus m_iState;

private:
	int m_iListeningSocket;
};


#endif

