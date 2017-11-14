#include "BTNode.h"

NodeState BTNode::Tick()
{
	if(m_State!=NODE_RUNNING)
	{
		onInitialize();
	}
	m_State=update();

	if(m_State!=NODE_RUNNING)
	{
		onTerminate();
	}

	return m_State;
}

NodeState RepeatNode::update()
{
	for (;;)
	{
		m_pChild->Tick();
		if(m_pChild->GetState() == NODE_RUNNING) break;
		if(m_pChild->GetState()==NODE_FAILER) return NODE_FAILER;
		if (++m_iCounter==m_iLimit) return NODE_SUCCESS;
		m_pChild->Reset();
	}

	return NODE_INVALID;
}
