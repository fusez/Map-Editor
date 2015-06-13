/******************************************************************************/

public OnFilterScriptInit()
{
    CreateDialog(g_VehicleMainDialog);
    CreateDialog(g_VehicleEditDialog);
    CreateDialog(g_VehicleXDialog);
    CreateDialog(g_VehicleYDialog);
    CreateDialog(g_VehicleZDialog);
    CreateDialog(g_VehicleRDialog);

    CreateMBrowser(g_VehicleSelectBrowser, "Select Vehicle", "Select");
    CreateMBrowser(g_VehicleCreateBrowser, "Create Vehicle", "Create");

    for(new i; i < 2; i ++)
        CreateCBrowser ( g_VehicleColorBrowser[i], sprintf("Vehicle Color %i", i + 1) );

    #if defined v_OnFilterScriptInit
        v_OnFilterScriptInit();
    #endif
}
#if defined _ALS_OnFilterScriptInit
    #undef OnFilterScriptInit
#else
    #define _ALS_OnFilterScriptInit
#endif
#define OnFilterScriptInit v_OnFilterScriptInit
#if defined v_OnFilterScriptInit
    forward v_OnFilterScriptInit();
#endif

/******************************************************************************/

public OnPlayerDisconnect(playerid, reason)
{
    if(g_pEditVehicleObject[playerid] != INVALID_OBJECT_ID)
        DestroyPlayerObject(playerid, g_pEditVehicleObject[playerid]);

    g_pEditVehicle                [playerid] = INVALID_VEHICLE_ID;
    g_pEditVehicleObject        [playerid] = INVALID_OBJECT_ID;

    g_pSelectVehicleChoice        [playerid] = INVALID_VEHICLE_ID;
    g_pCreateVehicleChoice        [playerid] = 0;

    g_pSelectVehiclePage        [playerid] = 0;
    g_pCreateVehiclePage        [playerid] = 0;

    g_pSelectVehicleSearch        [playerid] = "";
    g_pCreateVehicleSearch        [playerid] = "";

    for(new listitem; listitem < MAX_MBROWSER_PAGESIZE; listitem ++)
    {
        g_pSelectVehicleResult    [playerid][listitem] = INVALID_VEHICLE_ID;
        g_pCreateVehicleResult    [playerid][listitem] = 0;
    }

    for(new i; i < 2; i ++)
        g_pColorVehiclePage        [playerid][i] = 0;

    for(new i; i < 2; i ++)
        g_pVehicleColor            [playerid][i] = 0;

    #if defined v_OnPlayerDisconnect
        v_OnPlayerDisconnect(playerid, reason);
    #endif
}
#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect v_OnPlayerDisconnect
#if defined v_OnPlayerDisconnect
    forward v_OnPlayerDisconnect(playerid, reason);
#endif

/******************************************************************************/

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
    g_VehicleColor[vehicleid - 1][0] = color1;
    g_VehicleColor[vehicleid - 1][1] = color2;

    #if defined v_OnVehicleRespray
        return v_OnVehicleRespray(playerid, vehicleid, color1, color2);
    #endif
}
#if defined _ALS_OnVehicleRespray
    #undef OnVehicleRespray
#else
    #define _ALS_OnVehicleRespray
#endif
#define OnVehicleRespray v_OnVehicleRespray
#if defined v_OnVehicleRespray
    forward v_OnVehicleRespray(playerid, vehicleid, color1, color2);
#endif

/******************************************************************************/

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
    g_VehiclePaintjob{vehicleid - 1} = paintjobid;

    #if defined v_OnVehiclePaintjob
        v_OnVehiclePaintjob(playerid, vehicleid, paintjobid);
    #endif
}
#if defined _ALS_OnVehiclePaintjob
    #undef OnVehiclePaintjob
#else
    #define _ALS_OnVehiclePaintjob
#endif
#define OnVehiclePaintjob v_OnVehiclePaintjob
#if defined v_OnVehiclePaintjob
    forward v_OnVehiclePaintjob(playerid, vehicleid, paintjobid);
#endif

/******************************************************************************/

public OnVehicleMod(playerid, vehicleid, componentid)
{
    new
        modelid = GetVehicleModel(vehicleid),
        compatible = IsVehicleComponentCompatible(modelid, componentid)
    ;

    if(compatible)
    {
        new slot = GetVehicleComponentType(componentid);
        g_VehicleComponent[vehicleid - 1][slot] = componentid;
    }

    #if defined v_OnVehicleMod
        return v_OnVehicleMod(playerid, vehicleid, componentid);
    #else
        return compatible;
    #endif
}
#if defined _ALS_OnVehicleMod
    #undef OnVehicleMod
#else
    #define _ALS_OnVehicleMod
#endif
#define OnVehicleMod v_OnVehicleMod
#if defined v_OnVehicleMod
    forward v_OnVehicleMod(playerid, vehicleid, componentid);
