#pragma once
#include "BTNode.h"

//组合节点
//类似于顺序，选择继承于此，这样的
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
//顺序节点（Sequence）：组合节点，顺序执行子节点，只要碰到一个子节点返回FALSE，则返回FALSE；否则返回TRUE
//类似于and关系
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
//选择节点（Sequence）：组合节点，顺序执行子节点，只要碰到一个子节点返回FALSE，则返回FALSE；否则返回TRUE
//类似于or关系
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
//并行节点（Parallel）：不同于选择和顺序节点依次执行每个节点，并行节点是“同时”执行所有的节点，然后根据所有节点的返回值判断最终返回的结果。

class ParallelNode : public CompositeNode
{
public:
	enum Policy
	{
		POLICY_ONE,	//只有所有的子节点都运行结束，才返回结束。
		POLICY_ALL, //只要有一个子节点运行结束，就返回结束
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




