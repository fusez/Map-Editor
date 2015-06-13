/******************************************************************************/

public OnFilterScriptInit()
{
    CreateDialog(g_PickupMainDialog);
    CreateDialog(g_PickupEditDialog);
    CreateDialog(g_PickupXDialog);
    CreateDialog(g_PickupYDialog);
    CreateDialog(g_PickupZDialog);

    CreateMBrowser(g_PickupSelectBrowser, "Select Pickup", "Select");
    CreateMBrowser(g_PickupCreateBrowser, "Create Pickup", "Create");

    #if defined pick_OnFilterScriptInit
        pick_OnFilterScriptInit();
    #endif
}
#if defined _ALS_OnFilterScriptInit
    #undef OnFilterScriptInit
#else
    #define _ALS_OnFilterScriptInit
#endif
#define OnFilterScriptInit pick_OnFilterScriptInit
#if defined pick_OnFilterScriptInit
    forward pick_OnFilterScriptInit();
#endif

/******************************************************************************/

public OnPlayerDisconnect(playerid, reason)
{
    if(g_pEditPickupObject[playerid] != INVALID_OBJECT_ID)
        DestroyPlayerObject(playerid, g_pEditPickupObject[playerid]);

    g_pEditPickupObject        [playerid] = INVALID_OBJECT_ID;
    g_pEditPickup            [playerid] = INVALID_PICKUP_ID;

    g_pSelectPickupChoice    [playerid] = INVALID_PICKUP_ID;
    g_pCreatePickupChoice    [playerid] = -1;

    g_pSelectPickupPage        [playerid] = 0;
    g_pCreatePickupPage        [playerid] = 0;

    g_pSelectPickupSearch    [playerid] = "";
    g_pCreatePickupSearch    [playerid] = "";

    for(new listitem; listitem < MAX_MBROWSER_PAGESIZE; listitem ++)
    {
        g_pSelectPickupResult    [playerid][listitem] = INVALID_PICKUP_ID;
        g_pCreatePickupResult    [playerid][listitem] = -1;
    }

    #if defined pick_OnPlayerDisconnect
        pick_OnPlayerDisconnect(playerid, reason);
    #endif
}
#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect pick_OnPlayerDisconnect
#if defined pick_OnPlayerDisconnect
    forward pick_OnPlayerDisconnect(playerid, reason);
#endif

