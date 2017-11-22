#pragma once;

#define MAX_AI_ACTION 30
#define MAX_AI_CONDITION 30

//AI行为，条件触发接口
typedef bool (*FUNC_AICONDITION)();
typedef bool (*FUNC_AIACTION)();

//管理所有的AI行为和条件
class AIFactory
{
public:
	int RegisterAllAI();

	FUNC_AIACTION GetAIAction(int iAction);
	FUNC_AICONDITION GetAICondition(int iCondition);

protected:
	void RegisterAIAction(int iAction,FUNC_AIACTION pAIAction);
	void RegisterAICondition(int iCondition,FUNC_AICONDITION pAICondition);

private:
	FUNC_AIACTION m_apAIAction[MAX_AI_ACTION];
	FUNC_AICONDITION m_apAICondtion[MAX_AI_CONDITION];

};