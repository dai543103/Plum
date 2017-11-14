#pragma once
#include "BTNode.h"

//��Ͻڵ�
//������˳��ѡ��̳��ڴˣ�������
class CompositeNode:public BTNode
{
public:
	void AddChild(BTNode* child) {m_Children.push_back(child);}
	void RemoveChild(BTNode* child);
	void ClearChild(){m_Children.clear();}

protected:
	typedef std::vector<BTNode*> BTNodes;
	BTNodes m_Children;
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//˳��ڵ㣨Sequence������Ͻڵ㣬˳��ִ���ӽڵ㣬ֻҪ����һ���ӽڵ㷵��FALSE���򷵻�FALSE�����򷵻�TRUE
//������and��ϵ
class SequenceNode:public CompositeNode
{
public:
	virtual ~SequenceNode(){}

	virtual void onInitialize(){m_CurrentIndex=m_Children.begin();}
	virtual void onTerminate();
	virtual NodeState update();

private:
	BTNodes::iterator m_CurrentIndex;
};

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//ѡ��ڵ㣨Sequence������Ͻڵ㣬˳��ִ���ӽڵ㣬ֻҪ����һ���ӽڵ㷵��FALSE���򷵻�FALSE�����򷵻�TRUE
//������or��ϵ
class SelectNode:public CompositeNode
{
public:
	virtual ~SelectNode(){}

	virtual void onInitialize(){m_CurrentIndex=m_Children.begin();}
	virtual void onTerminate();
	virtual NodeState update();

private:
	BTNodes::iterator m_CurrentIndex;
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//���нڵ㣨Parallel������ͬ��ѡ���˳��ڵ�����ִ��ÿ���ڵ㣬���нڵ��ǡ�ͬʱ��ִ�����еĽڵ㣬Ȼ��������нڵ�ķ���ֵ�ж����շ��صĽ����

class ParallelNode : public CompositeNode
{
public:
	enum Policy
	{
		POLICY_ONE,	//ֻ�����е��ӽڵ㶼���н������ŷ��ؽ�����
		POLICY_ALL, //ֻҪ��һ���ӽڵ����н������ͷ��ؽ���
	};

	ParallelNode(Policy successPolicy,Policy failerPolicy)
		:m_eSuccessPolicy(successPolicy),m_eFailerPolicy(failerPolicy){}

	virtual ~ParallelNode(){}

	virtual NodeState update();

	virtual void onTerminate();
	
protected:
	Policy m_eSuccessPolicy;
	Policy m_eFailerPolicy;
};




