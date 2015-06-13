/******************************************************************************/

public OnFilterScriptInit()
{
    CreateDialog(g_AttachIndexDialog);
    CreateDialog(g_AttachEditDialog);
    CreateDialog(g_AttachBoneDialog);
    CreateDialog(g_AttachXDialog);
    CreateDialog(g_AttachYDialog);
    CreateDialog(g_AttachZDialog);
    CreateDialog(g_AttachRXDialog);
    CreateDialog(g_AttachRYDialog);
    CreateDialog(g_AttachRZDialog);
    CreateDialog(g_AttachSXDialog);
    CreateDialog(g_AttachSYDialog);
    CreateDialog(g_AttachSZDialog);

    CreateMBrowser(g_AttachModelBrowser, "Attached Model", "Set");

    for(new i; i < 2; i ++)
        CreateCBrowser(g_AttachColorBrowser[i], sprintf("Attached Color %i", i + 1) );

    #if defined a_OnFilterScriptInit
        a_OnFilterScriptInit();
    #endif
}
#if defined _ALS_OnFilterScriptInit
    #undef OnFilterScriptInit
#else
    #define _ALS_OnFilterScriptInit
#endif
#define OnFilterScriptInit a_OnFilterScriptInit
#if defined a_OnFilterScriptInit
    forward a_OnFilterScriptInit();
#endif

/******************************************************************************/

public OnPlayerDisconnect(playerid, reason)
{
    for(new index; index < MAX_ATTACHED_INDEX; index ++)
        RemovePlayerAttachedObject(playerid, index);

    g_pEditAttachIndex            {playerid} = 0;

    g_pAttachModelChoice        [playerid] = -1;

    g_pAttachModelPage            [playerid] = 0;

    g_pAttachModelSearch        [playerid] = "";

    for(new listitem; listitem < MAX_MBROWSER_PAGESIZE; listitem ++)
        g_pAttachModelResult    [playerid][listitem] = -1;

    for(new i; i < 2; i ++)
        g_pAttachColorPage        [playerid][i] = 0;

    #if defined a_OnPlayerDisconnect
        a_OnPlayerDisconnect(playerid, reason);
    #endif
}
#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect a_OnPlayerDisconnect
#if defined a_OnPlayerDisconnect
    forward a_OnPlayerDisconnect(playerid, reason);
#endif

/******************************************************************************/

public OnPlayerSpawn(playerid)
{
    for(new index; index < MAX_ATTACHED_INDEX; index ++)
    {
        if(!IsPlayerAttachedObjectSlotUsed(playerid, index))
            continue;

        new    modelid = GetPlayerAttachedObjectModel(playerid, index),
            boneid = GetPlayerAttachedObjectBone(playerid, index),
            Float: o    [3],
            Float: r    [3],
            Float: s    [3],
            c            [2];

        GetPlayerAttachedObjectOffset    (playerid, index, o[0], o[1], o[2]);
        GetPlayerAttachedObjectRot        (playerid, index, r[0], r[1], r[2]);
        GetPlayerAttachedObjectScale    (playerid, index, s[0], s[1], s[2]);
        GetPlayerAttachedObjectColor    (playerid, index, c[0], c[1]);

        SetPlayerAttachedObject(
            playerid,
            index,
            modelid,
            boneid,
            o[0],
            o[1],
            o[2],
            r[0],
            r[1],
            r[2],
            s[0],
            s[1],
            s[2],
            c[0],
            c[1]
        );
    }

    #if defined a_OnPlayerSpawn
        return a_OnPlayerSpawn(playerid, reason);
    #else
        return 1;
    #endif
}
#if defined _ALS_OnPlayerSpawn
    #undef OnPlayerSpawn
#else
    #define _ALS_OnPlayerSpawn
#endif
#define OnPlayerSpawn a_OnPlayerSpawn
#if defined a_OnPlayerSpawn
    forward a_OnPlayerSpawn(playerid, reason);
#endif

/******************************************************************************/

