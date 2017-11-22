#pragma once
#include "base\Container.h"
#include <list>
#include <vector>

enum NodeState
{
	NODE_INVALID,
	NODE_SUCCESS,	//节点执行成功
	NODE_FAILER,	//执行失败
	NODE_RUNNING,	//运行中
};

//根节点，同时也是其它序列节点，组合节点和行为节点的基类
class BTNode
{
public:
	BTNode():m_State(NODE_INVALID){}
	virtual ~BTNode(){}

	//初始化
	virtual void onInitialize(){}
	//结束
	virtual void onTerminate()	{}
	//本节点的一次更新,用于多态
	virtual NodeState update()=0;

	//一次tick,本节点的一次执行
	NodeState Tick();

	inline bool IsTerminated() const{return m_State ==NODE_SUCCESS || m_State==NODE_FAILER;}
	inline bool IsRunning() const{return m_State==NODE_RUNNING;}
	inline NodeState GetState() const {return m_State;}
	inline void Reset(){m_State=NODE_INVALID};

protected:
	NodeState m_State;

};

//装饰类
class DecoratorNode:public BTNode
{
protected:
	DecoratorNode(BTNode* child):m_pChild(child){}
private:
	BTNode* m_pChild;
};

//重复执行的类
class RepeatNode:public DecoratorNode
{
public:
	RepeatNode(BTNode* child):DecoratorNode(child){}

	inline void SetCount(int count){m_iLimit=count;}

	inline virtual void onInitialize(){m_iCounter=0;}

	virtual NodeState update();

protected:
	int m_iLimit;	//执行总次数
	int m_iCounter;  //计数器
};
