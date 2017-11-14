#include <stdio.h>  
#include <stdlib.h>  
#include <winsock2.h>  
#include <iostream>
using namespace std;
#pragma comment(lib,"ws2_32.lib")


#define CLIENT_IP 127.0.0.1
#define SERVER_PORT 5566  
#define BUFFER_SIZE 1024  
#define MAX_ADDR_LEN 128  

int nPort = SERVER_PORT;  
char szBuffer[BUFFER_SIZE];  
char szAddr[MAX_ADDR_LEN];  

void usage(void);  
void checkArgv(int argc, char **argv);  

int main(int argc, char *argv[])  
{  
	int nRet, nLen, nAddrLen, i;  
	SOCKET s;  
	SOCKADDR_IN sa;  

	WSAData wsaData;  
	WORD wVersion = MAKEWORD(2,2);  

	checkArgv(argc, argv);  

	nRet = WSAStartup(wVersion, &wsaData);  
	if (SOCKET_ERROR == nRet)  
	{  
		printf("Socket init error/n");  
		return 1;  
	}  

	s = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);  
	if (INVALID_SOCKET == s)  
	{  
		printf("Socket was created failse:%d/n", WSAGetLastError());  
		closesocket(s);  
		WSACleanup();  
		return 1;  
	}  

	nAddrLen = sizeof(SOCKADDR_IN);  
	memset(&sa, 0, nAddrLen);  
	sa.sin_family = AF_INET;  
	sa.sin_port   = htons(nPort);  
	sa.sin_addr.s_addr = inet_addr("127.0.0.1");  

	nRet = connect(s, (LPSOCKADDR)&sa, nAddrLen);  
	if (SOCKET_ERROR == nRet)  
	{  
		printf("socket connect() failse:%d/n", WSAGetLastError());  
		closesocket(s);  
		WSACleanup();  
		return 1;  
	}  

	for(;;)  
	{  
		printf("发消息:");  
		memset(szBuffer, 0, BUFFER_SIZE);  
		nRet = scanf("%s", szBuffer);  
		if (BUFFER_SIZE < nRet)  
		{  
			szBuffer[BUFFER_SIZE-1] = '/0';  
		}  
		if (0 == strcmp("quit",szBuffer)) break;        //输入QUIT退出当前客户端  
		nRet = send(s, szBuffer, strlen(szBuffer), 0);  
		if (SOCKET_ERROR == nRet)  
		{  
			printf("Socket send() failse:%d/n", WSAGetLastError());  
			break;  
		}  
 		memset(szBuffer, 0, BUFFER_SIZE);  
 		nRet = recv(s, szBuffer, BUFFER_SIZE, 0);  
		cout<<"服务器说:"<<szBuffer<<endl;
 		//printf("Server ECHO back:%s/n", szBuffer);  
	}  


	closesocket(s);  
	WSACleanup();  
	return 0;  
}  

void usage(void)  
{  
	printf("usage: selectecho.exe -i:127.0.0.1 [-p:5566]/n");  
	printf("/t-i:服务器地址/n");  
	printf("/t-p:服务器端口号， 在1024到65535之间/n");  
	ExitProcess(1);  
}  

void checkArgv(int argc, char **argv)  
{  
	int i;  
	memset(szAddr, 0, MAX_ADDR_LEN);  
	for(i = 1; i < argc; i++)  
	{  
		if(('/' == argv[i][0]) || ('-' == argv[i][1]))  
		{  
			switch(tolower(argv[i][1]))  
			{  
			case 'p':  
				nPort = atoi(&argv[i][3]);  
				break;  
			case 'i':  
				strcpy(szAddr, &argv[i][3]);  
				printf("%s", argv[i][3]);  
				break;  
			default:  
				usage();  
				break;  
			}  
		}  
	}  
}  