public OnPlayerEditAttachedObject(playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
    new    soundid = (response) ? (1083) : (1084);
    PlayerPlaySound(playerid, soundid, 0.0, 0.0, 0.0);

    if(response)
    {
        SendClientMessage(playerid, RGBA_GREEN,
            sprintf("You have successfully moved your attachment \"%s\".", GetObjectModelName(modelid))
        );
    }
    else
    {
        GetPlayerAttachedObjectOffset    ( playerid, index, fOffsetX, fOffsetY, fOffsetZ );
        GetPlayerAttachedObjectRot        ( playerid, index, fRotX, fRotY, fRotZ );
        GetPlayerAttachedObjectScale    ( playerid, index, fScaleX, fScaleY, fScaleZ );

        SendClientMessage(playerid, RGBA_RED,
            sprintf("You have cancelled moving your attachment \"%s\".", GetObjectModelName(modelid))
        );
    }

    new    attach_argb[2];
    GetPlayerAttachedObjectColor(playerid, index, attach_argb[0], attach_argb[1]);

    SetPlayerAttachedObject(
        playerid,
        index,
        modelid,
        boneid,
        fOffsetX,
        fOffsetY,
        fOffsetZ,
        fRotX,
        fRotY,
        fRotZ,
        fScaleX,
        fScaleY,
        fScaleZ,
        attach_argb[0],
        attach_argb[1]
    );

    SelectTextDraw(playerid, 0xFF0000FF);
    ShowPlayerAttachDialog(playerid, g_AttachEditDialog);

    #if defined a_OnPlayerEditAttachedObject
        a_OnPlayerEditAttachedObject(playerid, response, index, modelid, boneid, fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ, fScaleX, fScaleY, fScaleZ);
    #endif
}
#if defined _ALS_OnPlayerEditAttachedObject
    #undef OnPlayerEditAttachedObject
#else
    #define _ALS_OnPlayerEditAttachedObject
#endif
#define OnPlayerEditAttachedObject a_OnPlayerEditAttachedObject
#if defined a_OnPlayerEditAttachedObject
    forward a_OnPlayerEditAttachedObject(playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ);
#endif