/******************************************************************************/

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == g_PickupMainDialog)
    {
        if(!response)
            return 1;

        switch(listitem)
        {
            case 0:
                ShowMBrowser(playerid, g_PickupSelectBrowser);
            case 1:
                ShowMBrowser(playerid, g_PickupCreateBrowser);
        }
        return 1;
    }
    else if(dialogid == g_PickupEditDialog)
    {
        if(!response)
        {
            g_pEditPickup[playerid] = INVALID_PICKUP_ID;
            ShowPlayerPickupDialog(playerid, g_PickupMainDialog);
            return 1;
        }

        switch(listitem)
        {
            case 0: // Remove
            {
                new
                    pickupid = g_pEditPickup[playerid],
                    modelid = GetPickupModel(pickupid)
                ;

                DestroyPickup(pickupid);
                g_pEditPickup[playerid] = INVALID_PICKUP_ID;

                ShowPlayerPickupDialog(playerid, g_PickupMainDialog);
                SendClientMessage(playerid, RGBA_GREEN,
                    sprintf("You have removed the pickup \"%s\".", GetObjectModelName(modelid))
                );
            }
            case 1: // Duplicate
            {
                new
                    pickupid = g_pEditPickup[playerid],
                    modelid = GetPickupModel(pickupid),
                    Float:x,
                    Float:y,
                    Float:z
                ;

                GetPickupPos(pickupid, x, y, z);
                pickupid = CreatePickup(modelid, 1, x, y, z);
                if(pickupid == INVALID_PICKUP_ID)
                    SendClientMessage(playerid, RGBA_RED, "This pickup could not be duplicated!");
                else
                {
                    g_pEditPickup[playerid] = pickupid;
                    SendClientMessage(playerid, RGBA_GREEN,
                        sprintf("You have duplicated the pickup \"%s\".", GetObjectModelName(modelid))
                    );
                }
                ShowPlayerPickupDialog(playerid, g_PickupEditDialog);
            }
            case 2: // Move
            {
                new
                    pickupid = g_pEditPickup[playerid],
                    modelid = GetPickupModel(pickupid),
                    Float:x,
                    Float:y,
                    Float:z,
                    objectid
                ;

                GetPickupPos(pickupid, x, y, z);
                if(g_pEditPickupObject[playerid] != INVALID_OBJECT_ID)
                    DestroyPlayerObject(playerid, g_pEditPickupObject[playerid]);
                g_pEditPickupObject[playerid] = CreatePlayerObject(playerid, 19300, x, y, z, 0.0, 0.0, 0.0);
                objectid = g_pEditPickupObject[playerid];

                if(objectid == INVALID_OBJECT_ID)
                {
                    SendClientMessage(playerid, RGBA_RED, "This pickup could not be moved!");
                    ShowPlayerPickupDialog(playerid, g_PickupEditDialog);
                    return 1;
                }

                SavePlayerObjectPos(playerid, objectid, x, y, z);
                SavePlayerObjectRot(playerid, objectid, 0.0, 0.0, 0.0);
                EditPlayerObject(playerid, objectid);
                SendClientMessage(playerid, RGBA_GREEN,
                    sprintf("You are now moving the pickup \"%s\".", GetObjectModelName(modelid))
                );
            }
            case 3: // X
                ShowPlayerPickupDialog(playerid, g_PickupXDialog);
            case 4: // Y
                ShowPlayerPickupDialog(playerid, g_PickupYDialog);
            case 5: // Z
                ShowPlayerPickupDialog(playerid, g_PickupZDialog);
        }
        return 1;
    }
    else if(
        dialogid == g_PickupXDialog ||
        dialogid == g_PickupYDialog ||
        dialogid == g_PickupZDialog
    ){
        if(!response)
        {
            ShowPlayerPickupDialog(playerid, g_PickupEditDialog);
            return 1;
        }

        new movement_type[2];
        if(dialogid == g_PickupXDialog)
            movement_type = "x";
        else if(dialogid == g_PickupYDialog)
            movement_type = "y";
        else if(dialogid == g_PickupZDialog)
            movement_type = "z";

        if(isempty(inputtext))
        {
            ShowPlayerPickupDialog(playerid, dialogid);
            SendClientMessage(playerid, RGBA_RED,
                sprintf("Pickup %s position could not be set!", movement_type)
            );
            return 1;
        }

        new
            pickupid = g_pEditPickup[playerid],
            modelid = GetPickupModel(pickupid),
            Float:amount = floatstr(inputtext),
            Float:x,
            Float:y,
            Float:z
        ;

        GetPickupPos(pickupid, x, y, z);
        if(dialogid == g_PickupXDialog)
            x = amount;
        else if(dialogid == g_PickupYDialog)
            y = amount;
        else if(dialogid == g_PickupZDialog)
            z = amount;

        DestroyPickup(pickupid);
        g_pEditPickup[playerid] = CreatePickup(modelid, 1, x, y, z);

        ShowPlayerPickupDialog(playerid, g_PickupEditDialog);
        SendClientMessage(playerid, RGBA_GREEN,
            sprintf("You have set the %s position of the pickup \"%s\" to \"%.4f\".",
                movement_type, GetObjectModelName(modelid), amount
            )
        );
        return 1;
    }

    #if defined pick_OnDialogResponse
        return pick_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
    #else
        return 0;
    #endif
}
#if defined _ALS_OnDialogResponse
    #undef OnDialogResponse