#endif

/******************************************************************************/

public OnEnterExitModShop(playerid, enterexit, interiorid)
{
    new
        vehicleid = GetPlayerVehicleID(playerid),
        worldid = (enterexit) ? (playerid) : (0)
    ;

    if(!enterexit && g_VehicleTuningTeleported{vehicleid - 1}) // leave
    {
        SetVehiclePos(vehicleid,
            g_VehicleTuningPosition[vehicleid - 1][0],
            g_VehicleTuningPosition[vehicleid - 1][1],
            g_VehicleTuningPosition[vehicleid - 1][2]
        );

        SetVehicleZAngle(vehicleid,
            g_VehicleTuningPosition[vehicleid - 1][3]
        );

        g_VehicleTuningTeleported{vehicleid - 1} = false;
        for(new i; i < 4; i ++)
            g_VehicleTuningPosition[vehicleid - 1][i] = 0.0;
    }

    SetVehicleVirtualWorld(vehicleid, worldid);
    for(new passengerid; passengerid < MAX_PLAYERS; passengerid ++)
    {
        if(!IsPlayerConnected(passengerid))
            continue;

        if(GetPlayerVehicleID(passengerid) == vehicleid)
            SetPlayerVirtualWorld(passengerid, worldid);
    }

    #if defined v_OnEnterExitModShop
        v_OnEnterExitModShop(playerid, enterexit, interiorid);
    #endif
}
#if defined _ALS_OnEnterExitModShop
    #undef OnEnterExitModShop
#else
    #define _ALS_OnEnterExitModShop
#endif
#define OnEnterExitModShop v_OnEnterExitModShop
#if defined v_OnEnterExitModShop
    forward v_OnEnterExitModShop(playerid, enterexit, interiorid);
#endif

/******************************************************************************/

public OnVehicleSpawn(vehicleid)
{
    new
        color[2],
        paintjobid = GetVehiclePaintjob(vehicleid)
    ;

    GetVehicleColor(vehicleid, color[0], color[1]);
    ChangeVehicleColor(vehicleid, color[0], color[1]);

    if(paintjobid != 3)
        ChangeVehiclePaintjob(vehicleid, paintjobid);

    for(new slot; slot < 14; slot ++)
    {
        new componentid = g_VehicleComponent[vehicleid - 1][slot];
        if(componentid != 0)
            AddVehicleComponent(vehicleid, componentid);
    }

    for(new objectid = 1; objectid <= MAX_OBJECTS; objectid ++)
    {
        if(!IsValidObject(objectid))
            continue;

        if(GetObjectAttachedToVehicle(objectid) == vehicleid)
        {
            new
                Float:x,
                Float:y,
                Float:z,
                Float:rx,
                Float:ry,
                Float:rz
            ;

            GetObjectAttachOffset(objectid, x, y, z, rx, ry, rz);
            AttachObjectToVehicle(objectid, vehicleid, x, y, z, rx, ry, rz);
        }
    }

    #if defined v_OnVehicleSpawn
        v_OnVehicleSpawn(vehicleid);
    #endif
}
#if defined _ALS_OnVehicleSpawn
    #undef OnVehicleSpawn
#else
    #define _ALS_OnVehicleSpawn
#endif
#define OnVehicleSpawn v_OnVehicleSpawn
#if defined v_OnVehicleSpawn
    forward v_OnVehicleSpawn(vehicleid);
#endif

