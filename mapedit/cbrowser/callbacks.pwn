/******************************************************************************/

public OnFilterScriptInit()
{
    for(new playerid; playerid < MAX_PLAYERS; playerid ++)
    {
        if(IsPlayerConnected(playerid))
            CreateCBrowserTextdraws(playerid);
    }

    #if defined cb_OnFilterScriptInit
        cb_OnFilterScriptInit();
    #endif
}
#if defined _ALS_OnFilterScriptInit
    #undef OnFilterScriptInit
#else
    #define _ALS_OnFilterScriptInit
#endif
#define OnFilterScriptInit cb_OnFilterScriptInit
#if defined cb_OnFilterScriptInit
    forward cb_OnFilterScriptInit();
#endif

/******************************************************************************/

public OnFilterScriptExit()
{
    for(new playerid; playerid < MAX_PLAYERS; playerid ++)
    {
        if(IsPlayerConnected(playerid))
            DestroyCBrowserTextdraws(playerid);
    }

    #if defined cb_OnFilterScriptExit
        cb_OnFilterScriptExit();
    #endif
}
#if defined _ALS_OnFilterScriptExit
    #undef OnFilterScriptExit
#else
    #define _ALS_OnFilterScriptExit
#endif
#define OnFilterScriptExit cb_OnFilterScriptExit
#if defined cb_OnFilterScriptExit
    forward cb_OnFilterScriptExit();
#endif

/******************************************************************************/

public OnPlayerConnect(playerid)
{
    CreateCBrowserTextdraws(playerid);

    #if defined cb_OnPlayerConnect
        cb_OnPlayerConnect(playerid);
    #endif
}
#if defined _ALS_OnPlayerConnect
    #undef OnPlayerConnect
#else
    #define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect cb_OnPlayerConnect
#if defined cb_OnPlayerConnect
    forward cb_OnPlayerConnect(playerid);
#endif

/******************************************************************************/

public OnPlayerDisconnect(playerid, reason)
{
    DestroyCBrowserTextdraws(playerid);

    #if defined cb_OnPlayerDisconnect
        cb_OnPlayerDisconnect(playerid, reason);
    #endif
}
#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect cb_OnPlayerDisconnect
#if defined cb_OnPlayerDisconnect
    forward cb_OnPlayerDisconnect(playerid, reason);
#endif

/******************************************************************************/

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
    if(playertextid == g_cbCloseTD[playerid])
    {
        OnCBrowserResponse(playerid, g_cbID[playerid], CBROWSER_RESPONSE_CLOSE, 0);
        PlayerPlaySound(playerid, 1084, 0.0, 0.0, 0.0);
        return 1;
    }
    if(playertextid == g_cbPageTD[playerid][0])
    {
        OnCBrowserResponse(playerid, g_cbID[playerid], CBROWSER_RESPONSE_PAGE_BACK, 0);
        PlayerPlaySound(playerid, 1084, 0.0, 0.0, 0.0);
        return 1;
    }
    if(playertextid == g_cbPageTD[playerid][2])
    {
        OnCBrowserResponse(playerid, g_cbID[playerid], CBROWSER_RESPONSE_PAGE_NEXT, 0);
        PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
        return 1;
    }
    for(new index; index < MAX_CBROWSER_PAGESIZE; index ++)
    {
        if(playertextid == g_cbColorTD[playerid][index])
        {
            OnCBrowserResponse(playerid, g_cbID[playerid], CBROWSER_RESPONSE_COLOR, index);
            PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
            return 1;
        }
    }

    #if defined cb_OnPlayerClickPlayerTextDraw
        return cb_OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid);
    #else
        return 0;
    #endif
}
#if defined _ALS_OnPlayerClickPTD
    #undef OnPlayerClickPlayerTextDraw
#else
    #define _ALS_OnPlayerClickPTD
#endif
#define OnPlayerClickPlayerTextDraw cb_OnPlayerClickPlayerTextDraw
#if defined cb_OnPlayerClickPlayerTextDraw
    forward cb_OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid);
#endif

/******************************************************************************/
