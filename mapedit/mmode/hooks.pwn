/******************************************************************************/

stock mm_SelectTextDraw(playerid, hovercolor)
{
    g_IsPlayerInMouseMode{playerid} = true;
    UpdatePlayerMousemodeTextdraw(playerid);
    SelectTextDraw(playerid, hovercolor);
}
#if defined _ALS_SelectTextDraw
    #undef SelectTextDraw
#else
    #define _ALS_SelectTextDraw
#endif
#define SelectTextDraw mm_SelectTextDraw

/******************************************************************************/

stock mm_CancelSelectTextDraw(playerid)
{
    g_IsPlayerInMouseMode{playerid} = false;
    UpdatePlayerMousemodeTextdraw(playerid);
    CancelSelectTextDraw(playerid);
}
#if defined _ALS_CancelSelectTextDraw
    #undef CancelSelectTextDraw
#else
    #define _ALS_CancelSelectTextDraw
#endif
#define CancelSelectTextDraw mm_CancelSelectTextDraw

/******************************************************************************/
