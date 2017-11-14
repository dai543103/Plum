#ifndef __SCENE_PATH_MAP_H__
#define __SCENE_PATH_MAP_H__

// ��󳡾��ߴ�
const int MAX_SCENE_X = 1000;
const int MAX_SCENE_Y = 1000;
const int MIN_SCENE_BLOCK_SIZE = 1;
const int MAX_SCENE_BLOCK_X = (MAX_SCENE_X / MIN_SCENE_BLOCK_SIZE);
const int MAX_SCENE_BLOCK_Y = (MAX_SCENE_Y / MIN_SCENE_BLOCK_SIZE);


#define MAX_PATH_NODE (MAX_SCENE_BLOCK_X * MAX_SCENE_BLOCK_Y)
#define MAX_PINBLOCK_DATA                (((1+(MAX_SCENE_X/MIN_SCENE_BLOCK_SIZE))*(1+MAX_SCENE_Y/MIN_SCENE_BLOCK_SIZE)) / 8 )
#define ABS(a,b)                         (((unsigned int) (a) > (unsigned int)(b)) ? ((a) - (b)) : ((b) - (a)))
#define MAX_POSITION_NUMBER_IN_PATH      1000
#define MIN_GRID_SIZE                    0.5
#define DEFAULT_GRID_SIZE                1.0f
#define BLOCK_FILE_VERSION               1

typedef struct tagUnitPosition
{
	float m_uiX;                  
	float m_uiY; 
}TUnitPosition;

typedef struct tagUnitPath
{
	unsigned char m_iNumber;               	/*   λ������ */
	TUnitPosition m_astPosition[MAX_POSITION_NUMBER_IN_PATH];
}TUnitPath;

enum PathError
{
	PathError_None = 0,

	PathError_NoFile = -1,
	PathError_SceneName = -2,
	PathError_Invalid_GridSize = -3,
	PathError_Invalid_Column_Row_Count = -4,
	PathError_Invalid_Format = -5,
	PathError_Invalid_File_Length = -6 ,
	PathError_Invalid_Version = - 7
};

struct MAPINFO 
{
	//fourcc
	int m_fourcc;

	//�汾��
	int m_Version;
	//����id
	int m_iSceneID;

	//���Ӵ�С
	float m_iGridSize;

	// �����ĳߴ�
	short m_iWidthPixels;
	short m_iHeightPixels;

	void Reset()
	{
		m_iWidthPixels = m_iHeightPixels = 0;
		m_iGridSize = 1 ;
	}
};

// A* �㷨����
struct tagSceneBlock;

typedef struct tagAStarNode
{
	unsigned short iValueG;
	unsigned short iValueF;   // FGHֵ

	bool bClosed;  // �Ƿ��ڷ������
	bool bOpened;  // �Ƿ��ڿ�������

	tagSceneBlock *pstCenterNode; // ���Ľڵ�

	void reset()
	{
		bClosed=false;
		bOpened=false;
		iValueG=0;
		iValueF=0;
		pstCenterNode=NULL;
	}

}TAStarNode;

// ��ͼ��
typedef struct tagSceneBlock
{
	int   iWalkable;      // �Ƿ������
	int   iSafeZone;      // �Ƿ��ǰ�ȫ����Ĭ�ϲ��ǰ�ȫ��
	unsigned short iBlockIndex;      // ��㼶, ��0������С�����ߵ�λ, ��1������4��0����, ��2������4��1����, ��������
	unsigned short iFirstBlock;      // ��ʼ��0�������

	TAStarNode stAStar;   
}TSceneBlock;



// ·������С�ѣ��Ż�A*�㷨�Ŀ����б�


class CPathMinHeap
{
public:
	CPathMinHeap();

	void Initialize();

	// ����·����С�ĵ�
	TSceneBlock *PopHeap();

	// ѹ��һ��·����
	bool PushHeap(TSceneBlock *pstSceneBlock);

	// �ж��Ƿ񻺳�����
	bool IsHeapFull();

private:
	bool InsertHeap(TSceneBlock *pstSceneBlock, int iPosition);

private:
	int m_iOpenNodes;
//	int m_iCloseNodes;
	TSceneBlock *m_astOpenNode[MAX_PATH_NODE];
//	tagSceneBlock *m_astCloseNode[MAX_PATH_NODE];
};

