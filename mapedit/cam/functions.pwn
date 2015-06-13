TogglePlayerFreeCam(playerid, bool:toggle)
{
    if(toggle == g_IsPlayerCamActivated{playerid})
        return 0;

    if(toggle)
    {
        switch(GetPlayerState(playerid))
        {
            case PLAYER_STATE_NONE, PLAYER_STATE_WASTED, PLAYER_STATE_SPECTATING:
                return 0;
            case PLAYER_STATE_DRIVER, PLAYER_STATE_PASSENGER:
            {
                new
                    Float: x,
                    Float: y,
                    Float: z
                ;

                GetVehiclePos(GetPlayerVehicleID(playerid), x, y, z);
                SetPlayerPos(playerid, x, y, z);
            }
        }

        new
            Float: x,
            Float: y,
            Float: z
        ;

        GetPlayerPos(playerid, x, y, z);

        g_IsPlayerCamActivated{playerid} = true;
        TogglePlayerSpectating(playerid, true);

        g_PlayerCamObject[playerid] = CreatePlayerObject(playerid, 19300, x, y, z, 0.0, 0.0, 0.0);
        AttachCameraToPlayerObject(playerid, g_PlayerCamObject[playerid]);

        GameTextForPlayer(playerid, "~w~camera mode ~g~toggled", 2000, 4);
    }
    else
    {
        new
            Float: x,
            Float: y,
            Float: z
        ;

        GetPlayerObjectPos(playerid, g_PlayerCamObject[playerid], x, y, z);

        DestroyPlayerObject(playerid, g_PlayerCamObject[playerid]);
        g_PlayerCamObject[playerid] = INVALID_OBJECT_ID;

        g_IsPlayerCamActivated{playerid} = false;
        TogglePlayerSpectating(playerid, false);

        SetPlayerPos(playerid, x, y, z);
        GameTextForPlayer(playerid, "~w~camera mode ~r~untoggled", 2000, 4);
    }
    return 1;
}

GetPlayerNextCamDirection(ud, lr)
{
    new    direction;

    if(ud < 0)
    {
        if(lr > 0)
            direction = CAM_MODE_FORWARD_RIGHT;
        else if(lr < 0)
            direction = CAM_MODE_FORWARD_LEFT;
        else
            direction = CAM_MODE_FORWARD;
    }
    else if(ud > 0)
    {
        if(lr > 0)
            direction = CAM_MODE_BACKWARD_RIGHT;
        else if(lr < 0)
            direction = CAM_MODE_BACKWARD_LEFT;
        else
            direction = CAM_MODE_BACKWARD;
    }
    else if(lr > 0)
        direction = CAM_MODE_RIGHT;
    else if(lr < 0)
        direction = CAM_MODE_LEFT;
    else
        direction = CAM_MODE_STOP;

    return direction;
}

GetPlayerNextCamPos(direction, Float:pos[3], Float:vector[3], &Float:x, &Float:y, &Float:z)
{
    #define OFFSET_X (vector[0] * 6000.0)
    #define OFFSET_Y (vector[1] * 6000.0)
    #define OFFSET_Z (vector[2] * 6000.0)

    switch(direction)
    {
        case CAM_MODE_FORWARD:
        {
            x = pos[0] + OFFSET_X;
            y = pos[1] + OFFSET_Y;
            z = pos[2] + OFFSET_Z;
        }
        case CAM_MODE_BACKWARD:
        {
            x = pos[0] - OFFSET_X;
            y = pos[1] - OFFSET_Y;
            z = pos[2] - OFFSET_Z;
        }
        case CAM_MODE_LEFT:
        {
            x = pos[0] - OFFSET_Y;
            y = pos[1] + OFFSET_X;
            z = pos[2];
        }
        case CAM_MODE_RIGHT:
        {
            x = pos[0] + OFFSET_Y;
            y = pos[1] - OFFSET_X;
            z = pos[2];
        }
        case CAM_MODE_FORWARD_LEFT:
        {
            x = pos[0] + (OFFSET_X - OFFSET_Y);
            y = pos[1] + (OFFSET_Y + OFFSET_X);
            z = pos[2] + OFFSET_Z;
        }
        case CAM_MODE_FORWARD_RIGHT:
        {
            x = pos[0] + (OFFSET_X + OFFSET_Y);
            y = pos[1] + (OFFSET_Y - OFFSET_X);
            z = pos[2] + OFFSET_Z;
        }
        case CAM_MODE_BACKWARD_LEFT:
        {
            x = pos[0] + (-OFFSET_X - OFFSET_Y);
            y = pos[1] + (-OFFSET_Y + OFFSET_X);
            z = pos[2] - OFFSET_Z;
        }
        case CAM_MODE_BACKWARD_RIGHT:
        {
            x = pos[0] + (-OFFSET_X + OFFSET_Y);
            y = pos[1] + (-OFFSET_Y - OFFSET_X);
            z = pos[2] - OFFSET_Z;
        }
    }
}