/******************************************************************************/

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == g_VehicleMainDialog)
    {
        if(!response)
            return 1;

        switch(listitem)
        {
            case 0:
                ShowMBrowser(playerid, g_VehicleSelectBrowser);
            case 1:
                  ShowMBrowser(playerid, g_VehicleCreateBrowser);
        }
        return 1;
    }
    else if(dialogid == g_VehicleEditDialog)
    {
        if(!response)
        {
            g_pEditVehicle[playerid] = INVALID_VEHICLE_ID;
            ShowPlayerVehicleDialog(playerid, g_VehicleMainDialog);
            return 1;
        }

        switch(listitem)
        {
            case 0: // Remove
            {
                new
                    vehicleid = g_pEditVehicle[playerid],
                    modelid = GetVehicleModel(vehicleid)
                ;

                DestroyVehicle(vehicleid);
                ShowPlayerVehicleDialog(playerid, g_VehicleMainDialog);

                SendClientMessage(playerid, RGBA_GREEN,
                    sprintf("You have removed the vehicle \"%s\".", GetVehicleModelName(modelid))
                );
            }
            case 1: // Duplicate
            {
                new vehicleid = DuplicateVehicle(g_pEditVehicle[playerid]);
                if(vehicleid == INVALID_VEHICLE_ID)
                    SendClientMessage(playerid, RGBA_RED, "This vehicle could not be duplicated!");
                else
                {
                    g_pEditVehicle[playerid] = vehicleid;

                    new modelid = GetVehicleModel(vehicleid);
                    SendClientMessage(playerid, RGBA_GREEN,
                        sprintf("You have duplicated the vehicle \"%s\".", GetVehicleModelName(modelid))
                    );
                }
                ShowPlayerVehicleDialog(playerid, g_VehicleEditDialog);
            }
            case 2: // Move
            {
                new
                    vehicleid = g_pEditVehicle[playerid],
                    modelid = GetVehicleModel(vehicleid),
                    Float:x,
                    Float:y,
                    Float:z,
                    Float:r,
                    objectid
                ;

                GetVehiclePos(vehicleid, x, y, z);
                GetVehicleZAngle(vehicleid, r);

                if(g_pEditVehicleObject[playerid] != INVALID_OBJECT_ID)
                    DestroyPlayerObject(playerid, g_pEditVehicleObject[playerid]);
                g_pEditVehicleObject[playerid] = CreatePlayerObject(playerid, 19300, x, y, z, 0.0, 0.0, r);
                objectid = g_pEditVehicleObject[playerid];

                if(objectid == INVALID_OBJECT_ID)
                {
                    ShowPlayerVehicleDialog(playerid, g_VehicleEditDialog);
                    SendClientMessage(playerid, RGBA_RED, "This vehicle could not be moved!");
                    return 1;
                }

                SavePlayerObjectPos(playerid, objectid, x, y, z);
                SavePlayerObjectRot(playerid, objectid, 0.0, 0.0, r);
                EditPlayerObject(playerid, objectid);

                SendClientMessage(playerid, RGBA_GREEN,
                    sprintf("You are now moving the vehicle \"%s\".", GetVehicleModelName(modelid))
                );
            }
            case 3: // X
                ShowPlayerVehicleDialog(playerid, g_VehicleXDialog);
            case 4: // Y
                ShowPlayerVehicleDialog(playerid, g_VehicleYDialog);
            case 5: // Z
                ShowPlayerVehicleDialog(playerid, g_VehicleZDialog);
            case 6: // R
                ShowPlayerVehicleDialog(playerid, g_VehicleRDialog);
            case 7: // Color 1
                ShowCBrowser(playerid, g_VehicleColorBrowser[0], g_pColorVehiclePage[playerid][0]);
            case 8: // Color 2
                ShowCBrowser(playerid, g_VehicleColorBrowser[1], g_pColorVehiclePage[playerid][1]);
            case 9: // Repair
            {
                new
                    vehicleid = g_pEditVehicle[playerid],
                    modelid = GetVehicleModel(vehicleid)
                ;

                RepairVehicle(vehicleid);

                SendClientMessage(playerid, RGBA_GREEN,
                    sprintf("You have repaired the vehicle \"%s\".",
                        GetVehicleModelName(modelid)
                    )
                );

                ShowPlayerVehicleDialog(playerid, dialogid);
            }
            case 10: // Tune
            {
                new
                    vehicleid = g_pEditVehicle[playerid],
                    modelid = GetVehicleModel(vehicleid),
                    tuningshopid = GetVehicleModelTuningShop(modelid)
                ;

                if(tuningshopid == -1)
                {
                    SendClientMessage(playerid, RGBA_RED, "This vehicle cannot be tuned!");
                    ShowPlayerVehicleDialog(playerid, g_VehicleEditDialog);
                    return 1;
                }

                g_VehicleTuningTeleported{vehicleid - 1} = true;

                GetVehiclePos(vehicleid,
                    g_VehicleTuningPosition[vehicleid - 1][0],
                    g_VehicleTuningPosition[vehicleid - 1][1],
                    g_VehicleTuningPosition[vehicleid - 1][2]
                );

                GetVehicleZAngle(vehicleid,
                    g_VehicleTuningPosition[vehicleid - 1][3]
                );

                for(new driverid; driverid < MAX_PLAYERS; driverid ++)
                {
                    if(!IsPlayerConnected(driverid))
                        continue;

                    if(driverid == playerid)
                        continue;

                    if(GetPlayerState(driverid) != PLAYER_STATE_DRIVER)
                        continue;

                    if(GetPlayerVehicleID(driverid) == vehicleid)
                    {
                        SetPlayerPos(driverid,
                            g_VehicleTuningPosition[vehicleid - 1][0],
                            g_VehicleTuningPosition[vehicleid - 1][1],
                            g_VehicleTuningPosition[vehicleid - 1][2]
                        );

                        SetPlayerFacingAngle(driverid,
                            g_VehicleTuningPosition[vehicleid - 1][3]
                        );
                    }
                }

                new
                    Float:x,
                    Float:y,
                    Float:z,
                    Float:a
                ;

                GetTuningShopPosition(tuningshopid, x, y, z, a);
                SetVehiclePos(vehicleid, x, y, z);
                SetVehicleZAngle(vehicleid, a);

                if(GetPlayerVehicleID(playerid) != vehicleid || GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
                    PutPlayerInVehicle(playerid, vehicleid, 0);

                CancelSelectTextDraw(playerid);
            }
            case 11: // Attach Selected Object
            {
                new
                    objectid = g_pSelectedAttachObject[playerid],
                    attachtoid = g_pEditVehicle[playerid]
                ;

                if(objectid == INVALID_OBJECT_ID)
                    SendClientMessage(playerid, RGBA_RED, "You have not selected any object to attach!");
                else
                {
                    new
                        object_model = GetObjectModel(objectid),
                        vehicle_model = GetVehicleModel(attachtoid),
                        Float:x,
                        Float:y,
                        Float:z,
                        Float:rx,
                        Float:ry,
                        Float:rz
                    ;

                    GetObjectAttachOffset(objectid, x, y, z, rx, ry, rz);
                    AttachObjectToVehicle(objectid, attachtoid, x, y, z, rx, ry, rz);

                    g_pEditObject[playerid] = objectid;
                    g_pSelectedAttachObject[playerid] = INVALID_OBJECT_ID;

                    SendClientMessage(playerid, RGBA_GREEN,
                        sprintf("You have attached the object \"%s\" to the vehicle \"%s\".",
                            GetObjectModelName(object_model),
                            GetVehicleModelName(vehicle_model)
                        )
                    );
                }
                ShowPlayerObjectDialog(playerid, g_ObjectEditDialog);
            }
        }
        return 1;
    }
    else if(
        dialogid == g_VehicleXDialog ||
        dialogid == g_VehicleYDialog ||
        dialogid == g_VehicleZDialog
    ){
        if(!response)
        {
            ShowPlayerVehicleDialog(playerid, g_VehicleEditDialog);
            return 1;
        }

        new movement_type[2];
        if(dialogid == g_VehicleXDialog)
            movement_type = "x";
        else if(dialogid == g_VehicleYDialog)
            movement_type = "y";
        else if(dialogid == g_VehicleZDialog)
            movement_type = "z";

        if(isempty(inputtext))
        {
            SendClientMessage(playerid, RGBA_RED,
                sprintf("Vehicle %s position could not be set!", movement_type)
            );

            ShowPlayerVehicleDialog(playerid, dialogid);

            return 1;
        }

        new
            vehicleid = g_pEditVehicle[playerid],
            modelid = GetVehicleModel(vehicleid),
            Float:amount = floatstr(inputtext),
            Float:x,
            Float:y,
            Float:z
        ;

        GetVehiclePos(vehicleid, x, y, z);
        if(dialogid == g_VehicleXDialog)
            SetVehiclePos(vehicleid, amount, y, z);
        else if(dialogid == g_VehicleYDialog)
            SetVehiclePos(vehicleid, x, amount, z);
        else if(dialogid == g_VehicleZDialog)
            SetVehiclePos(vehicleid, x, y, amount);

        SendClientMessage(playerid, RGBA_GREEN,
            sprintf("You have set the %s position of the vehicle \"%s\" to %.4f.",
                movement_type, GetVehicleModelName(modelid), amount
            )
        );

        ShowPlayerVehicleDialog(playerid, g_VehicleEditDialog);

        return 1;
    }
    else if(dialogid == g_VehicleRDialog)
    {
        if(!response)
        {
            ShowPlayerVehicleDialog(playerid, g_VehicleEditDialog);
            return 1;
        }

        if(isempty(inputtext))
        {
            ShowPlayerVehicleDialog(playerid, dialogid);
            SendClientMessage(playerid, RGBA_RED, "Vehicle rotation could not be set!");
            return 1;
        }

        new
            vehicleid = g_pEditVehicle[playerid],
            modelid = GetVehicleModel(vehicleid),
            Float:a = floatstr(inputtext)
        ;

        SetVehicleZAngle(vehicleid, a);
        ShowPlayerVehicleDialog(playerid, g_VehicleEditDialog);
        SendClientMessage(playerid, RGBA_GREEN,
            sprintf("You have set the rotation of the vehicle \"%s\" to \"%.4f\".", GetVehicleModelName(modelid), a)
        );
        return 1;
    }

    #if defined v_OnDialogResponse
        return v_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
    #else
        return 0;
    #endif
}
#if defined _ALS_OnDialogResponse
    #undef OnDialogResponse
