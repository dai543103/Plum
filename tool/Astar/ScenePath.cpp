#include "stdafx.h"
#include "ScenePathManager.h"
#include <string.h>
#include <stdlib.h>

// Ѱ·��ʱ·��������
static int g_iTempPathNumber;
static const int MAX_TEMP_PATH_NUMBER = 1024;
static TUnitPosition g_astTempPosition[MAX_TEMP_PATH_NUMBER];
CPathMinHeap CScenePathManager::m_stPathMinHeap;


int CScenePathManager::GetSceneID()
{
    return m_iSceneID;
}


int CScenePathManager::GetSceneSize(int& iWidthPixels, int& iHeightPixels)
{
    iWidthPixels = m_iWidthPixels;
    iHeightPixels = m_iHeightPixels;

    return 0;
}

int CScenePathManager::GetSceneBlocks(int& iWidthBlocks, int& iHeightBlocks)
{
    iWidthBlocks = m_iWidthBlocks;
    iHeightBlocks = m_iHeightBlocks;

    return 0;
}

CScenePathManager::~CScenePathManager()
{
	free(m_blockData);
}

int CScenePathManager::Initalize(const char* blockFileName)
{
	int iSize;
	// ���ļ�
	FILE *pSceneFile = ::fopen(blockFileName, "rb");
// 	FILE *pSceneFile; 
// 	fopen_s(&pSceneFile,blockFileName, "rb");
	if(!pSceneFile)
	{
		return PathError_NoFile;
	}

	//fourcc��ID���汾
	fread(&m_mapinfo.m_fourcc,sizeof(int),1,pSceneFile);

	//todo ,check block file version
	iSize=fread(&m_mapinfo.m_Version, sizeof(int), 1, pSceneFile);
	iSize=fread(&m_mapinfo.m_iSceneID, sizeof(int), 1, pSceneFile);

	// ��ͼ�ߴ�
	iSize = fread(&m_mapinfo.m_iWidthPixels, sizeof(unsigned short), 1, pSceneFile);
	iSize = fread(&m_mapinfo.m_iHeightPixels, sizeof(unsigned short), 1, pSceneFile);

	//ÿ�����Ӷ������ص�
	iSize=fread((float*)&m_mapinfo.m_iGridSize,sizeof(float),1,pSceneFile);	
	if (m_mapinfo.m_iGridSize < MIN_GRID_SIZE)
	{
		m_mapinfo.Reset();
		::fclose(pSceneFile);
		return PathError_Invalid_GridSize;
	}

	m_iSceneID = m_mapinfo.m_iSceneID;

	m_iWidthPixels = m_mapinfo.m_iWidthPixels;
	m_iHeightPixels = m_mapinfo.m_iHeightPixels;

	m_blockCountPerUnit=1.0/m_mapinfo.m_iGridSize;
	m_iWidthBlocks = Position2Block(m_iWidthPixels); 
	m_iHeightBlocks = Position2Block(m_iHeightPixels); 

	// �赲����
	int iPathBlockLength=m_iWidthBlocks*m_iHeightBlocks;
	m_blockData = (char *)::malloc(iPathBlockLength);
	iSize = ::fread(m_blockData, iPathBlockLength, 1, pSceneFile);
	::fclose(pSceneFile);

	LoadBlock();
	return PathError_None;
}

int CScenePathManager::LoadBlock()
{
	m_astSceneBlock = new TSceneBlock[m_iWidthBlocks * m_iHeightBlocks];

    int iX, iY;
    for (iY = 0; iY < m_iHeightBlocks; iY++)
    {
        for (iX = 0; iX < m_iWidthBlocks; iX++)
        {
			int iBlock = iY * m_iWidthBlocks + iX;
            m_astSceneBlock[iBlock].iFirstBlock = iBlock;

            m_astSceneBlock[iBlock].iSafeZone = 0;  // Ĭ�϶����ǰ�ȫ��
            if (m_blockData[iBlock] == 0)
            {
                m_astSceneBlock[iBlock].iWalkable = 1 ;
            }
            else
            {
                m_astSceneBlock[iBlock].iWalkable = 0 ;
            }
            m_astSceneBlock[iBlock].iBlockIndex = 0; 
			m_astSceneBlock[iBlock].stAStar.reset();
        }
    }
    
    m_iMaxBlockIndex = 0;
    MergeSceneBlock();

    return 0;
}