/******************************************************************************/

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == g_AttachIndexDialog)
    {
        if(!response)
            return 1;

        g_pEditAttachIndex{playerid} = listitem;
        if(IsPlayerAttachedObjectSlotUsed(playerid, listitem))
            ShowPlayerAttachDialog(playerid, g_AttachEditDialog);
        else
            ShowMBrowser(playerid, g_AttachModelBrowser);
        return 1;
    }
    else if(dialogid == g_AttachEditDialog)
    {
        if(!response)
        {
            ShowPlayerAttachDialog(playerid, g_AttachIndexDialog);
            return 1;
        }

        switch(listitem)
        {
            case 0: // Remove
            {
                RemovePlayerAttachedObject(playerid, g_pEditAttachIndex{playerid});
                ShowPlayerAttachDialog(playerid, g_AttachIndexDialog);
            }
            case 1: // Move
            {
                CancelSelectTextDraw(playerid);
                EditAttachedObject(playerid, g_pEditAttachIndex{playerid});
            }
            case 2: // Set Model
                ShowMBrowser(playerid, g_AttachModelBrowser);
            case 3: // Set Bone
                ShowPlayerAttachDialog(playerid, g_AttachBoneDialog);
            case 4: // X Offset
                ShowPlayerAttachDialog(playerid, g_AttachXDialog);
            case 5: // Y Offset
                ShowPlayerAttachDialog(playerid, g_AttachYDialog);
            case 6: // Z Offset
                ShowPlayerAttachDialog(playerid, g_AttachZDialog);
            case 7: // X Rotation
                ShowPlayerAttachDialog(playerid, g_AttachRXDialog);
            case 8: // Y Rotation
                ShowPlayerAttachDialog(playerid, g_AttachRYDialog);
            case 9: // Z Rotation
                ShowPlayerAttachDialog(playerid, g_AttachRZDialog);
            case 10: // X Scale
                ShowPlayerAttachDialog(playerid, g_AttachSXDialog);
            case 11: // Y Scale
                ShowPlayerAttachDialog(playerid, g_AttachSYDialog);
            case 12: // Z Scale
                ShowPlayerAttachDialog(playerid, g_AttachSZDialog);
            case 13: // Color 1
                ShowCBrowser(playerid, g_AttachColorBrowser[0], g_pAttachColorPage[playerid][0]);
            case 14: // Color 2
                ShowCBrowser(playerid, g_AttachColorBrowser[1], g_pAttachColorPage[playerid][1]);
        }
        return 1;
    }
    else if(dialogid == g_AttachBoneDialog)
    {
        if(!response)
        {
            ShowPlayerAttachDialog(playerid, g_AttachEditDialog);
            return 1;
        }

        new    index = g_pEditAttachIndex{playerid},
            modelid = GetPlayerAttachedObjectModel(playerid, index),
            boneid = listitem + 1,
            Float: o    [3],
            Float: r    [3],
            Float: s    [3],
            attach_argb    [2];

        GetPlayerAttachedObjectOffset    ( playerid, index, o[0], o[1], o[2] );
        GetPlayerAttachedObjectRot        ( playerid, index, r[0], r[1], r[2] );
        GetPlayerAttachedObjectScale    ( playerid, index, s[0], s[1], s[2] );
        GetPlayerAttachedObjectColor    ( playerid, index, attach_argb[0], attach_argb[1] );

        SetPlayerAttachedObject(
            playerid,
            index,
            modelid,
            boneid,
            o[0],
            o[1],
            o[2],
            r[0],
            r[1],
            r[2],
            s[0],
            s[1],
            s[2],
            attach_argb[0],
            attach_argb[1]
        );

        SendClientMessage(playerid, RGBA_GREEN,
            sprintf("You have set your attachment \"%s\" to the bone \"%s\".",
                GetObjectModelName(modelid), GetBoneName(boneid)
            )
        );

        ShowPlayerAttachDialog(playerid, g_AttachEditDialog);

        return 1;
    }
    else if(
        dialogid == g_AttachXDialog ||
        dialogid == g_AttachYDialog ||
        dialogid == g_AttachZDialog ||
        dialogid == g_AttachRXDialog ||
        dialogid == g_AttachRYDialog ||
        dialogid == g_AttachRZDialog ||
        dialogid == g_AttachSXDialog ||
        dialogid == g_AttachSYDialog ||
        dialogid == g_AttachSZDialog
    ){

        if(!response)
        {
            ShowPlayerAttachDialog(playerid, g_AttachEditDialog);
            return 1;
        }

        new    index = g_pEditAttachIndex{playerid},
            modelid = GetPlayerAttachedObjectModel(playerid, index),
            boneid = GetPlayerAttachedObjectBone(playerid, index),
            Float: input_float = floatstr(inputtext),
            Float: o    [3],
            Float: r    [3],
            Float: s    [3],
            attach_argb    [2],
            action_str    [11];

        GetPlayerAttachedObjectOffset    ( playerid, index, o[0], o[1], o[2] );
        GetPlayerAttachedObjectRot        ( playerid, index, r[0], r[1], r[2] );
        GetPlayerAttachedObjectScale    ( playerid, index, s[0], s[1], s[2] );
        GetPlayerAttachedObjectColor    ( playerid, index, attach_argb[0], attach_argb[1] );

        if(dialogid == g_AttachXDialog)
        {
            o[0] = input_float;
            action_str = "x offset";
        }
        else if(dialogid == g_AttachYDialog)
        {
            o[1] = input_float;
            action_str = "y offset";
        }
        else if(dialogid == g_AttachZDialog)
        {
            o[2] = input_float;
            action_str = "z offset";
        }
        else if(dialogid == g_AttachRXDialog)
        {
            r[0] = input_float;
            action_str = "x rotation";
        }
        else if(dialogid == g_AttachRYDialog)
        {
            r[1] = input_float;
            action_str = "y rotation";
        }
        else if(dialogid == g_AttachRZDialog)
        {
            r[2] = input_float;
            action_str = "z rotation";
        }
        else if(dialogid == g_AttachSXDialog)
        {
            s[0] = input_float;
            action_str = "x scale";
        }
        else if(dialogid == g_AttachSYDialog)
        {
            s[1] = input_float;
            action_str = "y scale";
        }
        else if(dialogid == g_AttachSZDialog)
        {
            s[2] = input_float;
            action_str = "z scale";
        }

        if(isempty(inputtext))
        {
            SendClientMessage(playerid, RGBA_RED,
                sprintf("The %s of your attachment \"%s\" could not be set!",
                    action_str, GetObjectModelName(modelid)
                )
            );

            ShowPlayerAttachDialog(playerid, dialogid);

            return 1;
        }

        SetPlayerAttachedObject(
            playerid,
            index,
            modelid,
            boneid,
            o[0],
            o[1],
            o[2],
            r[0],
            r[1],
            r[2],
            s[0],
            s[1],
            s[2],
            attach_argb[0],
            attach_argb[1]
        );

        SendClientMessage(playerid, RGBA_GREEN,
            sprintf("You have set the %s of your attachment \"%s\" to \"%.4f\".",
                action_str,    GetObjectModelName(modelid), input_float
            )
        );

        ShowPlayerAttachDialog(playerid, g_AttachEditDialog);

        return 1;
    }

    #if defined a_OnDialogResponse
        return a_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
    #endif
}
#if defined _ALS_OnDialogResponse
    #undef OnDialogResponse
