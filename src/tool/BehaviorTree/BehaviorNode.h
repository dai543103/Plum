#pragma once
#include "BTNode.h"


//�����ڵ�,�����ڵ�
typedef BehaviorNode ConditionNode;
typedef BehaviorNode ActionNode;

//��Ϊ�ڵ㴦��
//��Ϊ�ڵ���࣬
class BehaviorNode:public BTNode
{
public:
	virtual NodeState update();
protected:
	virtual bool Execute();
};