/***********************************************************
  ��ʼ����ȫ��
 **********************************************************/
int CScenePathManager::InitSafeZone( char * pSceneSafeZone, int iSceneID ) 
{
    int iX, iY;
    for (iY = 0; iY < m_iHeightBlocks; iY++)
    {
        for (iX = 0; iX < m_iWidthBlocks; iX++)
        {
			int iBlock = iY * m_iWidthBlocks + iX;
            if (pSceneSafeZone[iBlock] == 0)
            {
                m_astSceneBlock[iBlock].iSafeZone = 0 ;
            }
            else
            {
                m_astSceneBlock[iBlock].iSafeZone = 1 ;
            }
        }
    }

    return 0 ;
}

//�ں��ĸ����ڵĿ飬�γ�һ�����, �����ϵݹ���ȥ��ֱ�������ں�
void CScenePathManager::MergeSceneBlock()
{
    // ʹ�þ�̬������ֹ�ݹ��ջ��� 
    static int iMerged;
    static int iBlockSize;
    static int iWidthBlocks;
    static int iHeightBlocks;
    static int iX, iY;
    
    // �ںϵĿ�������������0����ʾ�ںϹ��̽��� 
    iMerged = 0;

    // ��ǰ�㼶�¿�Ĵ�С 
    m_iMaxBlockIndex++;
    iBlockSize = 1 << m_iMaxBlockIndex;

    // ��ǰ�㼶�µĿ���Ŀ 
    iWidthBlocks = m_iWidthBlocks / iBlockSize;
    iHeightBlocks = m_iHeightBlocks / iBlockSize;

    for (iY = 0; iY < iHeightBlocks; iY++)
    {
        for (iX = 0; iX < iWidthBlocks; iX++)
        {
            // �����ں�һ����� 
            int iFirstBlockX = iX * iBlockSize;
            int iFirstBlockY = iY * iBlockSize;
            int iFirstBlock = iFirstBlockY * m_iWidthBlocks + iFirstBlockX;

            int iBlockWalkable;
            int iBlockX, iBlockY;
            for (iBlockY = 0; iBlockY < iBlockSize; iBlockY++)
            {
                for (iBlockX = 0; iBlockX < iBlockSize; iBlockX++)
                {
					int iBlockIndex = (iFirstBlockY + iBlockY) * m_iWidthBlocks + (iFirstBlockX + iBlockX);
                    iBlockWalkable = m_astSceneBlock[iBlockIndex].iWalkable;
                    if (iBlockWalkable == 0)
                    {
                        break;
                    }
                }

                if (iBlockWalkable == 0)
                {
                    break;
                }
            }

            if (iBlockWalkable == 0)
            {
                continue;
            }

            // �ں�����С�鵽��� 
            for (iBlockY = 0; iBlockY < iBlockSize; iBlockY++)
            {
                for (iBlockX = 0; iBlockX < iBlockSize; iBlockX++)
                {
					int iBlockIndex = (iFirstBlockY + iBlockY) * m_iWidthBlocks + (iFirstBlockX + iBlockX);
                    TSceneBlock &block = m_astSceneBlock[iBlockIndex];
                    block.iBlockIndex = m_iMaxBlockIndex;
                    block.iFirstBlock = iFirstBlock;
                }
            }

            iMerged++;
        }
    }

    if (iMerged >= 4)
    {
        return MergeSceneBlock();
    }

 /*   LOGDEBUG("Map blocks merged %d times\n", m_iMaxBlockIndex - 1);*/

    return;
}


