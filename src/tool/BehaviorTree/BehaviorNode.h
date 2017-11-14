#pragma once
#include "BTNode.h"


//条件节点,动作节点
typedef BehaviorNode ConditionNode;
typedef BehaviorNode ActionNode;

//行为节点处理
//行为节点基类，
class BehaviorNode:public BTNode
{
public:
	virtual NodeState update();
protected:
	virtual bool Execute();
};