class CScenePathManager
{
public:
	~CScenePathManager();
	//��ʼ��·��ͼ
	int Initalize(const char* blockFileName);

	int GetSceneSize(int& iWidthPixels, int& iHeightPixels);

	int GetSceneBlocks(int& iWidthBlocks, int& iHeightBlocks);

	int GetSceneID();

	// ��ȫ����ʼ��
	int InitSafeZone( char * pSceneSafeZone, int iSceneID ) ;

public:
	bool CheckPoint(float x,float y);
	bool CheckPath(float x1,float y1,float x2,float y2);
	bool FindPath(float x1,float y1,float x2,float y2,TUnitPath &rstPath);
	//�ڵ�ͼ��Ѱ����Ŀ�����ֱ�߾���������ĵ�;,z
	void FindCross( float x1, float y1, float x2, float y2, float* px, float* py ){}
	//�����赲Ƭ;
	void EnableGroupFunc(const wchar_t* name, unsigned int enable){}

public:

	// �Ƿ��ǰ�ȫ������
	bool IsSafeZone(const TUnitPosition &rstPosition);

	// ��֤·����ɴ�
	bool CanWalk(const TUnitPosition &rstPosition, char * pPinDynBlockData = NULL);

	// ��֤����֮���Ƿ�ɴ� ֱ��
	// bIgnoreEnd: �Ƿ�����յ����ꡣ��Ϊ��λ���ƶ������У� ���ܡ��������赲�ϣ� ���Լ����赲�ж�ʱ����֮��
	bool CanWalk(const TUnitPosition &rstStartPosition, const TUnitPosition &rstEndPosition, bool bIgnoreEnd = false, bool bFromRobot = false, char * pPinDynBlockData = NULL);

	// ·����֤
	bool CanWalk(const TUnitPosition &rstStartPosition, const TUnitPath &rstPath, char * pPinDynBlockData = NULL, int * piValidPos = NULL);

	// A* �㷨Ѱ·
	bool FindPathSlow(const TUnitPosition &rstStartPosition, 
		const TUnitPosition &rstEndPosition, 
		TUnitPath &rstPath);

	void OptimizePath(const TUnitPosition &rstStartPosition, TUnitPath &rstPath);

	// �ж��ǲ����赲��
	bool IsDynBlockMask(const TUnitPosition& rstPosition, char * pData); 

	// �ж��ǲ����赲��
	bool IsDynBlockMask(int iBlockX, int iBlockY, char * pData); 

private:
	void ResetAstar();
	//�����赲
	int LoadBlock();
	// ���ں� 
	void MergeSceneBlock();

	// ֱ�߷��̱ƽ���֤ 
	bool CanWalkSlow(int iStartBlockX, int iStartBlockY, int iEndBlockX, int iEndBlockY, bool bIgnoreEnd = false, char * pPinDynBlockData = NULL);

	// A* ����ڵ�Ȩֵ
	int AStarCountNode(int iX, int iY, int iEndX, int iEndY, TSceneBlock *pstCenterBlock);

	// A* ·���Ż�
	void OptimizeAStarPath(const TUnitPosition &rstStartPosition, TUnitPath &rstPath);

	inline int Position2Block(float x){return x * m_blockCountPerUnit;}

public:
	MAPINFO m_mapinfo;
	int m_iSceneID;

	// �����ĳߴ�
	int m_iWidthPixels;
	int m_iHeightPixels;

	int m_iWidthBlocks;
	int m_iHeightBlocks;

	// ���·���ںϲ���
	int m_iMaxBlockIndex;   

	// ·����
	TSceneBlock* m_astSceneBlock;

	// A* ��С��
	static CPathMinHeap m_stPathMinHeap;

	float m_blockCountPerUnit;

	char *m_blockData;
};

#define BLOCK_X(pBlock) ( ((pBlock) - &m_astSceneBlock[0]) % (m_iWidthBlocks) )
#define BLOCK_Y(pBlock) ( ((pBlock) - &m_astSceneBlock[0]) / (m_iWidthBlocks) )

#endif