#else
    #define _ALS_OnDialogResponse
#endif
#define OnDialogResponse v_OnDialogResponse
#if defined v_OnDialogResponse
    forward v_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);
#endif

/******************************************************************************/

public OnPlayerEditObject(playerid, playerobject, objectid, response, Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ)
{
    if(playerobject && objectid == g_pEditVehicleObject[playerid])
    {
        switch(response)
        {
            case EDIT_RESPONSE_CANCEL:
            {
                new
                    vehicleid = g_pEditVehicle[playerid],
                    modelid = GetVehicleModel(vehicleid),
                    Float:x,
                    Float:y,
                    Float:z,
                    Float:rx,
                    Float:ry,
                    Float:rz
                ;

                LoadPlayerObjectPos(playerid, objectid, x, y, z);
                LoadPlayerObjectRot(playerid, objectid, rx, ry, rz);
                SetVehiclePos(vehicleid, x, y, z);
                SetVehicleZAngle(vehicleid, rz);

                DestroyPlayerObject(playerid, objectid);
                g_pEditVehicleObject[playerid] = INVALID_OBJECT_ID;

                ShowPlayerVehicleDialog(playerid, g_VehicleEditDialog);
                SelectTextDraw(playerid, RGBA_RED);
                SendClientMessage(playerid, RGBA_GREEN,
                    sprintf("You have cancelled moving the vehicle \"%s\".", GetVehicleModelName(modelid))
                );
            }
            case EDIT_RESPONSE_FINAL:
            {
                new
                    vehicleid = g_pEditVehicle[playerid],
                    modelid = GetVehicleModel(vehicleid)
                ;

                SetVehiclePos(vehicleid, fX, fY, fZ);
                SetVehicleZAngle(vehicleid, fRotZ);

                DestroyPlayerObject(playerid, objectid);
                g_pEditVehicleObject[playerid] = INVALID_OBJECT_ID;

                ShowPlayerVehicleDialog(playerid, g_VehicleEditDialog);
                SelectTextDraw(playerid, 0xFF0000FF);
                SendClientMessage(playerid, RGBA_GREEN,
                    sprintf("You have finished moving the vehicle \"%s\".", GetVehicleModelName(modelid))
                );
            }
            case EDIT_RESPONSE_UPDATE:
            {
                new vehicleid = g_pEditVehicle[playerid];
                SetVehiclePos(vehicleid, fX, fY, fZ);
                SetVehicleZAngle(vehicleid, fRotZ);
            }
        }
    }

    #if defined v_OnPlayerEditObject
        v_OnPlayerEditObject(playerid, playerobject, objectid, response, Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ);
    #endif
}
#if defined _ALS_OnPlayerEditObject
    #undef OnPlayerEditObject