bool CScenePathManager::CanWalk(const TUnitPosition &rstStartPosition, const TUnitPath &rstPath, char * pPinDynBlockData, int * piValidPos)
{
    if (rstPath.m_iNumber <= 0 || rstPath.m_iNumber >= MAX_POSITION_NUMBER_IN_PATH)
    {
        return false;
    }

    if (!CanWalk(rstStartPosition, rstPath.m_astPosition[0], false, false, pPinDynBlockData))
    {
        return false;
    }

    for (int i = 0; i < rstPath.m_iNumber - 1; i++)
    {
        if (!CanWalk(rstPath.m_astPosition[i], rstPath.m_astPosition[i+1], false, false, pPinDynBlockData))
        {
            if (piValidPos)
            {
                *piValidPos = i ;
            }

            return false;
        }
    }

    return true;
}

// �Ƿ��ڰ�ȫ��
bool CScenePathManager::IsSafeZone(const TUnitPosition &rstPosition)
{
    int iBlockX = Position2Block(rstPosition.m_uiX);
    int iBlockY = Position2Block(rstPosition.m_uiY);

    if (iBlockX < 0 || iBlockX >= m_iWidthBlocks || 
        iBlockY < 0 || iBlockY >= m_iHeightBlocks)
    {
        return false;
    }

    return m_astSceneBlock[iBlockY * m_iWidthBlocks + iBlockX].iSafeZone != 0;
}

bool CScenePathManager::IsDynBlockMask(const TUnitPosition& rstPosition, char * pData)
{
    if (!pData)
    {
        return false; 
    }

    int iBlockX = Position2Block(rstPosition.m_uiX);
    int iBlockY = Position2Block(rstPosition.m_uiY);

    return IsDynBlockMask(iBlockX, iBlockY, pData) ;
}

bool CScenePathManager::IsDynBlockMask(int iBlockX, int iBlockY, char * pData)
{
    if (!pData)
    {
        return false; 
    }

    int iBlock  = iBlockY * m_iWidthBlocks + iBlockX;

    int iPos = iBlock / 8;
    int iBit = iBlock % 8;
    unsigned char ucFlag = (1 << (iBit)) ;

    if (iPos > MAX_PINBLOCK_DATA)
    {
        return false ;  
    }

    bool bRet = (pData[iPos] & ucFlag) ; 
    return bRet;
}



bool CScenePathManager::CanWalk(const TUnitPosition &rstPosition, char * pPinDynBlockData)
{
    int iBlockX = Position2Block(rstPosition.m_uiX);
    int iBlockY = Position2Block(rstPosition.m_uiY);

    if (iBlockX < 0 || iBlockX >= m_iWidthBlocks || 
        iBlockY < 0 || iBlockY >= m_iHeightBlocks)
    {
        return false;
    }

    // �����¶�̬�赲��
    if (pPinDynBlockData && IsDynBlockMask(rstPosition, pPinDynBlockData))
    {
        return false ;   // �����ߡ�
    }

    return m_astSceneBlock[iBlockY * m_iWidthBlocks + iBlockX].iWalkable != 0;
}
   
bool CScenePathManager::CanWalk(const TUnitPosition &rstStartPosition,
								const TUnitPosition &rstEndPosition, bool bIgnoreEnd, bool bFromRobot, char * pPinDynBlockData)
{
    int iStartBlockX = Position2Block(rstStartPosition.m_uiX);
    int iStartBlockY = Position2Block(rstStartPosition.m_uiY);

    int iEndBlockX = Position2Block(rstEndPosition.m_uiX);
    int iEndBlockY = Position2Block(rstEndPosition.m_uiY);

    if (iStartBlockX < 0 || iStartBlockX >= m_iWidthBlocks 
        || iStartBlockY < 0 || iStartBlockY >= m_iHeightBlocks
        || iEndBlockX < 0 || iEndBlockX >= m_iWidthBlocks 
        || iEndBlockY < 0 || iEndBlockY >= m_iHeightBlocks)
    {
        return false;
    }

    TSceneBlock &stStartBlock = m_astSceneBlock[iStartBlockY * m_iWidthBlocks + iStartBlockX];
    TSceneBlock &stEndBlock = m_astSceneBlock[iEndBlockY * m_iWidthBlocks + iEndBlockX];


    // ���Ż�����н�·���ϻᡱ�䡱���������ߵĵ㣬���Զ���㲻���ж�, ֻ�ж��յ�
    if (!bIgnoreEnd && stEndBlock.iWalkable == 0)
    {
        return false;
    }

    // �����յ���һ������У� �ж�̬�赲�Ļ�������Գ������Ż��㷨��Ч��
    if (stStartBlock.iFirstBlock == stEndBlock.iFirstBlock && !pPinDynBlockData)
    {
        return true;
    }

    // ����ֱ�߷��̽��м�� 
    return CanWalkSlow(iStartBlockX, iStartBlockY, iEndBlockX, iEndBlockY, bIgnoreEnd, pPinDynBlockData);
}


