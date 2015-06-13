/******************************************************************************/

public OnFilterScriptInit()
{
    CreateInfoTextdraws();

    #if defined info_OnFilterScriptInit
        info_OnFilterScriptInit();
    #endif
}
#if defined _ALS_OnFilterScriptInit
    #undef OnFilterScriptInit
#else
    #define _ALS_OnFilterScriptInit
#endif
#define OnFilterScriptInit info_OnFilterScriptInit
#if defined info_OnFilterScriptInit
    forward info_OnFilterScriptInit();
#endif

/******************************************************************************/

public OnFilterScriptExit()
{
    DestroyInfoTextdraws();

    #if defined info_OnFilterScriptExit
        info_OnFilterScriptExit();
    #endif
}
#if defined _ALS_OnFilterScriptExit
    #undef OnFilterScriptExit
#else
    #define _ALS_OnFilterScriptExit
#endif
#define OnFilterScriptExit info_OnFilterScriptExit
#if defined info_OnFilterScriptExit
    forward info_OnFilterScriptExit();
#endif

/******************************************************************************/

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
    if(clickedid == Text:INVALID_TEXT_DRAW)
        HidePlayerInfoTextdraws(playerid);

    else if(clickedid == g_InfoCloseTD)
    {
        HidePlayerInfoTextdraws(playerid);
        PlayerPlaySound(playerid, 1084, 0.0, 0.0, 0.0);
        return 1;
    }

    #if defined info_OnPlayerClickTextDraw
        return info_OnPlayerClickTextDraw(playerid, clickedid);
    #else
        return 0;
    #endif
}
#if defined _ALS_OnPlayerClickTextDraw
    #undef OnPlayerClickTextDraw
#else
    #define _ALS_OnPlayerClickTextDraw
#endif
#define OnPlayerClickTextDraw info_OnPlayerClickTextDraw
#if defined info_OnPlayerClickTextDraw
    forward info_OnPlayerClickTextDraw(playerid, Text:clickedid);
#endif

/******************************************************************************/

public OnToolbarResponse(playerid, response)
{
    if(response == TOOLBAR_INFO)
        return ShowPlayerInfoTextdraws(playerid), 1;

    #if defined info_OnToolbarResponse
        return info_OnToolbarResponse(playerid, response);
    #else
        return 0;
    #endif
}
#if defined _ALS_OnToolbarResponse
    #undef OnToolbarResponse
#else
    #define _ALS_OnToolbarResponse
#endif
#define OnToolbarResponse info_OnToolbarResponse
#if defined info_OnToolbarResponse
    forward info_OnToolbarResponse(playerid, response);
#endif

/******************************************************************************/
