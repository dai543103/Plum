#include "BehaviorNode.h"

NodeState BehaviorNode::update()
{
	if(Execute())
	{
		return NODE_SUCCESS;
	}

	return NODE_FAILER;
}