bool CScenePathManager::CanWalkSlow(int iStartBlockX, int iStartBlockY, 
									int iEndBlockX, int iEndBlockY,
									bool bIgnoreEnd, char * pPinDynBlockData) 
{
	if ((iStartBlockX == iEndBlockX)&&(iStartBlockY == iEndBlockY))
	{
		return true;
	}
    // ����X�Ჽ������Y�Ჽ��
    int iWidthBlocks = ABS(iEndBlockX, iStartBlockX);
    int iHeightBlocks = ABS(iEndBlockY, iStartBlockY);

	if (bIgnoreEnd)
	{
		iWidthBlocks--;
		iHeightBlocks--;
	}

    bool bStepX = iWidthBlocks >= iHeightBlocks;

    // X��Y�������ӻ��Ǽ���
    bool bGrowX = iEndBlockX > iStartBlockX;
    bool bGrowY = iEndBlockY > iStartBlockY;

    // ����ֱ�����˵�Ϊ���ӵ���������
    int iStartX = iStartBlockX * m_mapinfo.m_iGridSize + m_mapinfo.m_iGridSize/2;
    int iStartY = iStartBlockY * m_mapinfo.m_iGridSize + m_mapinfo.m_iGridSize/2;

    int iEndX = iEndBlockX * m_mapinfo.m_iGridSize + m_mapinfo.m_iGridSize/2;
    int iEndY = iEndBlockY * m_mapinfo.m_iGridSize + m_mapinfo.m_iGridSize/2;

    double K;        // ֱ��б��
    double offset;   // ����ƫ��

    if (bStepX)
    {
        K = (double)(iEndY - iStartY) / (double)(iEndX - iStartX);
        offset = (double)(iStartY * iEndX - iEndY * iStartX) / (double)(iEndX - iStartX);

        for (int i = 0; i < iWidthBlocks; i++)
        {
            if (bGrowX)
            {
                iStartBlockX++;
            }
            else 
            {
                iStartBlockX--;
            }

            iStartX = iStartBlockX * m_mapinfo.m_iGridSize + m_mapinfo.m_iGridSize/2;
            iStartY = (int)(K * iStartX + offset + 0.5f);
            
            iStartBlockY = Position2Block(iStartY);
            

            // �����¶�̬�赲��
            if (pPinDynBlockData && IsDynBlockMask(iStartBlockX, iStartBlockY, pPinDynBlockData))
            {
//              IsDynBlockMask(iStartBlockX, iStartBlockY, pPinDynBlockData);
                return false ;   // �����ߡ�
            }

            if (m_astSceneBlock[iStartBlockY * m_iWidthBlocks + iStartBlockX].iWalkable == 0)
            {
                return false;
            }
        }
    }
    else
    {
        K = (double)(iEndX - iStartX) / (double)(iEndY - iStartY);
        offset = (double)(iEndY * iStartX - iStartY * iEndX) / (double)(iEndY - iStartY);
 
        for (int i = 0; i < iHeightBlocks; i++)
        {
            if (bGrowY)
            {
                iStartBlockY++;
            }
            else {
                iStartBlockY--;
            }
		
            iStartY = iStartBlockY * m_mapinfo.m_iGridSize + m_mapinfo.m_iGridSize/2;
            iStartX = (int)(K * iStartY + offset + 0.5f);

            iStartBlockX = Position2Block(iStartX);

            // �����¶�̬�赲��
            if (pPinDynBlockData && IsDynBlockMask(iStartBlockX, iStartBlockY, pPinDynBlockData))
            {
                return false ;   // �����ߡ�
            }

            if (m_astSceneBlock[iStartBlockY * m_iWidthBlocks + iStartBlockX].iWalkable == 0)
            {
                return false;
            }
        }
    }

    return true;
}