#else
    #define _ALS_OnPlayerEditObject
#endif
#define OnPlayerEditObject v_OnPlayerEditObject
#if defined v_OnPlayerEditObject
    forward v_OnPlayerEditObject(playerid, playerobject, objectid, response, Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ);
#endif

/******************************************************************************/

public OnMBrowserResponse(playerid, browserid, response, page, listitem, search[])
{
    if(browserid == g_VehicleSelectBrowser)
    {
        switch(response)
        {
            case MBROWSER_RESPONSE_CLOSE:
            {
                HideMBrowser(playerid);
                ShowPlayerVehicleDialog(playerid, g_VehicleMainDialog);
            }
            case MBROWSER_RESPONSE_SEARCH:
            {
                format(g_pSelectVehicleSearch[playerid], MAX_MBROWSER_SEARCH, search);
                g_pSelectVehiclePage[playerid] = 0;
                ShowMBrowser(playerid, browserid);
            }
            case MBROWSER_RESPONSE_PAGE_BACK:
            {
                if(g_pSelectVehiclePage[playerid] > 0)
                {
                    g_pSelectVehiclePage[playerid] --;
                    ShowMBrowser(playerid, browserid);
                }
            }
            case MBROWSER_RESPONSE_PAGE_NEXT:
            {
                new min_pageitem = (g_pSelectVehiclePage[playerid] + 1) * MAX_MBROWSER_PAGESIZE;
                if(min_pageitem < MAX_VEHICLES)
                {
                    g_pSelectVehiclePage[playerid] ++;
                    ShowMBrowser(playerid, browserid);
                }
            }
            case MBROWSER_RESPONSE_PAGE_SET:
            {
                new min_pageitem = page * MAX_MBROWSER_PAGESIZE;
                if(min_pageitem < MAX_VEHICLES)
                {
                    g_pSelectVehiclePage[playerid] = page;
                    ShowMBrowser(playerid, browserid);
                }
            }
            case MBROWSER_RESPONSE_BUTTON:
            {
                g_pEditVehicle[playerid] = g_pSelectVehicleChoice[playerid];

                new
                    vehicleid = g_pEditVehicle[playerid],
                    modelid = GetVehicleModel(vehicleid)
                ;

                HideMBrowser(playerid);
                ShowPlayerVehicleDialog(playerid, g_VehicleEditDialog);
                SendClientMessage(playerid, RGBA_GREEN,
                    sprintf("You have selected the vehicle \"%s\".", GetVehicleModelName(modelid))
                );
            }
            case MBROWSER_RESPONSE_LISTITEM:
            {
                new
                    pageitem = listitem + (g_pSelectVehiclePage[playerid] * MAX_MBROWSER_PAGESIZE),
                    is_searching = strlen(g_pSelectVehicleSearch[playerid]) > 0,
                    vehicleid = (is_searching) ? (g_pSelectVehicleResult[playerid][listitem]) : (pageitem + 1)
                ;

                if(IsValidVehicle(vehicleid))
                {
                    g_pSelectVehicleChoice[playerid] = vehicleid;

                    new
                        modelid = GetVehicleModel(vehicleid),
                        color[2]
                    ;

                    GetVehicleColor(vehicleid, color[0], color[1]);
                    SetMBrowserModel(playerid, modelid, color[0], color[1]);
                }
                else
                {
                    g_pSelectVehicleChoice[playerid] = INVALID_VEHICLE_ID;

                    HideMBrowserListItem(playerid, listitem);
                    HideMBrowserModel(playerid);
                }
            }
        }
        return 1;
    }
    else if(browserid == g_VehicleCreateBrowser)
    {
        switch(response)
        {
            case MBROWSER_RESPONSE_CLOSE:
            {
                HideMBrowser(playerid);
                ShowPlayerVehicleDialog(playerid, g_VehicleMainDialog);
            }
            case MBROWSER_RESPONSE_SEARCH:
            {
                format(g_pCreateVehicleSearch[playerid], MAX_MBROWSER_SEARCH, search);
                g_pCreateVehiclePage[playerid] = 0;
                ShowMBrowser(playerid, browserid);
            }
            case MBROWSER_RESPONSE_PAGE_BACK:
            {
                if(g_pCreateVehiclePage[playerid] > 0)
                {
                    g_pCreateVehiclePage[playerid] --;
                    ShowMBrowser(playerid, browserid);
                }
            }
            case MBROWSER_RESPONSE_PAGE_NEXT:
            {
                new min_pageitem = (g_pCreateVehiclePage[playerid] + 1) * MAX_MBROWSER_PAGESIZE;
                if(min_pageitem < 212)
                {
                    g_pCreateVehiclePage[playerid] ++;
                    ShowMBrowser(playerid, browserid);
                }
            }
            case MBROWSER_RESPONSE_PAGE_SET:
            {
                new min_pageitem = page * MAX_MBROWSER_PAGESIZE;
                if(min_pageitem < 212)
                {
                    g_pCreateVehiclePage[playerid] = page;
                    ShowMBrowser(playerid, browserid);
                }
            }
            case MBROWSER_RESPONSE_BUTTON:
            {
                new
                    modelid = g_pCreateVehicleChoice[playerid],
                    Float:x,
                    Float:y,
                    Float:z,
                    vehicleid
                ;

                VectorToPos(playerid, x, y, z, 10.0);
                g_pEditVehicle[playerid] = CreateVehicle(modelid, x, y, z, 0.0, g_pVehicleColor[playerid][0], g_pVehicleColor[playerid][1], -1);
                vehicleid = g_pEditVehicle[playerid];

                if(vehicleid == INVALID_VEHICLE_ID)
                {
                    SendClientMessage(playerid, RGBA_RED, "This vehicle could not be created!");
                    ShowPlayerVehicleDialog(playerid, g_VehicleMainDialog);
                    return 1;
                }

                HideMBrowser(playerid);
                ShowPlayerVehicleDialog(playerid, g_VehicleEditDialog);
                SendClientMessage(playerid, RGBA_GREEN,
                    sprintf("You have created the vehicle \"%s\".", GetVehicleModelName(modelid))
                );
            }
            case MBROWSER_RESPONSE_LISTITEM:
            {
                new
                    pageitem = listitem + (g_pCreateVehiclePage[playerid] * MAX_MBROWSER_PAGESIZE),
                    is_searching = strlen(g_pCreateVehicleSearch[playerid]) > 0,
                    modelid = (is_searching) ? (g_pCreateVehicleResult[playerid][listitem]) : (pageitem + 400)
                ;

                g_pCreateVehicleChoice[playerid] = modelid;
                for(new i; i < 2; i ++)
                    g_pVehicleColor[playerid][i] = random(256);

                SetMBrowserModel(
                    playerid,
                    modelid,
                    g_pVehicleColor[playerid][0],
                    g_pVehicleColor[playerid][1]
                );
            }
        }
        return 1;
    }

    #if defined v_OnMBrowserResponse
        return v_OnMBrowserResponse(playerid, browserid, response, page, listitem, search);
    #else
        return 0;
    #endif
}
#if defined _ALS_OnMBrowserResponse
    #undef OnMBrowserResponse
