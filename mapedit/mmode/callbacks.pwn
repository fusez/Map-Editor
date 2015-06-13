/******************************************************************************/

public OnFilterScriptInit()
{
    for(new playerid; playerid < MAX_PLAYERS; playerid ++)
    {
        if(IsPlayerConnected(playerid))
            CreatePlayerMousemodeTextdraw(playerid);
    }

    #if defined mm_OnFilterScriptInit
        mm_OnFilterScriptInit();
    #endif
}
#if defined _ALS_OnFilterScriptInit
    #undef OnFilterScriptInit
#else
    #define _ALS_OnFilterScriptInit
#endif
#define OnFilterScriptInit mm_OnFilterScriptInit
#if defined mm_OnFilterScriptInit
    forward mm_OnFilterScriptInit();
#endif

/******************************************************************************/

public OnFilterScriptExit()
{
    for(new playerid; playerid < MAX_PLAYERS; playerid ++)
    {
        if(IsPlayerConnected(playerid))
            DestroyPlayerMousemodeTextdraw(playerid);
    }

    #if defined mm_OnFilterScriptExit
        mm_OnFilterScriptExit();
    #endif
}
#if defined _ALS_OnFilterScriptExit
    #undef OnFilterScriptExit
#else
    #define _ALS_OnFilterScriptExit
#endif
#define OnFilterScriptExit mm_OnFilterScriptExit
#if defined mm_OnFilterScriptExit
    forward mm_OnFilterScriptExit();
#endif

/******************************************************************************/

public OnPlayerConnect(playerid)
{
    CreatePlayerMousemodeTextdraw(playerid);
    UpdatePlayerMousemodeTextdraw(playerid);

    #if defined mm_OnPlayerConnect
        mm_OnPlayerConnect(playerid);
    #endif
}
#if defined _ALS_OnPlayerConnect
    #undef OnPlayerConnect
#else
    #define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect mm_OnPlayerConnect
#if defined mm_OnPlayerConnect
    forward mm_OnPlayerConnect(playerid);
#endif

/******************************************************************************/

public OnPlayerDisconnect(playerid, reason)
{
    DestroyPlayerMousemodeTextdraw(playerid);
    g_IsPlayerInMouseMode{playerid} = false;

    #if defined mm_OnPlayerDisconnect
        mm_OnPlayerDisconnect(playerid, reason);
    #endif
}
#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect mm_OnPlayerDisconnect
#if defined mm_OnPlayerDisconnect
    forward mm_OnPlayerDisconnect(playerid, reason);
#endif

/******************************************************************************/

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(!g_IsPlayerInMouseMode{playerid} && (newstate == PLAYER_STATE_SPECTATING || oldstate == PLAYER_STATE_SPECTATING))
        UpdatePlayerMousemodeTextdraw(playerid);

    #if defined mm_OnPlayerStateChange
        mm_OnPlayerStateChange(playerid, newstate, oldstate);
    #endif
}
#if defined _ALS_OnPlayerStateChange
    #undef OnPlayerStateChange
#else
    #define _ALS_OnPlayerStateChange
#endif
#define OnPlayerStateChange mm_OnPlayerStateChange
#if defined mm_OnPlayerStateChange
    forward mm_OnPlayerStateChange(playerid, newstate, oldstate);
#endif

/******************************************************************************/

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    new is_spectating = GetPlayerState(playerid) == PLAYER_STATE_SPECTATING;
    if(
        ( (newkeys & KEY_CROUCH) == KEY_CROUCH && (oldkeys & KEY_CROUCH) != KEY_CROUCH && is_spectating) ||
        ( (newkeys & KEY_YES) == KEY_YES && (oldkeys & KEY_YES) != KEY_YES && !is_spectating)
    ){
        SelectTextDraw(playerid, 0xFF0000FF);

        PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
    }

    #if defined tb_OnPlayerKeyStateChange
        return tb_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
    #else
        return 1;
    #endif
}
#if defined _ALS_OnPlayerKeyStateChange
    #undef OnPlayerKeyStateChange
#else
    #define _ALS_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange tb_OnPlayerKeyStateChange
#if defined tb_OnPlayerKeyStateChange
    forward tb_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif

/******************************************************************************/

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
    if(clickedid == Text:INVALID_TEXT_DRAW)
    {
        g_IsPlayerInMouseMode{playerid} = false;
        UpdatePlayerMousemodeTextdraw(playerid);

        PlayerPlaySound(playerid, 1084, 0.0, 0.0, 0.0);
    }

    #if defined mm_OnPlayerClickTextDraw
        return mm_OnPlayerClickTextDraw(playerid, Text:clickedid);
    #else
        return 0;
    #endif
}
#if defined _ALS_OnPlayerClickTextDraw
    #undef OnPlayerClickTextDraw
#else
    #define _ALS_OnPlayerClickTextDraw
#endif
#define OnPlayerClickTextDraw mm_OnPlayerClickTextDraw
#if defined mm_OnPlayerClickTextDraw
    forward mm_OnPlayerClickTextDraw(playerid, Text:clickedid);
#endif

/******************************************************************************/