void CScenePathManager::ResetAstar()
{
	int iX, iY;
	for (iY = 0; iY < m_iHeightBlocks; iY++)
	{
		for (iX = 0; iX < m_iWidthBlocks; iX++)
		{
			int iBlock = iY * m_iWidthBlocks + iX;
			m_astSceneBlock[iBlock].stAStar.reset();
		}
	}
}


bool CScenePathManager::FindPathSlow(const TUnitPosition &rstStartPosition, const TUnitPosition &rstEndPosition, TUnitPath &rstPath)
{
	ResetAstar();
    int iStartBlockX = Position2Block(rstStartPosition.m_uiX);
    int iStartBlockY = Position2Block(rstStartPosition.m_uiY);

    int iEndBlockX = Position2Block(rstEndPosition.m_uiX);
    int iEndBlockY = Position2Block(rstEndPosition.m_uiY);

    if (iStartBlockX < 0 || iStartBlockX >= m_iWidthBlocks 
        || iStartBlockY < 0 || iStartBlockY >= m_iHeightBlocks
        || iEndBlockX < 0 || iEndBlockX >= m_iWidthBlocks 
        || iEndBlockY < 0 || iEndBlockY >= m_iHeightBlocks)
    {
        return false;
    }

    TSceneBlock *pstStartBlock = &m_astSceneBlock[iStartBlockY * m_iWidthBlocks + iStartBlockX];
    TSceneBlock *pstEndBlock = &m_astSceneBlock[iEndBlockY * m_iWidthBlocks + iEndBlockX];

    m_stPathMinHeap.Initialize();

    // ���δ���ǰ�ڵ����Χ4���ڵ�, ֱ���������ڵ�
    TSceneBlock *pstCenterBlock = pstStartBlock;
    while (1)
    {
		if (m_stPathMinHeap.IsHeapFull())
		{
			break;
		}

        // ����ǰ�ڵ�������б�
        pstCenterBlock->stAStar.bClosed = true;

        int iCenterX = BLOCK_X(pstCenterBlock);
        int iCenterY = BLOCK_Y(pstCenterBlock);

        // �����յ������Ŀ�
        if (pstCenterBlock->iFirstBlock == pstEndBlock->iFirstBlock)
        {
            break;
        }

        if (iCenterX - 1 >= 0)
        {
            int iRet = AStarCountNode(iCenterX - 1, iCenterY, iEndBlockX, iEndBlockY, pstCenterBlock);
			if (iRet < 0)
			{
				break;
			}
        }

        if (iCenterX + 1 < m_iWidthBlocks)
        {
            int iRet = AStarCountNode(iCenterX + 1, iCenterY, iEndBlockX, iEndBlockY, pstCenterBlock);
			if (iRet < 0)
			{
				break;
			}
        }

        if (iCenterY - 1 >= 0)
        {
            int iRet = AStarCountNode(iCenterX, iCenterY - 1, iEndBlockX, iEndBlockY, pstCenterBlock);
			if (iRet < 0)
			{
				break;
			}
        }

        if (iCenterY + 1 < m_iHeightBlocks)
        {
            int iRet = AStarCountNode(iCenterX, iCenterY + 1, iEndBlockX, iEndBlockY, pstCenterBlock);
			if (iRet < 0)
			{
				break;
			}
        }

        // ȡ�����б���·����С����Ϊ��ǰ�ڵ�
        pstCenterBlock = m_stPathMinHeap.PopHeap();
        if (pstCenterBlock == NULL)
        {
            pstStartBlock->stAStar.bClosed = false;
            break;
        }    
    }

    pstStartBlock->stAStar.bClosed = false;

    // A* �㷨����, ����·���Ż�

    // ȥ���յ��
    if (pstCenterBlock == pstEndBlock)
    {
        pstCenterBlock = pstCenterBlock->stAStar.pstCenterNode;
    }

    // ͳ��·�������
    g_iTempPathNumber = 0;
    TSceneBlock *pstPathBlock = pstCenterBlock;
    while (pstPathBlock && pstPathBlock != pstStartBlock)
    {
        g_iTempPathNumber++;
        pstPathBlock = pstPathBlock->stAStar.pstCenterNode;
    }

    if (g_iTempPathNumber >= MAX_TEMP_PATH_NUMBER - 1)
    {
        return false;
    } 

    // ��·���㷴��������
    pstPathBlock = pstCenterBlock;
    for (int i = g_iTempPathNumber - 1; i >= 0; i--)
    {
        int iCenterX = BLOCK_X(pstPathBlock) * m_mapinfo.m_iGridSize + m_mapinfo.m_iGridSize / 2;
        int iCenterY = BLOCK_Y(pstPathBlock) * m_mapinfo.m_iGridSize + m_mapinfo.m_iGridSize / 2;

        g_astTempPosition[i].m_uiX = iCenterX;
        g_astTempPosition[i].m_uiY = iCenterY;

        pstPathBlock = pstPathBlock->stAStar.pstCenterNode;
    }

    // ����յ�
    g_iTempPathNumber++;
    g_astTempPosition[g_iTempPathNumber - 1] = rstEndPosition;

    OptimizeAStarPath(rstStartPosition, rstPath);

    return true;
}