#else
    #define _ALS_OnMBrowserResponse
#endif
#define OnMBrowserResponse v_OnMBrowserResponse
#if defined v_OnMBrowserResponse
    forward v_OnMBrowserResponse(playerid, browserid, response, page, listitem, search[]);
#endif

/******************************************************************************/

public OnMBrowserShown(playerid, browserid)
{
    if(browserid == g_VehicleSelectBrowser)
    {
        SetMBrowserPage(playerid, g_pSelectVehiclePage[playerid]);

        if( strlen(g_pSelectVehicleSearch[playerid]) > 0 )
        {
            SetMBrowserSearch(playerid, g_pSelectVehicleSearch[playerid]);

            for(new listitem; listitem < MAX_MBROWSER_PAGESIZE; listitem ++)
            {
                g_pSelectVehicleResult[playerid][listitem] = INVALID_VEHICLE_ID;
                HideMBrowserListItem(playerid, listitem);
            }

            new
                min_pageitem = g_pSelectVehiclePage[playerid] * MAX_MBROWSER_PAGESIZE,
                max_pageitem = min_pageitem + MAX_MBROWSER_PAGESIZE,
                search_value = strval(g_pSelectVehicleSearch[playerid])
            ;

            for(new vehicleid = 1, matches; vehicleid <= MAX_VEHICLES; vehicleid ++)
            {
                if(!IsValidVehicle(vehicleid))
                    continue;

                new modelid = GetVehicleModel(vehicleid);

                if(
                    (search_value != 0 && search_value == modelid) ||
                    strfind(GetVehicleModelName(modelid), g_pSelectVehicleSearch[playerid], true) != -1
                ){
                    if(matches >= min_pageitem && matches < max_pageitem)
                    {
                        new listitem = matches - min_pageitem;

                        g_pSelectVehicleResult[playerid][listitem] = vehicleid;
                        SetMBrowserListItem(playerid, listitem, GetVehicleModelName(modelid));
                    }

                    if(++ matches >= max_pageitem)
                        break;
                }
            }
        }
        else
        {
            HideMBrowserSearch(playerid);

            for(new listitem; listitem < MAX_MBROWSER_PAGESIZE; listitem ++)
            {
                new
                    pageitem = listitem + (g_pSelectVehiclePage[playerid] * MAX_MBROWSER_PAGESIZE),
                    vehicleid = pageitem + 1
                ;

                if(IsValidVehicle(vehicleid))
                {
                    new modelid = GetVehicleModel(vehicleid);
                    SetMBrowserListItem(playerid, listitem, GetVehicleModelName(modelid));
                }
                else
                    HideMBrowserListItem(playerid, listitem);
            }
        }

        new vehicleid = g_pSelectVehicleChoice[playerid];
        if(vehicleid == INVALID_VEHICLE_ID)
            HideMBrowserModel(playerid);
        else
        {
            new
                modelid = GetVehicleModel(vehicleid),
                color[2]
            ;

            GetVehicleColor(vehicleid, color[0], color[1]);
            SetMBrowserModel(playerid, modelid, color[0], color[1]);
        }
        return 1;
    }
    else if(browserid == g_VehicleCreateBrowser)
    {
        SetMBrowserPage(playerid, g_pCreateVehiclePage[playerid]);

        if( strlen(g_pCreateVehicleSearch[playerid]) > 0 )
        {
            SetMBrowserSearch(playerid, g_pCreateVehicleSearch[playerid]);

            for(new listitem; listitem < MAX_MBROWSER_PAGESIZE; listitem ++)
            {
                g_pCreateVehicleResult[playerid][listitem] = 0;
                HideMBrowserListItem(playerid, listitem);
            }

            new
                min_pageitem = g_pCreateVehiclePage[playerid] * MAX_MBROWSER_PAGESIZE,
                max_pageitem = min_pageitem + MAX_MBROWSER_PAGESIZE,
                search_value = strval(g_pCreateVehicleSearch[playerid])
            ;

            for(new modelid = 400, matches; modelid <= 611; modelid ++)
            {
                   if(
                    (search_value != 0 && search_value == modelid) ||
                    strfind(GetVehicleModelName(modelid), g_pCreateVehicleSearch[playerid], true) != -1
                ){
                    if(matches >= min_pageitem && matches < max_pageitem)
                    {
                        new listitem = matches - min_pageitem;

                        g_pCreateVehicleResult[playerid][listitem] = modelid;
                        SetMBrowserListItem(playerid, listitem, GetVehicleModelName(modelid));
                    }

                    if(++ matches >= max_pageitem)
                        break;
                }
            }
        }
        else
        {
            HideMBrowserSearch(playerid);

            for(new listitem; listitem < MAX_MBROWSER_PAGESIZE; listitem ++)
            {
                new
                    pageitem = listitem + (g_pCreateVehiclePage[playerid] * MAX_MBROWSER_PAGESIZE),
                    modelid = pageitem + 400
                ;

                switch(modelid)
                {
                    case 400..611:
                        SetMBrowserListItem(playerid, listitem, GetVehicleModelName(modelid));
                    default:
                        HideMBrowserListItem(playerid, listitem);
                }
            }
        }

        new modelid = g_pCreateVehicleChoice[playerid];
        switch(modelid)
        {
            case 400..611:
                SetMBrowserModel(playerid, modelid, g_pVehicleColor[playerid][0], g_pVehicleColor[playerid][1]);
            default:
                HideMBrowserModel(playerid);
        }
        return 1;
    }

    #if defined v_OnMBrowserShown
        return v_OnMBrowserShown(playerid, browserid);
    #else
        return 0;
    #endif
}
#if defined _ALS_OnMBrowserShown
    #undef OnMBrowserShown