#else
    #define _ALS_OnDialogResponse
#endif
#define OnDialogResponse pick_OnDialogResponse
#if defined pick_OnDialogResponse
    forward pick_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);
#endif

/******************************************************************************/

public OnPlayerEditObject(playerid, playerobject, objectid, response, Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ)
{
    if(playerobject && objectid == g_pEditPickupObject[playerid])
    {
        switch(response)
        {
            case EDIT_RESPONSE_CANCEL:
            {
                new
                    pickupid = g_pEditPickup[playerid],
                    modelid = GetPickupModel(pickupid),
                    Float:x,
                    Float:y,
                    Float:z
                ;

                LoadPlayerObjectPos(playerid, objectid, x, y, z);

                DestroyPickup(pickupid);
                DestroyPlayerObject(playerid, objectid);
                g_pEditPickup[playerid] = CreatePickup(modelid, 1, fX, fY, fZ);
                g_pEditPickupObject[playerid] = INVALID_OBJECT_ID;

                SelectTextDraw(playerid, RGBA_RED);
                ShowPlayerPickupDialog(playerid, g_PickupEditDialog);
                SendClientMessage(playerid, RGBA_GREEN,
                    sprintf("You have cancelled moving the pickup \"%s\".", GetObjectModelName(modelid))
                );
            }
            case EDIT_RESPONSE_FINAL:
            {
                new
                    pickupid = g_pEditPickup[playerid],
                    modelid = GetPickupModel(pickupid)
                ;

                DestroyPickup(pickupid);
                DestroyPlayerObject(playerid, objectid);
                g_pEditPickup[playerid] = CreatePickup(modelid, 1, fX, fY, fZ);
                g_pEditPickupObject[playerid] = INVALID_OBJECT_ID;

                SelectTextDraw(playerid, RGBA_RED);
                ShowPlayerPickupDialog(playerid, g_PickupEditDialog);
                SendClientMessage(playerid, RGBA_GREEN,
                    sprintf("You have finished moving the pickup \"%s\".", GetObjectModelName(modelid))
                );
            }
            case EDIT_RESPONSE_UPDATE:
            {
                new pickupid = g_pEditPickup[playerid],
                    modelid = GetPickupModel(pickupid);

                DestroyPickup(pickupid);
                g_pEditPickup[playerid] = CreatePickup(modelid, 1, fX, fY, fZ);
            }
        }
    }

    #if defined pick_OnPlayerEditObject
        pick_OnPlayerEditObject(playerid, playerobject, objectid, response, Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ);
    #endif
}
#if defined _ALS_OnPlayerEditObject
    #undef OnPlayerEditObject
#else
    #define _ALS_OnPlayerEditObject
#endif
#define OnPlayerEditObject pick_OnPlayerEditObject
#if defined pick_OnPlayerEditObject
    forward pick_OnPlayerEditObject(playerid, playerobject, objectid, response, Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ);
#endif

/******************************************************************************/