int CScenePathManager::AStarCountNode(int iX, int iY, int iEndX, int iEndY, TSceneBlock *pstCenterBlock)
{
    TSceneBlock *pstNeighborBlock = &m_astSceneBlock[iY * m_iWidthBlocks + iX];

    // �˿鲻�����ߣ�����
    if (pstNeighborBlock->iWalkable == 0)
    {
        return 0;
    }

    TAStarNode &stAStar = pstNeighborBlock->stAStar;

    // �Ѿ��������б�����
    if (stAStar.bClosed)
    {
        return 0;
    }

    //ʡ��G������������ٶ�, ���ò�������·��, �������������·��Ѱ·������
    int iValueG = pstCenterBlock->stAStar.iValueG + 1;

    // �ڿ����б��У���·�����������ȣ�����
    if (stAStar.bOpened && stAStar.iValueG < iValueG)
    {
        return 0;
    }

    // ���µ�ǰ�ڵ�GHFֵ����ָ���µ����Ľڵ�
    stAStar.iValueG = iValueG;
    // stAStar.iValueH = ABS(iX, iEndX) + ABS(iY, iEndY);
    stAStar.iValueF = stAStar.iValueG + ABS(iX, iEndX) + ABS(iY, iEndY);

    stAStar.pstCenterNode = pstCenterBlock;

    // ���뿪���б�
    if (!stAStar.bOpened)
    {
        bool bPushed = m_stPathMinHeap.PushHeap(pstNeighborBlock);
		if (!bPushed)
		{
			return -1;	
		}

		stAStar.bOpened = true;
    }

    return 0;
}

