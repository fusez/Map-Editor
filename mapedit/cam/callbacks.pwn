/******************************************************************************/

public OnFilterScriptExit()
{
    for(new playerid; playerid < MAX_PLAYERS; playerid ++)
    {
        if(IsPlayerConnected(playerid) && g_IsPlayerCamActivated{playerid})
            TogglePlayerFreeCam(playerid, false);
    }

    #if defined fc_OnFilterScriptExit
        fc_OnFilterScriptExit();
    #endif
}
#if defined _ALS_OnFilterScriptExit
    #undef OnFilterScriptExit
#else
    #define _ALS_OnFilterScriptExit
#endif
#define OnFilterScriptExit fc_OnFilterScriptExit
#if defined fc_OnFilterScriptExit
    forward fc_OnFilterScriptExit();
#endif

/******************************************************************************/

public OnPlayerDisconnect(playerid, reason)
{
    if(g_IsPlayerCamActivated{playerid})
        TogglePlayerFreeCam(playerid, false);

    #if defined fc_OnPlayerDisconnect
        fc_OnPlayerDisconnect(playerid, reason);
    #endif
}
#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect fc_OnPlayerDisconnect
#if defined fc_OnPlayerDisconnect
    forward fc_OnPlayerDisconnect(playerid, reason);
#endif

/******************************************************************************/

public OnPlayerUpdate(playerid)
{
    static previous_tick[MAX_PLAYERS];

    if(
        g_IsPlayerCamActivated{playerid} &&
        GetTickCount() - previous_tick[playerid] > 100
    ){
        new
            keys,
            ud,
            lr,
            direction
        ;

        GetPlayerKeys(playerid, keys, ud, lr);
        direction = GetPlayerNextCamDirection(ud, lr);

        if(direction)
        {
            new    Float: pos        [3],
                Float: vector    [3],
                Float: x,
                Float: y,
                Float: z,
                Float: speed;

            GetPlayerCameraPos(playerid, pos[0], pos[1], pos[2]);
            GetPlayerCameraFrontVector(playerid, vector[0], vector[1], vector[2]);
            GetPlayerNextCamPos(direction, pos, vector, x, y, z);

            g_PlayerCamAcceleration[playerid] += 0.05;
            if(g_PlayerCamAcceleration[playerid] > 1.0)
                g_PlayerCamAcceleration[playerid] = 1.0;

            if( (keys & KEY_JUMP) == KEY_JUMP )
                speed = 200.0 * g_PlayerCamAcceleration[playerid];
            else if( (keys & KEY_WALK) == KEY_WALK )
                speed = 10.0 * g_PlayerCamAcceleration[playerid];
            else
                speed = 50.0 * g_PlayerCamAcceleration[playerid];

            MovePlayerObject(playerid, g_PlayerCamObject[playerid], x, y, z, speed, 0.0, 0.0, 0.0);
        }
        else
        {
            StopPlayerObject(playerid, g_PlayerCamObject[playerid]);
            g_PlayerCamAcceleration[playerid] = 0.0;
        }
        g_PlayerCamDirection{playerid} = direction;
        previous_tick[playerid] = GetTickCount();
    }

    #if defined fc_OnPlayerUpdate
        return fc_OnPlayerUpdate(playerid);
    #else
        return 1;
    #endif
}
#if defined _ALS_OnPlayerUpdate
    #undef OnPlayerUpdate
#else
    #define _ALS_OnPlayerUpdate
#endif
#define OnPlayerUpdate fc_OnPlayerUpdate
#if defined fc_OnPlayerUpdate
    forward fc_OnPlayerUpdate(playerid);
#endif

/******************************************************************************/

public OnToolbarResponse(playerid, response)
{
    if(response == TOOLBAR_CAM)
    {
        new
            bool: toggle = (g_IsPlayerCamActivated{playerid}) ? (false) : (true)
        ;

        if(TogglePlayerFreeCam(playerid, toggle))
            CancelSelectTextDraw(playerid);

        return 1;
    }

    #if defined fc_OnToolbarResponse
        return fc_OnToolbarResponse(playerid, response);
    #else
        return 0;
    #endif
}
#if defined _ALS_OnToolbarResponse
    #undef OnToolbarResponse
#else
    #define _ALS_OnToolbarResponse
#endif
#define OnToolbarResponse fc_OnToolbarResponse
#if defined fc_OnToolbarResponse
    forward fc_OnToolbarResponse(playerid, response);
#endif

/******************************************************************************/