public OnMBrowserResponse(playerid, browserid, response, page, listitem, search[])
{
    if(browserid == g_PickupSelectBrowser)
    {
        switch(response)
        {
            case MBROWSER_RESPONSE_CLOSE:
            {
                HideMBrowser(playerid);
                ShowPlayerPickupDialog(playerid, g_PickupMainDialog);
            }
            case MBROWSER_RESPONSE_SEARCH:
            {
                format(g_pSelectPickupSearch[playerid], MAX_MBROWSER_SEARCH, search);
                g_pSelectPickupPage[playerid] = 0;
                ShowMBrowser(playerid, browserid);
            }
            case MBROWSER_RESPONSE_PAGE_BACK:
            {
                if(g_pSelectPickupPage[playerid] > 0)
                {
                    g_pSelectPickupPage[playerid] --;
                    ShowMBrowser(playerid, browserid);
                }
            }
            case MBROWSER_RESPONSE_PAGE_NEXT:
            {
                new min_pageitem = (g_pSelectPickupPage[playerid] + 1) * MAX_MBROWSER_PAGESIZE;
                if(min_pageitem < MAX_PICKUPS)
                {
                    g_pSelectPickupPage[playerid] ++;
                    ShowMBrowser(playerid, browserid);
                }
            }
            case MBROWSER_RESPONSE_PAGE_SET:
            {
                new min_pageitem = page * MAX_MBROWSER_PAGESIZE;
                if(min_pageitem < MAX_PICKUPS)
                {
                    g_pSelectPickupPage[playerid] = page;
                    ShowMBrowser(playerid, browserid);
                }
            }
            case MBROWSER_RESPONSE_BUTTON:
            {
                g_pEditPickup[playerid] = g_pSelectPickupChoice[playerid];

                new
                    pickupid = g_pEditPickup[playerid],
                    modelid = GetPickupModel(pickupid)
                ;

                HideMBrowser(playerid);
                ShowPlayerPickupDialog(playerid, g_PickupEditDialog);
                SendClientMessage(playerid, RGBA_GREEN,
                    sprintf("You have selected the pickup \"%s\".", GetObjectModelName(modelid))
                );
            }
            case MBROWSER_RESPONSE_LISTITEM:
            {
                new
                    pageitem = listitem + (g_pSelectPickupPage[playerid] * MAX_MBROWSER_PAGESIZE),
                    is_searching = strlen(g_pSelectPickupSearch[playerid]) > 0,
                    pickupid = (is_searching) ? (g_pSelectPickupResult[playerid][listitem]) : (pageitem)
                ;

                if(IsValidPickup(pickupid))
                {
                    g_pSelectPickupChoice[playerid] = pickupid;

                    new modelid = GetPickupModel(pickupid);
                    SetMBrowserModel(playerid, modelid);
                }
                else
                {
                    g_pSelectPickupChoice[playerid] = INVALID_PICKUP_ID;

                    HideMBrowserListItem(playerid, listitem);
                    HideMBrowserModel(playerid);
                }
            }
        }
        return 1;
    }
    else if(browserid == g_PickupCreateBrowser)
    {
        switch(response)
        {
            case MBROWSER_RESPONSE_CLOSE:
            {
                HideMBrowser(playerid);
                ShowPlayerPickupDialog(playerid, g_PickupMainDialog);
            }
            case MBROWSER_RESPONSE_SEARCH:
            {
                format(g_pCreatePickupSearch[playerid], MAX_MBROWSER_SEARCH, search);
                g_pCreatePickupPage[playerid] = 0;
                ShowMBrowser(playerid, browserid);
            }
            case MBROWSER_RESPONSE_PAGE_BACK:
            {
                if(g_pCreatePickupPage[playerid] > 0)
                {
                    g_pCreatePickupPage[playerid] --;
                    ShowMBrowser(playerid, browserid);
                }
            }
            case MBROWSER_RESPONSE_PAGE_NEXT:
            {
                new min_pageitem = (g_pCreatePickupPage[playerid] + 1) * MAX_MBROWSER_PAGESIZE;
                if(min_pageitem < g_MaxObjectModels)
                {
                    g_pCreatePickupPage[playerid] ++;
                    ShowMBrowser(playerid, browserid);
                }
            }
            case MBROWSER_RESPONSE_PAGE_SET:
            {
                new min_pageitem = page * MAX_MBROWSER_PAGESIZE;
                if(min_pageitem < g_MaxObjectModels)
                {
                    g_pCreatePickupPage[playerid] = page;
                    ShowMBrowser(playerid, browserid);
                }
            }
            case MBROWSER_RESPONSE_BUTTON:
            {
                new
                    model_index = g_pCreatePickupChoice[playerid],
                    modelid = g_ObjectModels[model_index][e_ObjectModelID],
                    Float:x,
                    Float:y,
                    Float:z,
                    pickupid
                ;

                VectorToPos(playerid, x, y, z, 10.0);
                g_pEditPickup[playerid] = CreatePickup(modelid, 1, x, y, z);
                pickupid = g_pEditPickup[playerid];

                if(pickupid == INVALID_PICKUP_ID)
                {
                    SendClientMessage(playerid, RGBA_RED, "This pickup could not be created!");
                    ShowPlayerPickupDialog(playerid, g_PickupMainDialog);
                    return 1;
                }

                HideMBrowser(playerid);
                ShowPlayerPickupDialog(playerid, g_PickupEditDialog);
                SendClientMessage(playerid, RGBA_GREEN,
                    sprintf("You have created the pickup \"%s\".", GetObjectModelName(modelid))
                );
            }
            case MBROWSER_RESPONSE_LISTITEM:
            {
                new
                    pageitem = listitem + (g_pCreatePickupPage[playerid] * MAX_MBROWSER_PAGESIZE),
                    is_searching = strlen(g_pCreatePickupSearch[playerid]) > 0,
                    model_index = (is_searching) ? (g_pCreatePickupResult[playerid][listitem]) : (pageitem),
                    modelid = g_ObjectModels[model_index][e_ObjectModelID]
                ;

                g_pCreatePickupChoice[playerid] = model_index;
                SetMBrowserModel(playerid, modelid);
            }
        }
        return 1;
    }

    #if defined pick_OnMBrowserResponse
        return pick_OnMBrowserResponse(playerid, browserid, response, page, listitem, search);
    #else
        return 0;
    #endif
}
#if defined _ALS_OnMBrowserResponse
    #undef OnMBrowserResponse
