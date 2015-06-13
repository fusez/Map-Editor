/******************************************************************************/

public OnPlayerDisconnect(playerid, reason)
{
    if(g_pOffsetEditToggled{playerid})
        TogglePlayerOffsetEditor(playerid, false);

    #if defined oe_OnPlayerDisconnect
        oe_OnPlayerDisconnect(playerid, reason);
    #endif
}
#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect oe_OnPlayerDisconnect
#if defined oe_OnPlayerDisconnect
    forward oe_OnPlayerDisconnect(playerid, reason);
#endif

/******************************************************************************/

public OnPlayerOffsetEditUpdate(playerid)
{
    static
        old_keys [ MAX_PLAYERS ]
    ;

    new
        new_keys,
        up_down,
        left_right
    ;

    GetPlayerKeys(playerid, new_keys, up_down, left_right);

    if((new_keys & KEY_SECONDARY_ATTACK) == KEY_SECONDARY_ATTACK)
    {
        // Exit Offset Editor

        TogglePlayerOffsetEditor(playerid, false);
        ClearAnimations(playerid);
    }
    else if((new_keys & KEY_SPRINT) == KEY_SPRINT)
    {
        // Change Mode

        if((new_keys & KEY_ANALOG_LEFT) == KEY_ANALOG_LEFT && (old_keys[playerid] & KEY_ANALOG_LEFT) != KEY_ANALOG_LEFT)
        {
            // Decrease

            if(-- g_pOffsetEditMode{playerid} < OFFSET_MODE_X)
                g_pOffsetEditMode{playerid} = OFFSET_MODE_RZ;

            ShowPlayerOffsetEditorMode(playerid);
        }

        else if((new_keys & KEY_ANALOG_RIGHT) == KEY_ANALOG_RIGHT && (old_keys[playerid] & KEY_ANALOG_RIGHT) != KEY_ANALOG_RIGHT)
        {
            // Increase

            if(++ g_pOffsetEditMode{playerid} > OFFSET_MODE_RZ)
                   g_pOffsetEditMode{playerid} = OFFSET_MODE_X;

            ShowPlayerOffsetEditorMode(playerid);
        }
    }
    else
    {
        new
            objectid = g_pEditObject[playerid],
            attach_to_objectid = GetObjectAttachedToObject(objectid),
            attach_to_vehicleid = GetObjectAttachedToVehicle(objectid),
            bool: decrease = (new_keys & KEY_ANALOG_LEFT) == KEY_ANALOG_LEFT,
            bool: increase = (new_keys & KEY_ANALOG_RIGHT) == KEY_ANALOG_RIGHT,
            Float:x,
            Float:y,
            Float:z,
            Float:rx,
            Float:ry,
            Float:rz;

        if(g_pOffsetEditMode{playerid} == OFFSET_MODE_NONE || (!increase && !decrease))
            g_pOffsetEditSpeed[playerid] = 0.0;
        else
        {
            switch(g_pOffsetEditMode{playerid})
            {
                case OFFSET_MODE_X, OFFSET_MODE_Y, OFFSET_MODE_Z:
                {
                    if( (new_keys & KEY_WALK) == KEY_WALK )
                    {
                        g_pOffsetEditSpeed[playerid] += OE_MOVESPEED_SLOW_MULTIPLIER;
                        if(g_pOffsetEditSpeed[playerid] > OE_MOVESPEED_SLOW_LIMIT)
                            g_pOffsetEditSpeed[playerid] = OE_MOVESPEED_SLOW_LIMIT;
                    }
                    else
                    {
                        g_pOffsetEditSpeed[playerid] += OE_MOVESPEED_MULTIPLIER;
                        if(g_pOffsetEditSpeed[playerid] > OE_MOVESPEED_LIMIT)
                            g_pOffsetEditSpeed[playerid] = OE_MOVESPEED_LIMIT;
                    }
                }
                case OFFSET_MODE_RX, OFFSET_MODE_RY, OFFSET_MODE_RZ:
                {
                    if( (new_keys & KEY_WALK) == KEY_WALK )
                    {
                        g_pOffsetEditSpeed[playerid] += OE_ROTATESPEED_SLOW_MULTIPLIER;
                        if(g_pOffsetEditSpeed[playerid] > OE_ROTATESPEED_SLOW_LIMIT)
                            g_pOffsetEditSpeed[playerid] = OE_ROTATESPEED_SLOW_LIMIT;
                    }
                    else
                    {
                        g_pOffsetEditSpeed[playerid] += OE_ROTATESPEED_MULTIPLIER;
                        if(g_pOffsetEditSpeed[playerid] > OE_ROTATESPEED_LIMIT)
                            g_pOffsetEditSpeed[playerid] = OE_ROTATESPEED_LIMIT;
                    }
                }
            }

            GetObjectAttachOffset(objectid, x, y, z, rx, ry, rz);
            switch(g_pOffsetEditMode{playerid})
            {
                case OFFSET_MODE_X:
                {
                    if(increase)
                        x += g_pOffsetEditSpeed[playerid];
                    else if(decrease)
                        x -= g_pOffsetEditSpeed[playerid];
                }
                case OFFSET_MODE_Y:
                {
                    if(increase)
                        y += g_pOffsetEditSpeed[playerid];
                    else if(decrease)
                        y -= g_pOffsetEditSpeed[playerid];
                }
                case OFFSET_MODE_Z:
                {
                    if(increase)
                        z += g_pOffsetEditSpeed[playerid];
                    else if(decrease)
                        z -= g_pOffsetEditSpeed[playerid];
                }
                case OFFSET_MODE_RX:
                {
                    if(increase)
                    {
                        rx += g_pOffsetEditSpeed[playerid];
                        if(rx > 360.0)
                            rx = 0.0;
                    }
                    else if(decrease)
                    {
                        rx -= g_pOffsetEditSpeed[playerid];
                        if(rx < 0.0)
                            rx = 360.0;
                    }
                }
                case OFFSET_MODE_RY:
                {
                    if(increase)
                    {
                        ry += g_pOffsetEditSpeed[playerid];
                        if(ry > 360.0)
                            ry = 0.0;
                    }
                    else if(decrease)
                    {
                        ry -= g_pOffsetEditSpeed[playerid];
                        if(ry < 0.0)
                            ry = 360.0;
                    }
                }
                case OFFSET_MODE_RZ:
                {
                    if(increase)
                    {
                        rz += g_pOffsetEditSpeed[playerid];
                        if(rz > 360.0)
                            rz = 0.0;
                    }
                    else if(decrease)
                    {
                        rz -= g_pOffsetEditSpeed[playerid];
                        if(rz < 0.0)
                            rz = 360.0;
                    }
                }
            }

            if(attach_to_objectid != INVALID_OBJECT_ID)
            {
                AttachObjectToObject(objectid, attach_to_objectid, x, y, z, rx, ry, rz);
                ShowPlayerOffsetEditorUpdate(playerid, x, y, z, rx, ry, rz);
            }
            else if(attach_to_vehicleid != INVALID_VEHICLE_ID)
            {
                AttachObjectToVehicle(objectid, attach_to_vehicleid, x, y, z, rx, ry, rz);
                ShowPlayerOffsetEditorUpdate(playerid, x, y, z, rx, ry, rz);
            }
            else
                TogglePlayerOffsetEditor(playerid, false);
        }
    }
    old_keys[playerid] = new_keys;
}

/******************************************************************************/