#else
    #define _ALS_OnDialogResponse
#endif
#define OnDialogResponse a_OnDialogResponse
#if defined a_OnDialogResponse
    forward a_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);
#endif

/******************************************************************************/

public OnMBrowserResponse(playerid, browserid, response, page, listitem, search[])
{
    if(browserid == g_AttachModelBrowser)
    {
        switch(response)
        {
            case MBROWSER_RESPONSE_CLOSE:
            {
                HideMBrowser(playerid);

                new    index = g_pEditAttachIndex{playerid},
                    is_attached = IsPlayerAttachedObjectSlotUsed(playerid, index),
                    dialogid = (is_attached) ? (g_AttachEditDialog) : (g_AttachIndexDialog);

                ShowPlayerAttachDialog(playerid, dialogid);
            }
            case MBROWSER_RESPONSE_SEARCH:
            {
                g_pAttachModelPage[playerid] = 0;
                format(g_pAttachModelSearch[playerid], MAX_MBROWSER_SEARCH, search);
                ShowMBrowser(playerid, browserid);
            }
            case MBROWSER_RESPONSE_PAGE_BACK:
            {
                if(g_pAttachModelPage[playerid] > 0)
                {
                    g_pAttachModelPage[playerid] --;
                    ShowMBrowser(playerid, browserid);
                }
            }
            case MBROWSER_RESPONSE_PAGE_NEXT:
            {
                new    min_pageitem = (g_pAttachModelPage[playerid] + 1) * MAX_MBROWSER_PAGESIZE;
                if(min_pageitem < g_MaxObjectModels)
                {
                    g_pAttachModelPage[playerid] ++;
                    ShowMBrowser(playerid, browserid);
                }
            }
            case MBROWSER_RESPONSE_PAGE_SET:
            {
                new    min_pageitem = page * MAX_MBROWSER_PAGESIZE;
                if(min_pageitem < g_MaxObjectModels)
                {
                    g_pAttachModelPage[playerid] = page;
                    ShowMBrowser(playerid, browserid);
                }
            }
            case MBROWSER_RESPONSE_BUTTON:
            {
                new    model_index = g_pAttachModelChoice[playerid],
                    modelid = g_ObjectModels[model_index][e_ObjectModelID],
                    index = g_pEditAttachIndex{playerid},
                    boneid = 1,
                    Float: o    [3] = {0.0, ...},
                    Float: r    [3] = {0.0, ...},
                    Float: s    [3] = {1.0, ...},
                    attach_argb    [2] = {0xFFFFFFFF, ...};

                if(IsPlayerAttachedObjectSlotUsed(playerid, index))
                {
                    new    old_modelid = GetPlayerAttachedObjectModel(playerid, index);

                    boneid = GetPlayerAttachedObjectBone    ( playerid, index );
                    GetPlayerAttachedObjectOffset            ( playerid, index, o[0], o[1], o[2] );
                    GetPlayerAttachedObjectRot                ( playerid, index, r[0], r[1], r[2] );
                    GetPlayerAttachedObjectScale            ( playerid, index, s[0], s[1], s[2] );
                    GetPlayerAttachedObjectColor            ( playerid, index, attach_argb[0], attach_argb[1] );

                    SendClientMessage(playerid, RGBA_GREEN,
                        sprintf("You have changed the model of your attachment \"%s\" to \"%s\".",
                            GetObjectModelName(old_modelid), GetObjectModelName(modelid)
                        )
                    );
                }
                else
                {
                    SendClientMessage(playerid, RGBA_GREEN,
                        sprintf("You have created the attachment \"%s\".", GetObjectModelName(modelid))
                    );
                }

                SetPlayerAttachedObject(
                    playerid,
                    index,
                    modelid,
                    boneid,
                    o[0],
                    o[1],
                    o[2],
                    r[0],
                    r[1],
                    r[2],
                    s[0],
                    s[1],
                    s[2],
                    attach_argb[0],
                    attach_argb[1]
                );

                HideMBrowser(playerid);
                ShowPlayerAttachDialog(playerid, g_AttachEditDialog);
            }
            case MBROWSER_RESPONSE_LISTITEM:
            {
                new    pageitem = listitem + (g_pAttachModelPage[playerid] * MAX_MBROWSER_PAGESIZE),
                    is_searching = strlen(g_pAttachModelSearch[playerid]) > 0,
                    model_index  = (is_searching) ? (g_pAttachModelResult[playerid][listitem]) : (pageitem),
                    modelid = g_ObjectModels[model_index][e_ObjectModelID];

                g_pAttachModelChoice[playerid] = model_index;
                SetMBrowserModel(playerid, modelid);
            }
        }
        return 1;
    }

    #if defined a_OnMBrowserResponse
        return a_OnMBrowserResponse(playerid, browserid, response, page, listitem, search);
    #else
        return 0;
    #endif
}
#if defined _ALS_OnMBrowserResponse
    #undef OnMBrowserResponse
