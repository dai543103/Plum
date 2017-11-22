/**
*@brief �����ඨ��
*
*	�õ������ʵ���ǽ��������ʵ������Ϊstatic���ڷ��������ʱ���ö�̬����ķ�ʽ��
*	��Ҫע��������ȱ�㣺
*	��1�����ʺ����ڶ��̵߳�����´�����������
*	��2�����ʺ�����Ҫ�ڳ��������ʱ����þ��������������
*/

#ifndef __SINGLETON_TEMPLATE_HPP__
#define __SINGLETON_TEMPLATE_HPP__

//������ӱ�׼��ͷ�ļ�
#include <stdio.h>
#include <stdlib.h>


template <class TYPE>
class CSingleton
{
public:
	static TYPE* Instance(void)
	{
		if(m_pSingleton == NULL)
		{
			m_pSingleton = new CSingleton;
		}
		return &m_pSingleton->m_stInstance;
	}
protected:
	CSingleton() {}
protected:
	TYPE m_stInstance;
	static CSingleton<TYPE>* m_pSingleton;
};

template <class TYPE>
CSingleton<TYPE>* CSingleton<TYPE>::m_pSingleton = NULL;

#endif 