void CScenePathManager::OptimizeAStarPath(const TUnitPosition &rstStartPosition, TUnitPath &rstPath)
{
    int iSavedNumber = g_iTempPathNumber;

    // �Ż���ʼ��
    int iFirstPoint = 0;
    int iSecondPoint = iFirstPoint + 1;
    while (g_iTempPathNumber > 1 && CanWalk(rstStartPosition, g_astTempPosition[iSecondPoint]))
    {       
        iFirstPoint = iSecondPoint;
        iSecondPoint = iFirstPoint + 1;
        g_iTempPathNumber--;
    }

    int iSavedFirstPoint = iFirstPoint;

    // �Ż��м�·����
    int iThirdPoint;

    while (g_iTempPathNumber > 2)
    {
        iThirdPoint = iSecondPoint + 1;

        if (iThirdPoint >= iSavedNumber)
        {
            break;
        }

        if (CanWalk(g_astTempPosition[iFirstPoint], g_astTempPosition[iThirdPoint]))
        {
            g_astTempPosition[iSecondPoint].m_uiX = (unsigned int)-1;

            iSecondPoint = iThirdPoint;

            g_iTempPathNumber--;
            continue;
        }

        iFirstPoint = iSecondPoint;
        iSecondPoint = iFirstPoint + 1;
    }

    // �ռ�������Ч·����
    int i = iSavedFirstPoint; 
    rstPath.m_iNumber = 0;
    while (rstPath.m_iNumber < g_iTempPathNumber)
    {
        if (g_astTempPosition[i].m_uiX != (unsigned int)-1)
        {
            rstPath.m_astPosition[rstPath.m_iNumber++] = g_astTempPosition[i];
            if (rstPath.m_iNumber >= MAX_POSITION_NUMBER_IN_PATH - 1)
            {
                break;
            }
        }     

        i++;
    }
}

bool CScenePathManager::CheckPoint(float x,float y)
{
	TUnitPosition rstpos;
	rstpos.m_uiX=x;
	rstpos.m_uiY=y;

	return CanWalk(rstpos);
}

bool CScenePathManager::CheckPath(float x1,float y1,float x2,float y2)
{
	TUnitPosition rstpos;
	rstpos.m_uiX=x1;
	rstpos.m_uiY=y1;
	TUnitPosition endpos;
	endpos.m_uiX=x2;
	endpos.m_uiY=y2;

	return CanWalk(rstpos,endpos);
}

bool CScenePathManager::FindPath(float x1,float y1,float x2,float y2,TUnitPath &rstPath)
{
	TUnitPosition rstpos;
	rstpos.m_uiX=x1;
	rstpos.m_uiY=y1;
	TUnitPosition endpos;
	endpos.m_uiX=x2;
	endpos.m_uiY=y2;

	return FindPathSlow(rstpos,endpos,rstPath);
}