#else
    #define _ALS_OnMBrowserShown
#endif
#define OnMBrowserShown v_OnMBrowserShown
#if defined v_OnMBrowserShown
    forward v_OnMBrowserShown(playerid, browserid);
#endif

/******************************************************************************/

public OnCBrowserResponse(playerid, browserid, response, color)
{
    for(new i; i < 2; i ++)
    {
        if(browserid == g_VehicleColorBrowser[i])
        {
            switch(response)
            {
                case CBROWSER_RESPONSE_CLOSE:
                {
                    HideCBrowser(playerid);
                    ShowPlayerVehicleDialog(playerid, g_VehicleEditDialog);
                }
                case CBROWSER_RESPONSE_PAGE_BACK:
                {
                    if(g_pColorVehiclePage[playerid][i] > 0)
                        ShowCBrowser(playerid, browserid, -- g_pColorVehiclePage[playerid][i]);
                }
                case CBROWSER_RESPONSE_PAGE_NEXT:
                {
                    new min_pageitem = (g_pColorVehiclePage[playerid][i] + 1) * MAX_CBROWSER_PAGESIZE;
                    if(min_pageitem < g_MaxVehicleColors)
                        ShowCBrowser(playerid, browserid, ++ g_pColorVehiclePage[playerid][i]);
                }
                case CBROWSER_RESPONSE_COLOR:
                {
                    new
                        vehicleid = g_pEditVehicle[playerid],
                        pageitem = color + (g_pColorVehiclePage[playerid][i] * MAX_CBROWSER_PAGESIZE),
                        modelid = GetVehicleModel(vehicleid),
                        current_color[2]
                    ;

                    GetVehicleColor(vehicleid, current_color[0], current_color[1]);
                    switch(i)
                    {
                        case 0:
                            ChangeVehicleColor(vehicleid, pageitem, current_color[1]);
                        case 1:
                            ChangeVehicleColor(vehicleid, current_color[0], pageitem);
                    }

                    SendClientMessage(playerid, RGBA_GREEN,
                        sprintf("You have changed the color of the vehicle \"%s\".", GetVehicleModelName(modelid))
                    );
                }
            }
            return 1;
        }
    }

    #if defined v_OnCBrowserResponse
        return v_OnCBrowserResponse(playerid, browserid, response, color);
    #else
        return 0;
    #endif
}
#if defined _ALS_OnCBrowserResponse
    #undef OnCBrowserResponse
