#include "AIFactory.h"

int AIFactory::RegisterAllAI()
{
	memset(m_apAIAction,0,sizeof(m_apAIAction));
	memset(m_apAICondtion,0,sizeof(m_apAICondtion));

	//×¢²á·½·¨
	//...
}


FUNC_AIACTION AIFactory::GetAIAction(int iAction)
{
	if(iAction>=0 &&iAction<MAX_AI_ACTION)
	{
		return m_apAIAction[iAction];
	}

	return NULL;
}

FUNC_AICONDITION AIFactory::GetAICondition(int iCondition)
{
	if(iCondition>=0 &&iCondition<MAX_AI_CONDITION)
	{
		return m_apAICondtion[iCondition];
	}

	return NULL;
}

void AIFactory::RegisterAIAction(int iAction,FUNC_AIACTION pAIAction)
{
	if(iAction>=0 &&iAction<MAX_AI_ACTION)
	{
		m_apAIAction[iAction]=pAIAction;
	}
}

void AIFactory::RegisterAICondition(int iCondition,FUNC_AICONDITION pAICondition)
{
	if (iCondition>=0&&iCondition<MAX_AI_CONDITION)
	{
		m_apAICondtion[iCondition]=pAICondition;
	}
}