#pragma once
#include "base\Container.h"
#include <list>
#include <vector>

enum NodeState
{
	NODE_INVALID,
	NODE_SUCCESS,	//�ڵ�ִ�гɹ�
	NODE_FAILER,	//ִ��ʧ��
	NODE_RUNNING,	//������
};

//���ڵ㣬ͬʱҲ���������нڵ㣬��Ͻڵ����Ϊ�ڵ�Ļ���
class BTNode
{
public:
	BTNode():m_State(NODE_INVALID){}
	virtual ~BTNode(){}

	//��ʼ��
	virtual void onInitialize(){}
	//����
	virtual void onTerminate()	{}
	//���ڵ��һ�θ���,���ڶ�̬
	virtual NodeState update()=0;

	//һ��tick,���ڵ��һ��ִ��
	NodeState Tick();

	inline bool IsTerminated() const{return m_State ==NODE_SUCCESS || m_State==NODE_FAILER;}
	inline bool IsRunning() const{return m_State==NODE_RUNNING;}
	inline NodeState GetState() const {return m_State;}
	inline void Reset(){m_State=NODE_INVALID};

protected:
	NodeState m_State;

};

//װ����
class DecoratorNode:public BTNode
{
protected:
	DecoratorNode(BTNode* child):m_pChild(child){}
private:
	BTNode* m_pChild;
};

//�ظ�ִ�е���
class RepeatNode:public DecoratorNode
{
public:
	RepeatNode(BTNode* child):DecoratorNode(child){}

	inline void SetCount(int count){m_iLimit=count;}

	inline virtual void onInitialize(){m_iCounter=0;}

	virtual NodeState update();

protected:
	int m_iLimit;	//ִ���ܴ���
	int m_iCounter;  //������
};