#else
    #define _ALS_OnCBrowserResponse
#endif
#define OnCBrowserResponse v_OnCBrowserResponse
#if defined v_OnCBrowserResponse
    forward v_OnCBrowserResponse(playerid, browserid, response, color);
#endif

/******************************************************************************/

public OnCBrowserShown(playerid, browserid, page)
{
    for(new i; i < 2; i ++)
    {
        if(browserid != g_VehicleColorBrowser[i])
            continue;

        for(new listitem; listitem < MAX_CBROWSER_PAGESIZE; listitem ++)
        {
            new pageitem = listitem + (page * MAX_CBROWSER_PAGESIZE);
            if(pageitem < g_MaxVehicleColors)
                SetCBrowserColor(playerid, listitem, g_VehicleColors[pageitem]);
            else
                HideCBrowserColor(playerid, listitem);
        }
        return 1;
    }

    #if defined v_OnCBrowserShown
        return v_OnCBrowserShown(playerid, browserid, page);
    #else
        return 0;
    #endif
}
#if defined _ALS_OnCBrowserShown
    #undef OnCBrowserShown
#else
    #define _ALS_OnCBrowserShown
#endif
#define OnCBrowserShown v_OnCBrowserShown
#if defined v_OnCBrowserShown
    forward v_OnCBrowserShown(playerid, browserid, page);
#endif

/******************************************************************************/

public OnToolbarResponse(playerid, response)
{
    if(response == TOOLBAR_VEHICLE)
        return ShowPlayerVehicleDialog(playerid, g_VehicleMainDialog), 1;

    #if defined v_OnToolbarResponse
        return v_OnToolbarResponse(playerid, response);
    #else
        return 0;
    #endif
}
#if defined _ALS_OnToolbarResponse
    #undef OnToolbarResponse
#else
    #define _ALS_OnToolbarResponse
#endif
#define OnToolbarResponse v_OnToolbarResponse
#if defined v_OnToolbarResponse
    forward v_OnToolbarResponse(playerid, response);
#endif

/******************************************************************************/
