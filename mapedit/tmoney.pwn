#define    TUNING_MONEY 10000

new bool: g_IsPlayerTuning[MAX_PLAYERS char];

/******************************************************************************/

public OnPlayerDisconnect(playerid, reason)
{
    g_IsPlayerTuning{playerid} = false;

    #if defined tm_OnPlayerDisconnect
        tm_OnPlayerDisconnect(playerid, reason);
    #endif
}
#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect tm_OnPlayerDisconnect
#if defined tm_OnPlayerDisconnect
    forward tm_OnPlayerDisconnect(playerid, reason);
#endif

/******************************************************************************/

public OnPlayerUpdate(playerid)
{
    if(g_IsPlayerTuning{playerid} && GetPlayerMoney(playerid) != TUNING_MONEY)
    {
        ResetPlayerMoney(playerid);
        GivePlayerMoney(playerid, TUNING_MONEY);
    }

    #if defined tm_OnPlayerUpdate
        return tm_OnPlayerUpdate(playerid);
    #else
        return 1;
    #endif
}
#if defined _ALS_OnPlayerUpdate
    #undef OnPlayerUpdate
#else
    #define _ALS_OnPlayerUpdate
#endif
#define OnPlayerUpdate tm_OnPlayerUpdate
#if defined tm_OnPlayerUpdate
    forward tm_OnPlayerUpdate(playerid);
#endif

/******************************************************************************/

public OnEnterExitModShop(playerid, enterexit, interiorid)
{
    g_IsPlayerTuning{playerid} = (enterexit) ? (true) : (false);
    if(!enterexit) // Leave
        ResetPlayerMoney(playerid);

    #if defined tm_OnEnterExitModShop
        tm_OnEnterExitModShop(playerid, enterexit, interiorid);
    #endif
}
#if defined _ALS_OnEnterExitModShop
    #undef OnEnterExitModShop
#else
    #define _ALS_OnEnterExitModShop
#endif
#define OnEnterExitModShop tm_OnEnterExitModShop
#if defined tm_OnEnterExitModShop
    forward tm_OnEnterExitModShop(playerid, enterexit, interiorid);
#endif

/******************************************************************************/