void CScenePathManager::OptimizePath(const TUnitPosition &rstStartPosition, TUnitPath &rstPath)
{
    int iSavedNumber = rstPath.m_iNumber;

    // �Ż�·������ʼ��
    // �����ǰλ�õ���ֱ�ӵ���ڶ���·����, �򽫵ڶ���·��������Ϊ��һ��·����
    int iFirstPoint = 0;
    int iSecondPoint = iFirstPoint + 1;
    while (rstPath.m_iNumber > 1 && CanWalk(rstStartPosition, rstPath.m_astPosition[iSecondPoint]))
    {       
        iFirstPoint = iSecondPoint;
        iSecondPoint = iFirstPoint + 1;
        rstPath.m_iNumber--;
    }

    int iSavedFirstPoint = iFirstPoint;

    // �Ż��м�·����
    // �����һ������ֱ�ӵ����������,  ��ȥ���ڶ�����
    int iThirdPoint;
    int iFourthPoint;

    while (rstPath.m_iNumber > 2)
    {
        iThirdPoint = iSecondPoint + 1;
        iFourthPoint = iThirdPoint + 1;

        if (iThirdPoint >= iSavedNumber)
        {
            break;
        }

        if (iFourthPoint < iSavedNumber && CanWalk(
            rstPath.m_astPosition[iFirstPoint], 
            rstPath.m_astPosition[iFourthPoint]))
        {
            rstPath.m_astPosition[iSecondPoint].m_uiX = (unsigned int)-1;
            rstPath.m_astPosition[iThirdPoint].m_uiX = (unsigned int)-1;

            iSecondPoint = iFourthPoint;

            rstPath.m_iNumber--;
            rstPath.m_iNumber--;
            continue;
        }

        if (CanWalk(rstPath.m_astPosition[iFirstPoint], rstPath.m_astPosition[iThirdPoint]))
        {
            rstPath.m_astPosition[iSecondPoint].m_uiX = (unsigned int)-1;

            iSecondPoint = iThirdPoint;

            rstPath.m_iNumber--;
            continue;
        }

        iFirstPoint = iSecondPoint;
        iSecondPoint = iFirstPoint + 1;
    }

    // �ռ�������Ч·����, ��Ч��·����X����Ѿ�����Ϊ-1
    int i = iSavedFirstPoint; 
    int j = 0;
    while (j < rstPath.m_iNumber)
    {
        if (rstPath.m_astPosition[i].m_uiX != (unsigned int)-1)
        {
            rstPath.m_astPosition[j++] = rstPath.m_astPosition[i];
        }     

        i++;
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////
CPathMinHeap::CPathMinHeap()
{
    m_iOpenNodes = 0;
    memset(m_astOpenNode, 0, sizeof(m_astOpenNode));
}

// �ж��Ƿ񻺳�����
bool CPathMinHeap::IsHeapFull()
{
	return (m_iOpenNodes >= MAX_PATH_NODE);
}

void CPathMinHeap::Initialize()
{
    for (int i = 0; i < m_iOpenNodes; i++)
    {
		m_astOpenNode[i]->stAStar.reset();
    }

    m_iOpenNodes = 0;
}

TSceneBlock *CPathMinHeap::PopHeap()
{
    if (m_iOpenNodes <= 0)
    {
        return NULL;
    }

    // ������Сֵ
    TSceneBlock *pstMinBlock = m_astOpenNode[0];

    // �Ƚ������ӽڵ㣬��С������Ϊ���ڵ�
    int iParent = 0;
    int iLeftChild, iRightChild;
    for (iLeftChild = 2 * iParent + 1, iRightChild = iLeftChild + 1;
        iRightChild < m_iOpenNodes;
        iLeftChild = 2 * iParent + 1, iRightChild = iLeftChild + 1)
    {
        if (m_astOpenNode[iLeftChild]->stAStar.iValueF < m_astOpenNode[iRightChild]->stAStar.iValueF)
        {
            m_astOpenNode[iParent] = m_astOpenNode[iLeftChild];
            iParent = iLeftChild;
        }
        else
        {
            m_astOpenNode[iParent] = m_astOpenNode[iRightChild];
            iParent = iRightChild;
        }
    }

    // �����һ���ڵ����ڿճ����Ľڵ���, ��ֹ����ն�
    if (iParent != m_iOpenNodes - 1)
    {
        bool bPushed = InsertHeap(m_astOpenNode[--m_iOpenNodes], iParent);
		if (!bPushed)
		{
			return NULL;
		}
    }
    m_iOpenNodes--;

    return pstMinBlock;
}

bool CPathMinHeap::PushHeap(TSceneBlock *pstSceneBlock)
{
    if (m_iOpenNodes >= MAX_PATH_NODE)
    {
        return false;
    }

    return InsertHeap(pstSceneBlock, m_iOpenNodes);
}

bool CPathMinHeap::InsertHeap(TSceneBlock *pstSceneBlock, int iPosition)
{
	if (iPosition >= MAX_PATH_NODE)
	{
		return false;
	}

    m_astOpenNode[iPosition] = pstSceneBlock;

    // ���κ͸��ڵ�Ƚϣ�����ȸ��ڵ�С��������
    int iChild, iParent;
    for (iChild = iPosition, iParent = (iChild - 1) / 2;
        iChild > 0;
        iChild = iParent, iParent = (iChild - 1) / 2)
    {
        if (m_astOpenNode[iChild]->stAStar.iValueF < m_astOpenNode[iParent]->stAStar.iValueF)
        {
            TSceneBlock *tmp = m_astOpenNode[iParent];
            m_astOpenNode[iParent] = m_astOpenNode[iChild];
            m_astOpenNode[iChild] = tmp;
        }
        else
        {
            break;
        }
    }

    m_iOpenNodes++;

    return true;
}
