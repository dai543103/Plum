#pragma comment(lib,"ws2_32.lib")

#include <winsock2.h>
#include <iostream>
using namespace std;

#define BUF_SIZE 1024
#define ECHO_PORT 5566

void ErrorHanding(char* message);

int main()
{
	WSADATA wsaData;
	SOCKET hServSock,hClntSock;
	SOCKADDR_IN servAdr,clntAdr;
	TIMEVAL timeout;
	fd_set reads,cpyReads;

	int adrSz;
	int srtLen,fdNum;
	char buf[BUF_SIZE];

	if(WSAStartup(MAKEWORD(2,2),&wsaData)!=0)
	{
		ErrorHanding("wsastartup error!");
	}

	//����
	hServSock=socket(AF_INET,SOCK_STREAM,0);
	//���õ�ַ
	memset(&servAdr,0,sizeof(servAdr));
	servAdr.sin_family=AF_INET;
	servAdr.sin_addr.s_addr=htonl(INADDR_ANY);
	servAdr.sin_port=htons(ECHO_PORT);

	//��
	if(bind(hServSock,(SOCKADDR*)&servAdr,sizeof(servAdr)))
	{
		ErrorHanding("bind error");
	}

	//����
	if(listen(hServSock,5)==SOCKET_ERROR)
	{
		ErrorHanding("listen error");
	}

	//fd_set��ʼ��
	FD_ZERO(&reads);
	//ע�ᵽfd_set
	FD_SET(hServSock,&reads);

 	while (true)
 	{
 		cpyReads=reads;
 		timeout.tv_sec=5;
		timeout.tv_usec=5000;

		if((fdNum=select(0,&cpyReads,0,0,&timeout))==SOCKET_ERROR)
			break;

		if(fdNum==0)
			continue;

		//��ѯ
		for (UINT i=0;i<reads.fd_count;i++)
		{
			//���Ӽ����������仯
			if(FD_ISSET(reads.fd_array[i],&cpyReads))
			{
				//����������
				if(reads.fd_array[i]==hServSock)
				{
					adrSz=sizeof(clntAdr);
					hClntSock=accept(hServSock,(SOCKADDR*)&clntAdr,&adrSz);

					//���ͻ������ӵ�fdע�ᵽfd_set
					FD_SET(hClntSock,&reads);
					cout<<"connected client:"<<hClntSock<<endl;
				}
				else
				{
					memset(buf,0,BUF_SIZE);
					//��ȡ
					srtLen=recv(reads.fd_array[i],buf,BUF_SIZE-1,0);
					if (srtLen==0)
					{
						FD_CLR(reads.fd_array[i],&reads);
						closesocket(cpyReads.fd_array[i]);
						cout<<"close client:"<<cpyReads.fd_array[i]<<endl;
					}
					else
					{
						//strcat(buf,",from Server������");
						cout<<"�ͻ���˵:           "<<buf<<endl;

						printf("����Ϣ :");   
						scanf("%s", buf);
						send(reads.fd_array[i],buf,strlen(buf),0); //echo
					}
				}
			}
		}
 	}

	closesocket(hServSock);
	WSACleanup();
	return 0;

}

void ErrorHanding(char* message)
{
	fputs(message,stderr);
	fputc('\n',stderr);
	exit(1);
}