#else
    #define _ALS_OnMBrowserResponse
#endif
#define OnMBrowserResponse pick_OnMBrowserResponse
#if defined pick_OnMBrowserResponse
    forward pick_OnMBrowserResponse(playerid, browserid, response, page, listitem, search[]);
#endif

/******************************************************************************/

public OnMBrowserShown(playerid, browserid)
{
    if(browserid == g_PickupSelectBrowser)
    {
        SetMBrowserPage(playerid, g_pSelectPickupPage[playerid]);

        if(strlen(g_pSelectPickupSearch[playerid]) > 0)
        {
            SetMBrowserSearch(playerid, g_pSelectPickupSearch[playerid]);

            for(new listitem; listitem < MAX_MBROWSER_PAGESIZE; listitem ++)
            {
                g_pSelectPickupResult[playerid][listitem] = INVALID_PICKUP_ID;
                HideMBrowserListItem(playerid, listitem);
            }

            new
                min_pageitem = g_pSelectPickupPage[playerid] * MAX_MBROWSER_PAGESIZE,
                max_pageitem = min_pageitem + 20,
                search_value = strval(g_pSelectPickupSearch[playerid])
            ;

            for(new pickupid, matches; pickupid < MAX_PICKUPS; pickupid ++)
            {
                if(!IsValidPickup(pickupid))
                    continue;

                new modelid = GetPickupModel(pickupid);

                if(
                    (search_value != 0 && search_value == modelid) ||
                    strfind(GetObjectModelName(modelid), g_pSelectPickupSearch[playerid], true) != -1
                ){
                    if(matches >= min_pageitem && matches < max_pageitem)
                    {
                        new listitem = matches - min_pageitem;

                        g_pSelectPickupResult[playerid][listitem] = pickupid;
                        SetMBrowserListItem(playerid, listitem, GetObjectModelName(modelid));
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
                new pickupid = listitem + (g_pSelectPickupPage[playerid] * MAX_MBROWSER_PAGESIZE);
                if(IsValidPickup(pickupid))
                {
                    new modelid = GetPickupModel(pickupid);
                    SetMBrowserListItem(playerid, listitem, GetObjectModelName(modelid));
                }
                else
                    HideMBrowserListItem(playerid, listitem);
            }
        }

        new pickupid = g_pSelectPickupChoice[playerid];
        if(pickupid == INVALID_PICKUP_ID)
            HideMBrowserModel(playerid);
        else
        {
            new modelid = GetPickupModel(pickupid);
            SetMBrowserModel(playerid, modelid);
        }
        return 1;
    }
    else if(browserid == g_PickupCreateBrowser)
    {
        SetMBrowserPage(playerid, g_pCreatePickupPage[playerid]);

        if( strlen(g_pCreatePickupSearch[playerid]) > 0 )
        {
            SetMBrowserSearch(playerid, g_pCreatePickupSearch[playerid]);

            for(new listitem; listitem < MAX_MBROWSER_PAGESIZE; listitem ++)
            {
                g_pCreatePickupResult[playerid][listitem] = -1;
                HideMBrowserListItem(playerid, listitem);
            }

            new
                min_pageitem = g_pCreatePickupPage[playerid] * MAX_MBROWSER_PAGESIZE,
                max_pageitem = min_pageitem + 20,
                search_value = strval(g_pCreatePickupSearch[playerid]),
                packed_search[MAX_OBJECT_MODEL_NAME]
            ;

            strpack(packed_search, g_pCreatePickupSearch[playerid]);

            for(new model_index, matches; model_index < g_MaxObjectModels; model_index ++)
            {
                   if(
                    (search_value != 0 && search_value == g_ObjectModels[model_index][e_ObjectModelID]) ||
                    strfind(g_ObjectModels[model_index][e_ObjectModelName], packed_search, true) != -1
                ){
                    if(matches >= min_pageitem && matches < max_pageitem)
                    {
                        new listitem = matches - min_pageitem;

                        g_pCreatePickupResult[playerid][listitem] = model_index;
                        SetMBrowserListItem(playerid, listitem,
                            ret_strunpack(g_ObjectModels[model_index][e_ObjectModelName])
                        );
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
                new model_index = listitem + (g_pCreatePickupPage[playerid] * MAX_MBROWSER_PAGESIZE);
                if(model_index < g_MaxObjectModels)
                {
                    SetMBrowserListItem(playerid, listitem,
                        ret_strunpack(g_ObjectModels[model_index][e_ObjectModelName])
                    );
                }
                else
                    HideMBrowserListItem(playerid, listitem);
            }
        }

        new model_index = g_pCreatePickupChoice[playerid];
        if(model_index == -1)
            HideMBrowserModel(playerid);
        else
        {
            new modelid = g_ObjectModels[model_index][e_ObjectModelID];
            SetMBrowserModel(playerid, modelid);
        }
        return 1;
    }

    #if defined pick_OnMBrowserShown
        return pick_OnMBrowserShown(playerid, browserid);
    #else
        return 0;
    #endif
}
#if defined _ALS_OnMBrowserShown
    #undef OnMBrowserShown
#else
    #define _ALS_OnMBrowserShown
#endif
#define OnMBrowserShown pick_OnMBrowserShown
#if defined pick_OnMBrowserShown
    forward pick_OnMBrowserShown(playerid, browserid);
#endif

/******************************************************************************/

public OnToolbarResponse(playerid, response)
{
    if(response == TOOLBAR_PICKUP)
        return ShowPlayerPickupDialog(playerid, g_PickupMainDialog), 1;

    #if defined pick_OnToolbarResponse
        return pick_OnToolbarResponse(playerid, response);
    #else
        return 0;
    #endif
}
#if defined _ALS_OnToolbarResponse
    #undef OnToolbarResponse
#else
    #define _ALS_OnToolbarResponse
#endif
#define OnToolbarResponse pick_OnToolbarResponse
#if defined pick_OnToolbarResponse
    forward pick_OnToolbarResponse(playerid, response);
#endif

/******************************************************************************/
