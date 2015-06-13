/******************************************************************************/

stock v_CreateVehicle(vehicletype, Float:x, Float:y, Float:z, Float:rotation, color1, color2, respawn_delay)
{
    new vehicleid = CreateVehicle(vehicletype, Float:x, Float:y, Float:z, Float:rotation, color1, color2, respawn_delay);
    if(vehicleid != INVALID_VEHICLE_ID)
    {
        g_VehiclePaintjob{vehicleid - 1} = 3;

        g_VehicleColor[vehicleid - 1][0] = color1;
        g_VehicleColor[vehicleid - 1][1] = color2;
    }
    return vehicleid;
}
#if defined _ALS_CreateVehicle
    #undef CreateVehicle
#else
    #define _ALS_CreateVehicle
#endif
#define CreateVehicle v_CreateVehicle

/******************************************************************************/

stock v_DestroyVehicle(vehicleid)
{
    if(IsValidVehicle(vehicleid))
    {
        g_VehiclePaintjob{vehicleid - 1} = 3;

        for(new color_index; color_index < 2; color_index ++)
            g_VehicleColor[vehicleid - 1][color_index] = 0;

        for(new slot; slot < 14; slot ++)
            g_VehicleComponent[vehicleid - 1][slot] = 0;

        g_VehicleTuningTeleported{vehicleid - 1} = false;

        for(new i; i < 4; i ++)
            g_VehicleTuningPosition[vehicleid - 1][i] = 0.0;

        for(new loop_objectid = 1; loop_objectid <= MAX_OBJECTS; loop_objectid ++)
        {
            if(GetObjectAttachedToVehicle(loop_objectid) == vehicleid)
                DestroyObject(loop_objectid);
        }

        for(new playerid; playerid < MAX_PLAYERS; playerid ++)
        {
            if(!IsPlayerConnected(playerid))
                continue;

            if(g_pEditVehicle[playerid] == vehicleid)
            {
                new    mbrowserid = GetPlayerMBrowser(playerid),
                    cbrowserid = GetPlayerCBrowser(playerid),
                    dialogid = GetPlayerDialog(playerid);

                if(
                    mbrowserid == g_VehicleSelectBrowser ||
                    mbrowserid == g_VehicleCreateBrowser
                ){
                    HideMBrowser(playerid);
                }

                if(
                    cbrowserid == g_VehicleColorBrowser[0] ||
                    cbrowserid == g_VehicleColorBrowser[1]
                ){
                    HideCBrowser(playerid);
                }

                if(
                    dialogid == g_VehicleMainDialog ||
                    dialogid == g_VehicleEditDialog ||
                    dialogid == g_VehicleXDialog ||
                    dialogid == g_VehicleYDialog ||
                    dialogid == g_VehicleZDialog ||
                    dialogid == g_VehicleRDialog
                ){
                    HidePlayerDialog(playerid);
                }

                g_pEditVehicle[playerid] = INVALID_VEHICLE_ID;
            }

            if(g_pSelectVehicleChoice[playerid] == vehicleid)
            {
                if(GetPlayerMBrowser(playerid) == g_VehicleSelectBrowser)
                    HideMBrowserModel(playerid);

                g_pSelectVehicleChoice[playerid] = INVALID_VEHICLE_ID;
            }

            for(new listitem; listitem < MAX_MBROWSER_PAGESIZE; listitem ++)
            {
                if(g_pSelectVehicleResult[playerid][listitem] == vehicleid)
                {
                    if(GetPlayerMBrowser(playerid) == g_VehicleSelectBrowser)
                        HideMBrowserListItem(playerid, listitem);

                    g_pSelectVehicleResult[playerid][listitem] = INVALID_VEHICLE_ID;
                }
            }
        }
    }
    return DestroyVehicle(vehicleid);
}
#if defined _ALS_DestroyVehicle
    #undef DestroyVehicle
#else
    #define _ALS_DestroyVehicle
#endif
#define DestroyVehicle v_DestroyVehicle

/******************************************************************************/

stock v_ChangeVehicleColor(vehicleid, color1, color2)
{
    new success = ChangeVehicleColor(vehicleid, color1, color2);
    if(success)
    {
        g_VehicleColor[vehicleid - 1][0] = color1;
        g_VehicleColor[vehicleid - 1][1] = color2;
    }
    return success;
}
#if defined _ALS_ChangeVehicleColor
    #undef ChangeVehicleColor
#else
    #define _ALS_ChangeVehicleColor
#endif
#define ChangeVehicleColor v_ChangeVehicleColor

/******************************************************************************/

stock v_ChangeVehiclePaintjob(vehicleid, paintjobid)
{
    g_VehiclePaintjob{vehicleid - 1} = paintjobid;
    return ChangeVehiclePaintjob(vehicleid, paintjobid);
}
#if defined _ALS_ChangeVehiclePaintjob
    #undef ChangeVehiclePaintjob
#else
    #define _ALS_ChangeVehiclePaintjob
#endif
#define ChangeVehiclePaintjob v_ChangeVehiclePaintjob

/******************************************************************************/

stock v_AddVehicleComponent(vehicleid, componentid)
{
    new modelid = GetVehicleModel(vehicleid),
        success;

    if( IsVehicleComponentCompatible(modelid, componentid) )
    {
        success = AddVehicleComponent(vehicleid, componentid);
        if(success)
        {
            new slot = GetVehicleComponentType(componentid);
            g_VehicleComponent[vehicleid - 1][slot] = componentid;
        }
    }
    return success;
}
#if defined _ALS_AddVehicleComponent
    #undef AddVehicleComponent
#else
    #define _ALS_AddVehicleComponent
#endif
#define AddVehicleComponent v_AddVehicleComponent

/******************************************************************************/
