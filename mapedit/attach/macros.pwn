#define GetPlayerAttachedObjectModel(%0,%1) \
    (g_pAttachedModel[%0][%1])

#define GetPlayerAttachedObjectBone(%0,%1) \
    (g_pAttachedBone[%0][%1])

#define GetPlayerAttachedObjectOffset(%0,%1,%2,%3,%4) \
    (%2 = g_pAttachedOffset[%0][%1][0], %3 = g_pAttachedOffset[%0][%1][1], %4 = g_pAttachedOffset[%0][%1][2])

#define GetPlayerAttachedObjectRot(%0,%1,%2,%3,%4) \
    (%2 = g_pAttachedRot[%0][%1][0], %3 = g_pAttachedRot[%0][%1][1], %4 = g_pAttachedRot[%0][%1][2])

#define GetPlayerAttachedObjectScale(%0,%1,%2,%3,%4) \
    (%2 = g_pAttachedScale[%0][%1][0], %3 = g_pAttachedScale[%0][%1][1], %4 = g_pAttachedScale[%0][%1][2])

#define GetPlayerAttachedObjectColor(%0,%1,%2,%3) \
    (%2 = g_pAttachedColor[%0][%1][0], %3 = g_pAttachedColor[%0][%1][1])
