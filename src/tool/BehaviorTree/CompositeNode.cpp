#include "CompositeNode.h"


void CompositeNode::RemoveChild(BTNode* child)
{
	for(BTNodes::iterator it=m_Children.begin();it!=m_Children.end();it++)
	{
		if(child==*it)
		{
			it = m_Children.erase(it);
		}
		else
		{
			++it;
		}
	}
}

NodeState SequenceNode::update()
{
	//˳��ִ�У�ֻҪ������һ��ʧ�ܾͷ���ʧ��
	for (;;)
	{
		NodeState s = (*m_CurrentIndex)->Tick();

		if (s != NODE_SUCCESS)
		{
			return s;
		}

		if (++m_CurrentIndex == m_Children.end())
		{
			return NODE_SUCCESS;
		}
	}
}

NodeState SelectNode::update()
{
	//˳������ִ�У�ֻҪ������һ���ɹ��ͷ��سɹ�
	for (;;)
	{
		NodeState s = (*m_CurrentIndex)->Tick();

		if (s != NODE_FAILER)
		{
			return s;
		}

		if (++m_CurrentIndex == m_Children.end())
		{
			return NODE_FAILER;
		}
	}
}

NodeState ParallelNode::update()
{
	size_t iSuccessCount=0;
	size_t iFailerCount=0;
	
	for(BTNodes::iterator it=m_Children.begin();it!=m_Children.end();++it)
	{
		if(!(*it)->IsTerminated())
		{
			(*it)->Tick();
		}

		if((*it)->GetState()==NODE_SUCCESS)
		{
			++iSuccessCount;
			if(m_eSuccessPolicy==POLICY_ONE)
			{
				return NODE_SUCCESS;
			}
		}

		if((*it)->GetState()==NODE_FAILER)
		{
			++iSuccessCount;
			if(m_eFailerPolicy==POLICY_ONE)
			{
				return NODE_FAILER;
			}
		}
	}

	if (m_eSuccessPolicy==POLICY_ALL && iSuccessCount==m_Children.size())
	{
		return NODE_SUCCESS;
	}

	if (m_eFailerPolicy==POLICY_ALL && iFailerCount==m_Children.size())
	{
		return NODE_FAILER;
	}

	return NODE_RUNNING;
}

void ParallelNode::onTerminate()
{
	for(BTNodes::iterator it=m_Children.begin();it!=m_Children.end();++it)
	{
		if(!(*it)->IsRunning())
		{
			(*it)->Abort();
		}
	}
}