#else
    #define _ALS_OnMBrowserResponse
#endif
#define OnMBrowserResponse a_OnMBrowserResponse
#if defined a_OnMBrowserResponse
    forward a_OnMBrowserResponse(playerid, browserid, response, page, listitem, search[]);
#endif

/******************************************************************************/

public OnMBrowserShown(playerid, browserid)
{
    if(browserid == g_AttachModelBrowser)
    {
        SetMBrowserPage(playerid, g_pAttachModelPage[playerid]);

        if( strlen(g_pAttachModelSearch[playerid]) > 0 )
        {
            SetMBrowserSearch(playerid, g_pAttachModelSearch[playerid]);

            for(new listitem; listitem < MAX_MBROWSER_PAGESIZE; listitem ++)
            {
                g_pAttachModelResult[playerid][listitem] = -1;
                HideMBrowserListItem(playerid, listitem);
            }

            new    min_pageitem = g_pAttachModelPage[playerid] * MAX_MBROWSER_PAGESIZE,
                max_pageitem = min_pageitem + 20,
                search_value = strval(g_pAttachModelSearch[playerid]),
                packed_search[MAX_MBROWSER_SEARCH];

            strpack(packed_search, g_pAttachModelSearch[playerid]);

            for(new model_index, matches; model_index < g_MaxObjectModels; model_index ++)
            {
                if(
                    (search_value != 0 && search_value == g_ObjectModels[model_index][e_ObjectModelID]) ||
                    strfind(g_ObjectModels[model_index][e_ObjectModelName], packed_search, true) != -1
                ){
                    if(matches >= min_pageitem && matches < max_pageitem)
                    {
                        new listitem = matches - min_pageitem;

                        g_pAttachModelResult[playerid][listitem] = model_index;
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
                new model_index = listitem + (g_pAttachModelPage[playerid] * MAX_MBROWSER_PAGESIZE);
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

        new model_index = g_pAttachModelChoice[playerid];
        if(model_index == -1)
            HideMBrowserModel(playerid);
        else
        {
            new modelid = g_ObjectModels[model_index][e_ObjectModelID];
            SetMBrowserModel(playerid, modelid);
        }
        return 1;
    }

    #if defined a_OnMBrowserShown
        return a_OnMBrowserShown(playerid, browserid);
    #else
        return 0;
    #endif
}
#if defined _ALS_OnMBrowserShown
    #undef OnMBrowserShown
#else
    #define _ALS_OnMBrowserShown
#endif
#define OnMBrowserShown a_OnMBrowserShown
#if defined a_OnMBrowserShown
    forward a_OnMBrowserShown(playerid, browserid);
#endif

/******************************************************************************/

public OnCBrowserResponse(playerid, browserid, response, color)
{
    for(new i; i < 2; i ++)
    {
        if(browserid == g_AttachColorBrowser[i])
        {
            switch(response)
            {
                case CBROWSER_RESPONSE_CLOSE:
                {
                    HideCBrowser(playerid);
                    ShowPlayerAttachDialog(playerid, g_AttachEditDialog);
                }
                case CBROWSER_RESPONSE_PAGE_BACK:
                {
                    if(g_pAttachColorPage[playerid][i] > 0)
                        ShowCBrowser(playerid, g_AttachColorBrowser[i], -- g_pAttachColorPage[playerid][i]);
                }
                case CBROWSER_RESPONSE_PAGE_NEXT:
                {
                    new page = g_pAttachColorPage[playerid][i],
                        min_pageitem = (page + 1) * MAX_CBROWSER_PAGESIZE;

                    if(min_pageitem < g_MaxVehicleColors)
                        ShowCBrowser(playerid, g_AttachColorBrowser[i], ++ g_pAttachColorPage[playerid][i]);
                }
                case CBROWSER_RESPONSE_COLOR:
                {
                    new page = g_pAttachColorPage[playerid][i],
                        pageitem = color + (page * MAX_CBROWSER_PAGESIZE),
                        color_rgba = g_VehicleColors[pageitem],
                        color_argb = RGBAtoARGB(color_rgba),

                        attach_index = g_pEditAttachIndex{playerid},
                        modelid = GetPlayerAttachedObjectModel(playerid, attach_index),
                        boneid = GetPlayerAttachedObjectBone(playerid, attach_index),
                        Float: o    [3],
                        Float: r    [3],
                        Float: s    [3],
                        attach_argb    [2];

                    GetPlayerAttachedObjectOffset    ( playerid, attach_index, o[0], o[1], o[2] );
                    GetPlayerAttachedObjectRot        ( playerid, attach_index, r[0], r[1], r[2] );
                    GetPlayerAttachedObjectScale    ( playerid, attach_index, s[0], s[1], s[2] );
                    GetPlayerAttachedObjectColor    ( playerid, attach_index, attach_argb[0], attach_argb[1] );
                    attach_argb[i] = color_argb;

                    SetPlayerAttachedObject(
                        playerid,
                        attach_index,
                        modelid,
                        boneid,
                        o[0],
                        o[1],
                        o[2],
                        r[0],
                        r[1],
                        r[2],
                        s[0],
                        s[1],
                        s[2],
                        attach_argb[0],
                        attach_argb[1]
                    );
                }
            }
            return 1;
        }
    }

    #if defined a_OnCBrowserResponse
        return a_OnCBrowserResponse(playerid, browserid, response, color);
    #else
        return 0;
    #endif
}
#if defined _ALS_OnCBrowserResponse
    #undef OnCBrowserResponse
#else
    #define _ALS_OnCBrowserResponse
#endif
#define OnCBrowserResponse a_OnCBrowserResponse
#if defined a_OnCBrowserResponse
    forward a_OnCBrowserResponse(playerid, browserid, response, color);
#endif

/******************************************************************************/

public OnCBrowserShown(playerid, browserid, page)
{
    for(new i; i < 2; i ++)
    {
        if(browserid == g_AttachColorBrowser[i])
        {
            for(new listitem; listitem < MAX_CBROWSER_PAGESIZE; listitem ++)
            {
                new pageitem = listitem + (page * MAX_CBROWSER_PAGESIZE);
                if(pageitem < g_MaxVehicleColors)
                {
                    new color_rgba = g_VehicleColors[pageitem];
                    SetCBrowserColor(playerid, listitem, color_rgba);
                }
                else
                    HideCBrowserColor(playerid, listitem);
            }
            return 1;
        }
    }

    #if defined a_OnCBrowserShown
        return a_OnCBrowserShown(playerid, browserid, page);
    #else
        return 0;
    #endif
}
#if defined _ALS_OnCBrowserShown
    #undef OnCBrowserShown
#else
    #define _ALS_OnCBrowserShown
#endif
#define OnCBrowserShown a_OnCBrowserShown
#if defined a_OnCBrowserShown
    forward a_OnCBrowserShown(playerid, browserid, page);
#endif

/******************************************************************************/

public OnToolbarResponse(playerid, response)
{
    if(response == TOOLBAR_ATTACH)
    {
        ShowPlayerAttachDialog(playerid, g_AttachIndexDialog);
        return 1;
    }

    #if defined a_OnToolbarResponse
        return a_OnToolbarResponse(playerid, response);
    #else
        return 0;
    #endif
}
#if defined _ALS_OnToolbarResponse
    #undef OnToolbarResponse
#else
    #define _ALS_OnToolbarResponse
#endif
#define OnToolbarResponse a_OnToolbarResponse
#if defined a_OnToolbarResponse
    forward a_OnToolbarResponse(playerid, response);
#endif

/******************************************************************************/
