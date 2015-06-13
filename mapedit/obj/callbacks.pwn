/******************************************************************************/

public OnFilterScriptInit()
{
    CreateDialog(g_ObjectMainDialog);
    CreateDialog(g_ObjectEditDialog);
    CreateDialog(g_ObjectIndexDialog);

    CreateDialog(g_ObjectTextStringDialog);
    CreateDialog(g_ObjectTextMaterialSizeDialog);
    CreateDialog(g_ObjectTextFontDialog);
    CreateDialog(g_ObjectTextFontSizeDialog);
    CreateDialog(g_ObjectTextAlignmentDialog);
    CreateDialog(g_ObjectXDialog);
    CreateDialog(g_ObjectYDialog);
    CreateDialog(g_ObjectZDialog);
    CreateDialog(g_ObjectRXDialog);
    CreateDialog(g_ObjectRYDialog);
    CreateDialog(g_ObjectRZDialog);

    CreateMBrowser ( g_ObjectSelectBrowser, "Select Object", "Select" );
    CreateMBrowser ( g_ObjectCreateBrowser, "Create Object", "Create" );
    CreateMBrowser ( g_ObjectMaterialBrowser, "Select Texture", "Select" );
    CreateCBrowser ( g_ObjectTextureColorBrowser, "Texture Color" );
    CreateCBrowser ( g_ObjectFontColorBrowser, "Font Color" );
    CreateCBrowser ( g_ObjectBackColorBrowser, "Background Color" );

    #if defined o_OnFilterScriptInit
        o_OnFilterScriptInit();
    #endif
}
#if defined _ALS_OnFilterScriptInit
    #undef OnFilterScriptInit
#else
    #define _ALS_OnFilterScriptInit
#endif
#define OnFilterScriptInit o_OnFilterScriptInit
#if defined o_OnFilterScriptInit
    forward o_OnFilterScriptInit();
#endif

/******************************************************************************/

public OnPlayerDisconnect(playerid, reason)
{
    for(new object; object < MAX_OBJECTS; object ++)
    {
        for(new i; i < 3; i ++)
        {
            g_pObjectSavePos    [playerid][object][i] = 0.0;
            g_pObjectSaveRot    [playerid][object][i] = 0.0;
        }
    }

    g_pEditObject                [playerid] = INVALID_OBJECT_ID;
    g_pEditObjectIndex            {playerid} = 0;

    g_pSelectObjectChoice        [playerid] = INVALID_OBJECT_ID;
    g_pCreateObjectChoice        [playerid] = -1;

    g_pSelectObjectPage            [playerid] = 0;
    g_pCreateObjectPage            [playerid] = 0;
    g_pTextureObjectPage        [playerid] = 0;

    g_pSelectObjectSearch        [playerid] = "";
    g_pCreateObjectSearch        [playerid] = "";
    g_pTextureObjectSearch        [playerid] = "";

    for(new listitem; listitem < MAX_MBROWSER_PAGESIZE; listitem ++)
    {
        g_pSelectObjectResult    [playerid][listitem] = INVALID_OBJECT_ID;
        g_pCreateObjectResult    [playerid][listitem] = -1;
        g_pTextureObjectResult    [playerid][listitem] = -1;
    }

    g_pObjectTextureColorPage   {playerid} = 0;
    g_pObjectFontColorPage        {playerid} = 0;
    g_pObjectBackColorPage        {playerid} = 0;

    #if defined o_OnPlayerDisconnect
        o_OnPlayerDisconnect(playerid, reason);
    #endif
}
#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect o_OnPlayerDisconnect
#if defined o_OnPlayerDisconnect
    forward o_OnPlayerDisconnect(playerid, reason);
#endif

/******************************************************************************/

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == g_ObjectMainDialog)
    {
        if(!response)
            return 1;

        switch(listitem)
           {
            case 0:
                ShowMBrowser(playerid, g_ObjectSelectBrowser);
            case 1:
            {
                CancelSelectTextDraw(playerid);
                SelectObject(playerid);
            }
            case 2:
                ShowMBrowser(playerid, g_ObjectCreateBrowser);
        }
        return 1;
    }
    else if(dialogid == g_ObjectEditDialog)
    {
        if(!response)
        {
            g_pEditObject[playerid] = INVALID_OBJECT_ID;
            ShowPlayerObjectDialog(playerid, g_ObjectMainDialog);
            return 1;
        }

        switch(listitem)
        {
            case 0: // Remove
            {
                new
                    objectid = g_pEditObject[playerid],
                    modelid = GetObjectModel(objectid)
                ;

                DestroyObject(objectid);
                g_pEditObject[playerid] = INVALID_OBJECT_ID;

                ShowPlayerObjectDialog(playerid, g_ObjectMainDialog);
                SendClientMessage(playerid, RGBA_GREEN,
                    sprintf("You have removed the object \"%s\".", GetObjectModelName(modelid))
                );
            }
            case 1: // Duplicate
            {
                new
                    objectid = g_pEditObject[playerid],
                    modelid = GetObjectModel(objectid),
                    new_objectid = DuplicateObject(objectid)
                ;

                if(new_objectid == INVALID_OBJECT_ID)
                    SendClientMessage(playerid, RGBA_RED, "This object could not be duplicated!");
                else
                {
                    g_pEditObject[playerid] = new_objectid;

                    SendClientMessage(playerid, RGBA_GREEN,
                        sprintf("You have duplicated the object \"%s\".", GetObjectModelName(modelid))
                    );
                }
                ShowPlayerObjectDialog(playerid, g_ObjectEditDialog);
            }
            case 2: // Move
            {
                new
                    objectid = g_pEditObject[playerid],
                    modelid = GetObjectModel(objectid),
                    attach_object = GetObjectAttachedToObject(objectid),
                    attach_vehicle = GetObjectAttachedToVehicle(objectid)
                ;

                if(attach_object == INVALID_OBJECT_ID && attach_vehicle == INVALID_VEHICLE_ID)
                {
                    new
                        Float:x,
                        Float:y,
                        Float:z,
                        Float:rx,
                        Float:ry,
                        Float:rz
                    ;

                    GetObjectPos(objectid, x, y, z);
                    GetObjectRot(objectid, rx, ry, rz);
                    SaveObjectPos(objectid, x, y, z);
                    SaveObjectRot(objectid, rx, ry, rz);

                    EditObject(playerid, objectid);
                }
                else
                {
                    CancelSelectTextDraw(playerid);
                    TogglePlayerOffsetEditor(playerid, true);
                }

                SendClientMessage(playerid, RGBA_GREEN,
                    sprintf("You are now moving the object \"%s\".", GetObjectModelName(modelid))
                );
            }
            case 3: // Select Object For Attachment
            {
                g_pSelectedAttachObject[playerid] = g_pEditObject[playerid];

                new
                    objectid = g_pEditObject[playerid],
                    modelid = GetObjectModel(objectid)
                ;

                ShowPlayerObjectDialog(playerid, g_ObjectEditDialog);
                SendClientMessage(playerid, RGBA_GREEN,
                    sprintf("You have selected the object \"%s\" for attachment.", GetObjectModelName(modelid))
                );
            }
            case 4: // Attach Selected Object to Object
            {
                new
                    objectid = g_pSelectedAttachObject[playerid],
                    attachtoid = g_pEditObject[playerid]
                ;

                if(objectid == INVALID_OBJECT_ID)
                    SendClientMessage(playerid, RGBA_RED, "You have not selected any object to attach!");
                else
                {
                    if(objectid == attachtoid)
                        SendClientMessage(playerid, RGBA_RED, "This object could not be attached!");
                    else
                    {
                        new
                            object_modelid = GetObjectModel(objectid),
                            attach_modelid = GetObjectModel(attachtoid),
                            Float:x,
                            Float:y,
                            Float:z,
                            Float:rx,
                            Float:ry,
                            Float:rz
                        ;

                        GetObjectAttachOffset(objectid, x, y, z, rx, ry, rz);
                        AttachObjectToObject(objectid, attachtoid, x, y, z, rx, ry, rz);

                        g_pEditObject[playerid] = objectid;
                        g_pSelectedAttachObject[playerid] = INVALID_OBJECT_ID;

                        SendClientMessage(playerid, RGBA_GREEN,
                            sprintf("You have attached the object \"%s\" to the object \"%s\".",
                                GetObjectModelName(object_modelid),
                                GetObjectModelName(attach_modelid)
                            )
                        );
                    }
                }
                ShowPlayerObjectDialog(playerid, g_ObjectEditDialog);
            }
            case 5: // Unattach
            {
                new
                    objectid = g_pEditObject[playerid],
                    object_modelid = GetObjectModel(objectid),
                    attach_objectid = GetObjectAttachedToObject(objectid),
                    attach_vehicleid = GetObjectAttachedToVehicle(objectid)
                ;

                if(attach_objectid != INVALID_OBJECT_ID)
                {
                    UnAttachObject(objectid);

                    new new_objectid = DuplicateObject(objectid);
                    if(new_objectid == INVALID_OBJECT_ID)
                        SendClientMessage(playerid, RGBA_RED, "This object could not be unattached!");
                    else
                    {
                        g_pEditObject[playerid] = new_objectid;
                        DestroyObject(objectid);

                        new attach_modelid = GetObjectModel(attach_objectid);

                        SendClientMessage(playerid, RGBA_GREEN,
                            sprintf("You have unattached the object \"%s\" from the object \"%s\".",
                                GetObjectModelName(object_modelid),
                                GetObjectModelName(attach_modelid)
                            )
                        );
                    }
                }
                if(attach_vehicleid != INVALID_VEHICLE_ID)
                {
                    UnAttachObject(objectid);

                    new new_objectid = DuplicateObject(objectid);
                    if(new_objectid == INVALID_OBJECT_ID)
                        SendClientMessage(playerid, RGBA_RED, "This object could not be unattached!");
                    else
                    {
                        g_pEditObject[playerid] = new_objectid;
                        DestroyObject(objectid);

                        new attach_modelid = GetVehicleModel(attach_vehicleid);

                        SendClientMessage(playerid, RGBA_GREEN,
                            sprintf("You have unattached the object \"%s\" from the vehicle \"%s\".",
                                GetObjectModelName(object_modelid),
                                GetVehicleModelName(attach_modelid)
                            )
                        );
                    }
                }
                else
                    SendClientMessage(playerid, RGBA_RED, "This object could not be unattached from anything!");
                ShowPlayerObjectDialog(playerid, g_ObjectEditDialog);
            }
            case 6: // X Pos / Offset
                ShowPlayerObjectDialog(playerid, g_ObjectXDialog);
            case 7: // Y Pos / Offset
                ShowPlayerObjectDialog(playerid, g_ObjectYDialog);
            case 8: // Z Pos / Offset
                ShowPlayerObjectDialog(playerid, g_ObjectZDialog);
            case 9: // X Rot / Offset Rot
                ShowPlayerObjectDialog(playerid, g_ObjectRXDialog);
            case 10: // Y Rot / Offset Rot
                ShowPlayerObjectDialog(playerid, g_ObjectRYDialog);
            case 11: // Z Rot / Offset Rot
                ShowPlayerObjectDialog(playerid, g_ObjectRZDialog);
            case 12..28: // Set Texture / Text
            {
                g_pEditObjectIndex{playerid} = (listitem - 12);
                ShowPlayerObjectDialog(playerid, g_ObjectIndexDialog);
            }
        }
        return 1;
    }
    else if(dialogid == g_ObjectIndexDialog)
    {
        if(!response)
        {
            ShowPlayerObjectDialog(playerid, g_ObjectEditDialog);
            return 1;
        }

        switch(listitem)
        {
            case 0: // Set Texture
                ShowMBrowser ( playerid, g_ObjectMaterialBrowser );
            case 1: // Set Texture Color
                ShowCBrowser ( playerid, g_ObjectTextureColorBrowser, g_pObjectTextureColorPage{playerid} );
            case 2: // Set Text String
                ShowPlayerObjectDialog(playerid, g_ObjectTextStringDialog);
            case 3: // Set Text Material Size
                ShowPlayerObjectDialog(playerid, g_ObjectTextMaterialSizeDialog);
            case 4: // Set Text Font
                ShowPlayerObjectDialog(playerid, g_ObjectTextFontDialog);
            case 5: // Set Text Font Size
                ShowPlayerObjectDialog(playerid, g_ObjectTextFontSizeDialog);
            case 6: // Set Text Bold
            {
                new objectid = g_pEditObject[playerid],
                    modelid = GetObjectModel(objectid),
                    materialindex = g_pEditObjectIndex{playerid},
                    bool: toggle = (IsObjectTextBold(objectid, materialindex)) ? (false) : (true),
                    toggle_string[10];

                toggle_string = (toggle == true) ? ("toggled") : ("untoggled");

                RemoveObjectMaterial(objectid, materialindex);

                new new_objectid = DuplicateObject(objectid);
                if(new_objectid == INVALID_OBJECT_ID)
                    SendClientMessage(playerid, RGBA_RED, "The text boldness of this object could not be set.");
                else
                {
                    g_pEditObject[playerid] = new_objectid;
                    DestroyObject(objectid);

                    SetObjectMaterialText(
                        new_objectid,
                        GetObjectMaterialText(new_objectid, materialindex),
                        materialindex,
                        GetObjectTextMaterialSize(new_objectid, materialindex),
                        GetObjectTextFont(new_objectid, materialindex),
                        GetObjectTextFontSize(new_objectid, materialindex),
                        toggle,
                        GetObjectTextColor(new_objectid, materialindex),
                        GetObjectTextBackColor(new_objectid, materialindex),
                        GetObjectTextAlignment(new_objectid, materialindex)
                    );

                    SendClientMessage(playerid, RGBA_GREEN,
                        sprintf("You have %s the text boldness %i of the object \"%s\".",
                            toggle_string, materialindex, GetObjectModelName(modelid)
                        )
                    );
                }
                ShowPlayerObjectDialog(playerid, dialogid);
            }
            case 7: // Set Text Alignment
                ShowPlayerObjectDialog(playerid, g_ObjectTextAlignmentDialog);
            case 8: // Set Text Font Color
                ShowCBrowser ( playerid, g_ObjectFontColorBrowser, g_pObjectFontColorPage{playerid} );
            case 9: // Set Text Background Color
                ShowCBrowser ( playerid, g_ObjectBackColorBrowser, g_pObjectBackColorPage{playerid} );
            case 10: // Reset Texture
            {
                new
                    objectid = g_pEditObject[playerid],
                    materialindex = g_pEditObjectIndex{playerid},
                    modelid = GetObjectModel(objectid)
                ;

                if(!IsObjectTextured(objectid, materialindex))
                    SendClientMessage(playerid, RGBA_RED, "This object texture could not be reset!");
                else
                {
                    RemoveObjectMaterial(objectid, materialindex);

                    new new_objectid = DuplicateObject(objectid);
                    if(new_objectid == INVALID_OBJECT_ID)
                        SendClientMessage(playerid, RGBA_RED, "This object texture could not be reset!");
                    else
                    {
                        g_pEditObject[playerid] = new_objectid;
                        DestroyObject(objectid);

                        SendClientMessage(playerid, RGBA_GREEN,
                            sprintf("You have reset the texture %i of the object \"%s\".", materialindex, GetObjectModelName(modelid))
                        );
            }
                }
                ShowPlayerObjectDialog(playerid, dialogid);
            }
            case 11: // Remove Text
            {
                new
                    objectid = g_pEditObject[playerid],
                    modelid = GetObjectModel(objectid),
                    materialindex = g_pEditObjectIndex{playerid}
                ;

                if(!IsObjectText(objectid, materialindex))
                    SendClientMessage(playerid, RGBA_RED, "This object text could not be removed!");
                else
                {
                    RemoveObjectMaterialText(objectid, materialindex);

                    new new_objectid = DuplicateObject(objectid);
                    if(new_objectid == INVALID_OBJECT_ID)
                        SendClientMessage(playerid, RGBA_RED, "This object text could not be removed!");
                    else
                    {
                        g_pEditObject[playerid] = new_objectid;
                        DestroyObject(objectid);

                        SendClientMessage(playerid, RGBA_GREEN,
                            sprintf("You have removed the text %i from the object \"%s\".", materialindex, GetObjectModelName(modelid))
                        );
                    }
                }
                ShowPlayerObjectDialog(playerid, dialogid);
            }
            case 12: // Reset Texture Color
            {
                new objectid = g_pEditObject[playerid],
                    modelid = GetObjectModel(objectid),
                    materialindex = g_pEditObjectIndex{playerid};

                if(!IsObjectTextured(objectid, materialindex))
                    SendClientMessage(playerid, RGBA_RED, "This object texture color could not be reset!");
                else
                {
                    new    new_objectid = DuplicateObject(objectid);
                    if(new_objectid == INVALID_OBJECT_ID)
                        SendClientMessage(playerid, RGBA_RED, "This object texture color could not be reset!");
                    else
                    {
                        g_pEditObject[playerid] = new_objectid;
                        DestroyObject(objectid);

                        new textureid = GetObjectTextureID(new_objectid, materialindex);

                        SetObjectMaterial(
                            new_objectid,
                            materialindex,
                            GetTextureModel    (textureid),
                            GetTextureTXD    (textureid),
                            GetTextureName    (textureid)
                        );

                        SendClientMessage(playerid, RGBA_GREEN,
                            sprintf("You have reset the texture color %i of the object \"%s\".",
                                materialindex, GetObjectModelName(modelid)
                            )
                        );
                    }
                }
                ShowPlayerObjectDialog(playerid, dialogid);
            }
            case 13: // Remove Text Background
            {
                new objectid = g_pEditObject[playerid],
                    modelid = GetObjectModel(objectid),
                    materialindex = g_pEditObjectIndex{playerid};

                if(!IsObjectText(objectid, materialindex))
                    SendClientMessage(playerid, RGBA_RED, "This object text background could not be removed!");
                else
                {
                    new new_objectid = DuplicateObject(objectid);
                    if(new_objectid == INVALID_OBJECT_ID)
                        SendClientMessage(playerid, RGBA_RED, "This object text background could not be removed!");
                    else
                    {
                        g_pEditObject[playerid] = new_objectid;
                        DestroyObject(objectid);

                        SetObjectMaterialText(
                            new_objectid,
                            GetObjectMaterialText        (new_objectid, materialindex),
                            materialindex,
                            GetObjectTextMaterialSize    (new_objectid, materialindex),
                            GetObjectTextFont            (new_objectid, materialindex),
                            GetObjectTextFontSize        (new_objectid, materialindex),
                            IsObjectTextBold            (new_objectid, materialindex),
                            GetObjectTextColor            (new_objectid, materialindex),
                            0,
                            GetObjectTextAlignment(new_objectid, materialindex)
                        );

                        SendClientMessage(playerid, RGBA_GREEN,
                            sprintf("You have removed the text background %i from the object \"%s\".", materialindex, GetObjectModelName(modelid))
                        );
                    }
                }
                ShowPlayerObjectDialog(playerid, dialogid);
            }
        }
        return 1;
    }
    else if(dialogid == g_ObjectTextStringDialog)
    {
        if(!response)
        {
            ShowPlayerObjectDialog(playerid, g_ObjectIndexDialog);
            return 1;
        }

        if(isempty(inputtext))
            SendClientMessage(playerid, RGBA_RED, "The text of this object could not be set!");
        else
        {
            if(strfind(inputtext, ",") != -1 || strfind(inputtext, "\\") != -1)
                SendClientMessage(playerid, RGBA_RED, "The text of this object could not be set!");
            else
            {
                new
                    objectid = g_pEditObject[playerid],
                    modelid = GetObjectModel(objectid),
                    materialindex = g_pEditObjectIndex{playerid},
                    new_objectid
                ;

                RemoveObjectMaterial(objectid, materialindex);

                new_objectid = DuplicateObject(objectid);
                if(new_objectid == INVALID_OBJECT_ID)
                    SendClientMessage(playerid, RGBA_RED, "The text of this object could not be set!");
                else
                {
                    g_pEditObject[playerid] = new_objectid;
                    DestroyObject(objectid);

                    SetObjectMaterialText(
                        new_objectid,
                        inputtext,
                        materialindex,
                        GetObjectTextMaterialSize    (new_objectid, materialindex),
                        GetObjectTextFont            (new_objectid, materialindex),
                        GetObjectTextFontSize        (new_objectid, materialindex),
                        IsObjectTextBold            (new_objectid, materialindex),
                        GetObjectTextColor            (new_objectid, materialindex),
                        GetObjectTextBackColor        (new_objectid, materialindex),
                        GetObjectTextAlignment        (new_objectid, materialindex)
                    );

                    SendClientMessage(playerid, RGBA_GREEN,
                        sprintf("You have set the text %i of the object \"%s\" to \"%s\".",
                            materialindex, GetObjectModelName(modelid), inputtext
                        )
                    );
                }
            }
        }

        ShowPlayerObjectDialog(playerid, g_ObjectIndexDialog);
        return 1;
    }
    else if(dialogid == g_ObjectTextMaterialSizeDialog)
    {
        if(!response)
        {
            ShowPlayerObjectDialog(playerid, g_ObjectIndexDialog);
            return 1;
        }

        new
            objectid = g_pEditObject[playerid],
            modelid = GetObjectModel(objectid),
            materialindex = g_pEditObjectIndex{playerid},
            materialsize = (listitem + 1) * 10,
            new_objectid
        ;

        RemoveObjectMaterial(objectid, materialindex);

        new_objectid = DuplicateObject(objectid);
        if(new_objectid == INVALID_OBJECT_ID)
            SendClientMessage(playerid, RGBA_RED, "The materialsize of this object text could not be set!");
        else
        {
            g_pEditObject[playerid] = new_objectid;
            DestroyObject(objectid);

            SetObjectMaterialText(
                new_objectid,
                GetObjectMaterialText    (new_objectid, materialindex),
                materialindex,
                materialsize,
                GetObjectTextFont        (new_objectid, materialindex),
                GetObjectTextFontSize    (new_objectid, materialindex),
                IsObjectTextBold        (new_objectid, materialindex),
                GetObjectTextColor        (new_objectid, materialindex),
                GetObjectTextBackColor    (new_objectid, materialindex),
                GetObjectTextAlignment    (new_objectid, materialindex)
            );

            SendClientMessage(playerid, RGBA_GREEN,
                sprintf("You have set the materialsize %i of the object \"%s\" to \"%s\".",
                    materialindex, GetObjectModelName(modelid), g_TextSizes[listitem]
                )
            );
        }

        ShowPlayerObjectDialog(playerid, g_ObjectIndexDialog);
        return 1;
    }
    else if(dialogid == g_ObjectTextFontDialog)
    {
        if(!response)
        {
            ShowPlayerObjectDialog(playerid, g_ObjectIndexDialog);
            return 1;
        }

        new
            objectid = g_pEditObject[playerid],
            modelid = GetObjectModel(objectid),
            materialindex = g_pEditObjectIndex{playerid},
            new_objectid
        ;

        RemoveObjectMaterial(objectid, materialindex);

        new_objectid = DuplicateObject(objectid);
        if(new_objectid == INVALID_OBJECT_ID)
            SendClientMessage(playerid, RGBA_RED, "The font of this object text could not be set!");
        else
        {
            g_pEditObject[playerid] = new_objectid;
            DestroyObject(objectid);

            SetObjectMaterialText(
                new_objectid,
                GetObjectMaterialText        (new_objectid, materialindex),
                materialindex,
                GetObjectTextMaterialSize    (new_objectid, materialindex),
                g_Fonts[listitem],
                GetObjectTextFontSize        (new_objectid, materialindex),
                IsObjectTextBold            (new_objectid, materialindex),
                GetObjectTextColor            (new_objectid, materialindex),
                GetObjectTextBackColor        (new_objectid, materialindex),
                GetObjectTextAlignment        (new_objectid, materialindex)
            );

            SendClientMessage(playerid, RGBA_GREEN,
                sprintf("You have set the font %i of the object \"%s\" to \"%s\".",
                    materialindex, GetObjectModelName(modelid), g_Fonts[listitem]
                )
            );
        }

        ShowPlayerObjectDialog(playerid, g_ObjectIndexDialog);
        return 1;
    }
    else if(dialogid == g_ObjectTextFontSizeDialog)
    {
        if(!response)
        {
            ShowPlayerObjectDialog(playerid, g_ObjectIndexDialog);
            return 1;
        }

        if(isempty(inputtext))
            SendClientMessage(playerid, RGBA_RED, "The fontsize of this object could not be set!");
        else
        {
            new size = strval(inputtext);
            if(size < 0 || size > 255)
            {
                SendClientMessage(playerid, RGBA_RED, "The fontsize of this object could not be set!");
                SendClientMessage(playerid, RGBA_RED, "Valid textsizes are 0 - 255!");
            }
            else
            {
                new objectid = g_pEditObject[playerid],
                    modelid = GetObjectModel(objectid),
                    materialindex = g_pEditObjectIndex{playerid},
                    new_objectid;

                RemoveObjectMaterial(objectid, materialindex);

                new_objectid = DuplicateObject(objectid);
                if(new_objectid == INVALID_OBJECT_ID)
                    SendClientMessage(playerid, RGBA_RED, "The fontsize of this object could not be set!");
                else
                {
                    g_pEditObject[playerid] = new_objectid;
                    DestroyObject(objectid);

                    SetObjectMaterialText(
                        new_objectid,
                        GetObjectMaterialText        (new_objectid, materialindex),
                        materialindex,
                        GetObjectTextMaterialSize    (new_objectid, materialindex),
                        GetObjectTextFont            (new_objectid, materialindex),
                        size,
                        IsObjectTextBold            (new_objectid, materialindex),
                        GetObjectTextColor            (new_objectid, materialindex),
                        GetObjectTextBackColor        (new_objectid, materialindex),
                        GetObjectTextAlignment        (new_objectid, materialindex)
                    );

                    SendClientMessage(playerid, RGBA_GREEN,
                        sprintf("You have set the fontsize %i of the object \"%s\" to \"%i\".",
                            materialindex, GetObjectModelName(modelid), size
                        )
                    );
                }
            }
        }

        ShowPlayerObjectDialog(playerid, g_ObjectIndexDialog);
        return 1;
    }
    else if(dialogid == g_ObjectTextAlignmentDialog)
    {
        if(!response)
        {
            ShowPlayerObjectDialog(playerid, g_ObjectIndexDialog);
            return 1;
        }

        new objectid = g_pEditObject[playerid],
            modelid = GetObjectModel(objectid),
            materialindex = g_pEditObjectIndex{playerid},
            new_objectid;

        RemoveObjectMaterial(objectid, materialindex);

        new_objectid = DuplicateObject(objectid);
        if(new_objectid == INVALID_OBJECT_ID)
            SendClientMessage(playerid, RGBA_RED, "The text alignment of this object text could not be set!");
        else
        {
            g_pEditObject[playerid] = new_objectid;
            DestroyObject(objectid);

            SetObjectMaterialText(
                new_objectid,
                GetObjectMaterialText        (new_objectid, materialindex),
                materialindex,
                GetObjectTextMaterialSize    (new_objectid, materialindex),
                GetObjectTextFont            (new_objectid, materialindex),
                GetObjectTextFontSize        (new_objectid, materialindex),
                IsObjectTextBold            (new_objectid, materialindex),
                GetObjectTextColor            (new_objectid, materialindex),
                GetObjectTextBackColor        (new_objectid, materialindex),
                listitem
            );

            SendClientMessage(playerid, RGBA_GREEN,
                sprintf("You have set the text alignment %i of the object \"%s\" to \"%s\".",
                    materialindex, GetObjectModelName(modelid), g_TextAlignments[listitem]
                )
            );
        }

        ShowPlayerObjectDialog(playerid, g_ObjectIndexDialog);
        return 1;
    }
    else if(dialogid >= g_ObjectXDialog && dialogid <= g_ObjectRZDialog)
    {
        if(!response)
        {
            ShowPlayerObjectDialog(playerid, g_ObjectEditDialog);
            return 1;
        }

        new
            objectid = g_pEditObject[playerid],
            attach_objectid = GetObjectAttachedToObject(objectid),
            attach_vehicleid = GetObjectAttachedToVehicle(objectid),
            bool: attached = (attach_objectid == INVALID_OBJECT_ID && attach_vehicleid == INVALID_VEHICLE_ID) ? (false) : (true),
            movement_type[11]
        ;

        if(dialogid == g_ObjectXDialog)
            movement_type = (attached) ? ("x offset") : ("x position");
        else if(dialogid == g_ObjectYDialog)
            movement_type = (attached) ? ("y offset") : ("y position");
        else if(dialogid == g_ObjectZDialog)
            movement_type = (attached) ? ("z offset") : ("z position");
        else if(dialogid == g_ObjectRXDialog)
            movement_type = (attached) ? ("rx offset") : ("x rotation");
        else if(dialogid == g_ObjectRYDialog)
            movement_type = (attached) ? ("ry offset") : ("y rotation");
        else if(dialogid == g_ObjectRZDialog)
            movement_type = (attached) ? ("rz offset") : ("z rotation");

        if(isempty(inputtext))
        {
            ShowPlayerObjectDialog(playerid, dialogid);
            SendClientMessage(playerid, RGBA_RED,
                sprintf("Object %s could not be set!", movement_type)
            );
            return 1;
        }

        new
            Float:x,
            Float:y,
            Float:z,
            Float:rx,
            Float:ry,
            Float:rz
        ;

        if(attached)
            GetObjectAttachOffset(objectid, x, y, z, rx, ry, rz);
        else
        {
            GetObjectPos(objectid, x, y, z);
            GetObjectRot(objectid, rx, ry, rz);
        }

        new Float:amount = floatstr(inputtext);
        if(dialogid == g_ObjectXDialog)
            x = amount;
        else if(dialogid == g_ObjectYDialog)
            y = amount;
        else if(dialogid == g_ObjectZDialog)
            z = amount;
        else if(dialogid == g_ObjectRXDialog)
            rx = amount;
        else if(dialogid == g_ObjectRYDialog)
            ry = amount;
        else if(dialogid == g_ObjectRZDialog)
            rz = amount;

        if(attach_objectid != INVALID_OBJECT_ID)
            AttachObjectToObject(objectid, attach_objectid, x, y, z, rx, ry, rz);
        else if(attach_vehicleid != INVALID_VEHICLE_ID)
            AttachObjectToVehicle(objectid, attach_vehicleid, x, y, z, rx, ry, rz);
        else
        {
            SetObjectPos(objectid, x, y, z);
            SetObjectRot(objectid, rx, ry, rz);
        }

        ShowPlayerObjectDialog(playerid, g_ObjectEditDialog);

        new modelid = GetObjectModel(objectid);
        SendClientMessage(playerid, RGBA_GREEN,
            sprintf("You have set the %s of the object \"%s\" to \"%.4f\".",
                movement_type, GetObjectModelName(modelid), amount
            )
        );
        return 1;
    }

    #if defined o_OnDialogResponse
        return o_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
    #else
        return 0;
    #endif
}
#if defined _ALS_OnDialogResponse
    #undef OnDialogResponse
#else
    #define _ALS_OnDialogResponse
#endif
#define OnDialogResponse o_OnDialogResponse
#if defined o_OnDialogResponse
    forward o_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);
#endif

/******************************************************************************/

public OnPlayerEditObject(playerid, playerobject, objectid, response, Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ)
{
    switch(response)
    {
        case EDIT_RESPONSE_CANCEL:
            PlayerPlaySound(playerid, 1084, 0.0, 0.0, 0.0);
        case EDIT_RESPONSE_FINAL:
            PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
    }

    if(!playerobject && objectid == g_pEditObject[playerid])
    {
        switch(response)
        {
            case EDIT_RESPONSE_CANCEL:
            {
                new
                    modelid = GetObjectModel(objectid),
                    Float:x,
                    Float:y,
                    Float:z,
                    Float:rx,
                    Float:ry,
                    Float:rz
                ;

                LoadObjectPos(objectid, x, y, z);
                LoadObjectRot(objectid, rx, ry, rz);
                MoveObject(objectid, x, y, z, OBJECT_MOVESPEED, rx, ry, rz);

                ShowPlayerObjectDialog(playerid, g_ObjectEditDialog);
                SelectTextDraw(playerid, 0xFF0000FF);
                SendClientMessage(playerid, RGBA_GREEN,
                    sprintf("You have cancelled moving the object \"%s\".", GetObjectModelName(modelid))
                );
            }
            case EDIT_RESPONSE_FINAL:
            {
                SaveObjectPos(objectid, fX, fY, fZ);
                SaveObjectRot(objectid, fRotX, fRotY, fRotZ);
                MoveObject(objectid, fX, fY, fZ, OBJECT_MOVESPEED, fRotX, fRotY, fRotZ);

                new modelid = GetObjectModel(objectid);
                ShowPlayerObjectDialog(playerid, g_ObjectEditDialog);
                SelectTextDraw(playerid, 0xFF0000FF);
                SendClientMessage(playerid, RGBA_GREEN,
                    sprintf("You have finished moving the object \"%s\".", GetObjectModelName(modelid))
                );
            }
            case EDIT_RESPONSE_UPDATE:
                MoveObject(objectid, fX, fY, fZ, OBJECT_MOVESPEED, fRotX, fRotY, fRotZ);
        }
    }

    #if defined o_OnPlayerEditObject
        o_OnPlayerEditObject(playerid, playerobject, objectid, response, Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ);
    #endif
}
#if defined _ALS_OnPlayerEditObject
    #undef OnPlayerEditObject
#else
    #define _ALS_OnPlayerEditObject
#endif
#define OnPlayerEditObject o_OnPlayerEditObject
#if defined o_OnPlayerEditObject
    forward o_OnPlayerEditObject(playerid, playerobject, objectid, response, Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ);
#endif

/******************************************************************************/

public OnMBrowserResponse(playerid, browserid, response, page, listitem, search[])
{
    if(browserid == g_ObjectSelectBrowser)
    {
        switch(response)
        {
            case MBROWSER_RESPONSE_CLOSE:
            {
                HideMBrowser(playerid);
                ShowPlayerObjectDialog(playerid, g_ObjectMainDialog);
            }
            case MBROWSER_RESPONSE_SEARCH:
            {
                format(g_pSelectObjectSearch[playerid], MAX_MBROWSER_SEARCH, search);
                g_pSelectObjectPage[playerid] = 0;
                ShowMBrowser(playerid, browserid);
            }
            case MBROWSER_RESPONSE_PAGE_BACK:
            {
                if(g_pSelectObjectPage[playerid] > 0)
                {
                    g_pSelectObjectPage[playerid] --;
                    ShowMBrowser(playerid, browserid);
                }
            }
            case MBROWSER_RESPONSE_PAGE_NEXT:
            {
                new    min_pageitem = (g_pSelectObjectPage[playerid] + 1) * MAX_MBROWSER_PAGESIZE;
                if(min_pageitem < MAX_OBJECTS)
                {
                    g_pSelectObjectPage[playerid] ++;
                    ShowMBrowser(playerid, browserid);
                }
            }
            case MBROWSER_RESPONSE_PAGE_SET:
            {
                new min_pageitem = page * MAX_MBROWSER_PAGESIZE;
                if(min_pageitem < MAX_OBJECTS)
                {
                    g_pSelectObjectPage[playerid] = page;
                    ShowMBrowser(playerid, browserid);
                }
            }
            case MBROWSER_RESPONSE_BUTTON:
            {
                g_pEditObject[playerid] = g_pSelectObjectChoice[playerid];

                new
                    objectid = g_pEditObject[playerid],
                    modelid = GetObjectModel(objectid)
                ;

                HideMBrowser(playerid);
                ShowPlayerObjectDialog(playerid, g_ObjectEditDialog);
                SendClientMessage(playerid, RGBA_GREEN,
                    sprintf("You have selected the object \"%s\".", GetObjectModelName(modelid))
                );
            }
            case MBROWSER_RESPONSE_LISTITEM:
            {
                new
                    pageitem = listitem + (g_pSelectObjectPage[playerid] * MAX_MBROWSER_PAGESIZE),
                    is_searching = strlen(g_pSelectObjectSearch[playerid]) > 0,
                    objectid = (is_searching) ? (g_pSelectObjectResult[playerid][listitem]) : (pageitem + 1)
                ;

                if(IsValidObject(objectid))
                {
                    g_pSelectObjectChoice[playerid] = objectid;

                    new modelid = GetObjectModel(objectid);
                    SetMBrowserModel(playerid, modelid);
                }
                else
                {
                    g_pSelectObjectChoice[playerid] = INVALID_OBJECT_ID;

                    HideMBrowserListItem(playerid, listitem);
                    HideMBrowserModel(playerid);
                }
            }
        }
        return 1;
    }
    else if(browserid == g_ObjectCreateBrowser)
    {
        switch(response)
        {
            case MBROWSER_RESPONSE_CLOSE:
            {
                HideMBrowser(playerid);
                ShowPlayerObjectDialog(playerid, g_ObjectMainDialog);
            }
            case MBROWSER_RESPONSE_SEARCH:
            {
                format(g_pCreateObjectSearch[playerid], MAX_MBROWSER_SEARCH, search);
                g_pCreateObjectPage[playerid] = 0;
                ShowMBrowser(playerid, browserid);
            }
            case MBROWSER_RESPONSE_PAGE_BACK:
            {
                if(g_pCreateObjectPage[playerid] > 0)
                {
                    g_pCreateObjectPage[playerid] --;
                    ShowMBrowser(playerid, browserid);
                }
            }
            case MBROWSER_RESPONSE_PAGE_NEXT:
            {
                new min_pageitem = (g_pCreateObjectPage[playerid] + 1) * MAX_MBROWSER_PAGESIZE;
                if(min_pageitem < g_MaxObjectModels)
                {
                    g_pCreateObjectPage[playerid] ++;
                    ShowMBrowser(playerid, browserid);
                }
            }
            case MBROWSER_RESPONSE_PAGE_SET:
            {
                new min_pageitem = page * MAX_MBROWSER_PAGESIZE;
                if(min_pageitem < g_MaxObjectModels)
                {
                    g_pCreateObjectPage[playerid] = page;
                    ShowMBrowser(playerid, browserid);
                }
            }
            case MBROWSER_RESPONSE_BUTTON:
            {
                new
                    model_materialindex = g_pCreateObjectChoice[playerid],
                    modelid = g_ObjectModels[model_materialindex][e_ObjectModelID],
                    Float:x,
                    Float:y,
                    Float:z,
                    Float:rx,
                    Float:ry,
                    Float:rz,
                    objectid
                ;

                VectorToPos(playerid, x, y, z, 10.0);
                g_pEditObject[playerid] = CreateObject(modelid, x, y, z, rx, ry, rz);
                objectid = g_pEditObject[playerid];

                SaveObjectPos(objectid, x, y, z);
                SaveObjectRot(objectid, rx, ry, rz);

                HideMBrowser(playerid);
                ShowPlayerObjectDialog(playerid, g_ObjectEditDialog);

                SendClientMessage(playerid, RGBA_GREEN,
                    sprintf("You have created the object \"%s\".",
                        ret_strunpack(g_ObjectModels[model_materialindex][e_ObjectModelName])
                    )
                );
            }
            case MBROWSER_RESPONSE_LISTITEM:
            {
                new pageitem = listitem + (g_pCreateObjectPage[playerid] * MAX_MBROWSER_PAGESIZE),
                    is_searching = strlen(g_pCreateObjectSearch[playerid]) > 0,
                    model_materialindex  = (is_searching) ? (g_pCreateObjectResult[playerid][listitem]) : (pageitem),
                    modelid = g_ObjectModels[model_materialindex][e_ObjectModelID];

                g_pCreateObjectChoice[playerid] = model_materialindex;
                SetMBrowserModel(playerid, modelid);
            }
        }
        return 1;
    }
    else if(browserid == g_ObjectMaterialBrowser)
    {
        switch(response)
        {
            case MBROWSER_RESPONSE_CLOSE:
            {
                HideMBrowser(playerid);
                ShowPlayerObjectDialog(playerid, g_ObjectIndexDialog);
            }
            case MBROWSER_RESPONSE_SEARCH:
            {
                format(g_pTextureObjectSearch[playerid], MAX_MBROWSER_SEARCH, search);
                g_pTextureObjectPage[playerid] = 0;
                ShowMBrowser(playerid, browserid);
            }
            case MBROWSER_RESPONSE_PAGE_BACK:
            {
                if(g_pTextureObjectPage[playerid] > 0)
                {
                    g_pTextureObjectPage[playerid] --;
                    ShowMBrowser(playerid, browserid);
                }
            }
            case MBROWSER_RESPONSE_PAGE_NEXT:
            {
                new min_pageitem = (g_pTextureObjectPage[playerid] + 1) * MAX_MBROWSER_PAGESIZE;
                if(min_pageitem < g_MaxTextures)
                {
                    g_pTextureObjectPage[playerid] ++;
                    ShowMBrowser(playerid, browserid);
                }
            }
            case MBROWSER_RESPONSE_PAGE_SET:
            {
                new min_pageitem = page * MAX_MBROWSER_PAGESIZE;
                if(min_pageitem < g_MaxTextures)
                {
                    g_pTextureObjectPage[playerid] = page;
                    ShowMBrowser(playerid, browserid);
                }
            }
            case MBROWSER_RESPONSE_LISTITEM:
            {
                new    is_searching = strlen(g_pTextureObjectSearch[playerid]) > 0,
                    pageitem = listitem + (g_pTextureObjectPage[playerid] * MAX_MBROWSER_PAGESIZE),
                    textureid = (is_searching) ? (g_pTextureObjectResult[playerid][listitem]) : (pageitem),
                    objectid = g_pEditObject[playerid],
                    materialindex = g_pEditObjectIndex{playerid},
                    modelid = GetObjectModel(objectid),
                    new_objectid;

                RemoveObjectMaterial(objectid, materialindex);
                RemoveObjectMaterialText(objectid, materialindex);

                new_objectid = DuplicateObject(objectid);
                if(new_objectid == INVALID_OBJECT_ID)
                {
                    SendClientMessage(playerid, RGBA_RED, "The texture of this object could not be set!");
                    return 1;
                }

                g_pEditObject[playerid] = new_objectid;
                DestroyObject(objectid);

                SetObjectMaterial(
                    new_objectid,
                    materialindex,
                    GetTextureModel    (textureid),
                    GetTextureTXD    (textureid),
                    GetTextureName    (textureid)
                );

                SendClientMessage(playerid, RGBA_GREEN,
                    sprintf("You have set the texture %i of the object \"%s\" to \"%s\".",
                        materialindex, GetObjectModelName(modelid), GetTextureName(textureid)
                    )
                );
            }
        }
        return 1;
    }

    #if defined o_OnMBrowserResponse
        return o_OnMBrowserResponse(playerid, browserid, response, page, listitem, search);
    #else
        return 0;
    #endif
}
#if defined _ALS_OnMBrowserResponse
    #undef OnMBrowserResponse
#else
    #define _ALS_OnMBrowserResponse
#endif
#define OnMBrowserResponse o_OnMBrowserResponse
#if defined o_OnMBrowserResponse
    forward o_OnMBrowserResponse(playerid, browserid, response, page, listitem, search[]);
#endif

/******************************************************************************/

public OnMBrowserShown(playerid, browserid)
{
    if(browserid == g_ObjectSelectBrowser)
    {
        SetMBrowserPage(playerid, g_pSelectObjectPage[playerid]);

        if(strlen(g_pSelectObjectSearch[playerid]) > 0)
        {
            SetMBrowserSearch(playerid, g_pSelectObjectSearch[playerid]);

            for(new listitem; listitem < MAX_MBROWSER_PAGESIZE; listitem ++)
            {
                g_pSelectObjectResult[playerid][listitem] = INVALID_OBJECT_ID;
                HideMBrowserListItem(playerid, listitem);
            }

            new    min_pageitem = g_pSelectObjectPage[playerid] * MAX_MBROWSER_PAGESIZE,
                max_pageitem = min_pageitem + MAX_MBROWSER_PAGESIZE,
                search_value = strval(g_pSelectObjectSearch[playerid]);

            for(new objectid = 1, matches; objectid <= MAX_OBJECTS; objectid ++)
            {
                if(!IsValidObject(objectid))
                    continue;

                new modelid = GetObjectModel(objectid);

                if(
                    (search_value != 0 && search_value == modelid) ||
                    strfind(GetObjectModelName(modelid), g_pSelectObjectSearch[playerid], true) != -1
                ){
                    if(matches >= min_pageitem && matches < max_pageitem)
                    {
                        new    listitem = matches - min_pageitem;

                        g_pSelectObjectResult[playerid][listitem] = objectid;
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
                new    pageitem = listitem + (g_pSelectObjectPage[playerid] * MAX_MBROWSER_PAGESIZE),
                    objectid = pageitem + 1;

                if(IsValidObject(objectid))
                {
                    new modelid = GetObjectModel(objectid);
                    SetMBrowserListItem(playerid, listitem, GetObjectModelName(modelid));
                }
                else
                    HideMBrowserListItem(playerid, listitem);
            }
        }

        new objectid = g_pSelectObjectChoice[playerid];
        if(objectid == INVALID_OBJECT_ID)
            HideMBrowserModel(playerid);
        else
        {
            new modelid = GetObjectModel(objectid);
            SetMBrowserModel(playerid, modelid);
        }
        return 1;
    }
    else if(browserid == g_ObjectCreateBrowser)
    {
        SetMBrowserPage(playerid, g_pCreateObjectPage[playerid]);

        if(strlen(g_pCreateObjectSearch[playerid]) > 0)
        {
            SetMBrowserSearch(playerid, g_pCreateObjectSearch[playerid]);

            for(new listitem; listitem < MAX_MBROWSER_PAGESIZE; listitem ++)
            {
                g_pCreateObjectResult[playerid][listitem] = -1;
                HideMBrowserListItem(playerid, listitem);
            }

            new min_pageitem = g_pCreateObjectPage[playerid] * MAX_MBROWSER_PAGESIZE,
                max_pageitem = min_pageitem + MAX_MBROWSER_PAGESIZE,
                search_value = strval(g_pCreateObjectSearch[playerid]),
                packed_search[MAX_MBROWSER_SEARCH];

            strpack(packed_search, g_pCreateObjectSearch[playerid]);

            for(new model_materialindex, matches; model_materialindex < g_MaxObjectModels; model_materialindex ++)
            {
                if(
                    (search_value != 0 && search_value == g_ObjectModels[model_materialindex][e_ObjectModelID]) ||
                    strfind(g_ObjectModels[model_materialindex][e_ObjectModelName], packed_search, true) != -1
                ){
                    if(matches >= min_pageitem && matches < max_pageitem)
                    {
                        new    listitem = matches - min_pageitem;

                        g_pCreateObjectResult[playerid][listitem] = model_materialindex;
                        SetMBrowserListItem(playerid, listitem,
                            ret_strunpack(g_ObjectModels[model_materialindex][e_ObjectModelName])
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
                new model_materialindex = listitem + (g_pCreateObjectPage[playerid] * MAX_MBROWSER_PAGESIZE);
                if(model_materialindex < g_MaxObjectModels)
                {
                    SetMBrowserListItem(playerid, listitem,
                        ret_strunpack(g_ObjectModels[model_materialindex][e_ObjectModelName])
                    );
                }
                else
                    HideMBrowserListItem(playerid, listitem);
            }
        }

        new model_materialindex = g_pCreateObjectChoice[playerid];
        if(model_materialindex == -1)
            HideMBrowserModel(playerid);
        else
        {
            new modelid = g_ObjectModels[model_materialindex][e_ObjectModelID];
            SetMBrowserModel(playerid, modelid);
        }
        return 1;
    }
    else if(browserid == g_ObjectMaterialBrowser)
    {
        SetMBrowserPage(playerid, g_pTextureObjectPage[playerid]);

        if( strlen(g_pTextureObjectSearch[playerid]) > 0 )
        {
            SetMBrowserSearch(playerid, g_pTextureObjectSearch[playerid]);

            for(new listitem; listitem < MAX_MBROWSER_PAGESIZE; listitem ++)
            {
                g_pTextureObjectResult[playerid][listitem] = -1;
                HideMBrowserListItem(playerid, listitem);
            }

            new min_pageitem = g_pTextureObjectPage[playerid] * MAX_MBROWSER_PAGESIZE,
                max_pageitem = min_pageitem + MAX_MBROWSER_PAGESIZE,
                search_value = strval(g_pTextureObjectSearch[playerid]),
                packed_search[MAX_MBROWSER_SEARCH];

            strpack(packed_search, g_pTextureObjectSearch[playerid]);

            for(new textureid, matches; textureid < g_MaxTextures; textureid ++)
            {
                if(
                    (search_value != 0 && search_value == g_Textures[textureid][e_TextureModel]) ||
                    strfind(g_Textures[textureid][e_TextureTXD], packed_search, true) != -1 ||
                    strfind(g_Textures[textureid][e_TextureName], packed_search, true) != -1
                ){
                    if(matches >= min_pageitem && matches < max_pageitem)
                    {
                        new    listitem = matches - min_pageitem;

                        g_pTextureObjectResult[playerid][listitem] = textureid;
                        SetMBrowserListItem(playerid, listitem,
                            ret_strunpack(g_Textures[textureid][e_TextureName])
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
                new textureid = listitem + (g_pTextureObjectPage[playerid] * MAX_MBROWSER_PAGESIZE);
                if(textureid < g_MaxTextures)
                    SetMBrowserListItem(playerid, listitem, GetTextureName(textureid));
                else
                    HideMBrowserListItem(playerid, listitem);
            }
        }
        return 1;
    }

    #if defined o_OnMBrowserShown
        return o_OnMBrowserShown(playerid, browserid);
    #else
        return 0;
    #endif
}
#if defined _ALS_OnMBrowserShown
    #undef OnMBrowserShown
#else
    #define _ALS_OnMBrowserShown
#endif
#define OnMBrowserShown o_OnMBrowserShown
#if defined o_OnMBrowserShown
    forward o_OnMBrowserShown(playerid, browserid);
#endif

/******************************************************************************/

public OnCBrowserResponse(playerid, browserid, response, color)
{
    if(
        browserid == g_ObjectTextureColorBrowser ||
        browserid == g_ObjectFontColorBrowser ||
        browserid == g_ObjectBackColorBrowser
    ){
        switch(response)
        {
            case CBROWSER_RESPONSE_CLOSE:
            {
                HideCBrowser(playerid);
                ShowPlayerObjectDialog(playerid, g_ObjectIndexDialog);
            }
            case CBROWSER_RESPONSE_PAGE_BACK:
            {
                if(browserid == g_ObjectTextureColorBrowser && g_pObjectTextureColorPage{playerid} > 0)
                    ShowCBrowser(playerid, browserid, -- g_pObjectTextureColorPage{playerid});

                else if(browserid == g_ObjectFontColorBrowser && g_pObjectFontColorPage{playerid} > 0)
                    ShowCBrowser(playerid, browserid, -- g_pObjectFontColorPage{playerid});

                else if(browserid == g_ObjectBackColorBrowser && g_pObjectBackColorPage{playerid} > 0)
                        ShowCBrowser(playerid, browserid, -- g_pObjectBackColorPage{playerid});
            }
            case CBROWSER_RESPONSE_PAGE_NEXT:
            {
                new
                    page,
                    min_pageitem
                ;

                if(browserid == g_ObjectTextureColorBrowser)
                    page = g_pObjectTextureColorPage{playerid};

                else if(browserid == g_ObjectFontColorBrowser)
                    page = g_pObjectFontColorPage{playerid};

                else if(browserid == g_ObjectBackColorBrowser)
                    page = g_pObjectBackColorPage{playerid};

                min_pageitem = (page + 1) * MAX_CBROWSER_PAGESIZE;
                if(min_pageitem < g_MaxVehicleColors)
                {
                    if(browserid == g_ObjectTextureColorBrowser)
                        ShowCBrowser(playerid, browserid, ++ g_pObjectTextureColorPage{playerid});

                    else if(browserid == g_ObjectFontColorBrowser)
                        ShowCBrowser(playerid, browserid, ++ g_pObjectFontColorPage{playerid});

                    else if(browserid == g_ObjectBackColorBrowser)
                        ShowCBrowser(playerid, browserid, ++ g_pObjectBackColorPage{playerid});
                }
            }
            case CBROWSER_RESPONSE_COLOR:
            {
                new objectid = g_pEditObject[playerid],
                    materialindex = g_pEditObjectIndex{playerid},
                    page,
                    pageitem;

                if(browserid == g_ObjectTextureColorBrowser)
                    page = g_pObjectTextureColorPage{playerid};

                else if(browserid == g_ObjectFontColorBrowser)
                    page = g_pObjectFontColorPage{playerid};

                else if(browserid == g_ObjectBackColorBrowser)
                    page = g_pObjectBackColorPage{playerid};

                pageitem = color + (page * MAX_CBROWSER_PAGESIZE);

                if(browserid == g_ObjectTextureColorBrowser)
                {
                    new
                        textureid = GetObjectTextureID(objectid, materialindex),
                        rgba_color = g_VehicleColors[pageitem],
                        argb_color = RGBAtoARGB(rgba_color)
                    ;

                    RemoveObjectMaterialText(objectid, materialindex);

                    SetObjectMaterial(
                        objectid,
                        materialindex,
                        GetTextureModel    (textureid),
                        GetTextureTXD    (textureid),
                        GetTextureName    (textureid),
                        argb_color
                    );
                }
                else if(browserid == g_ObjectFontColorBrowser)
                {
                    RemoveObjectMaterial(objectid, materialindex);

                    SetObjectMaterialText(
                        objectid,
                        GetObjectMaterialText(objectid, materialindex),
                        materialindex,
                        GetObjectTextMaterialSize(objectid, materialindex),
                        GetObjectTextFont(objectid, materialindex),
                        GetObjectTextFontSize(objectid, materialindex),
                        IsObjectTextBold(objectid, materialindex),
                        RGBAtoARGB(g_VehicleColors[pageitem]),
                        GetObjectTextBackColor(objectid, materialindex),
                        GetObjectTextAlignment(objectid, materialindex)
                    );
                }
                else if(browserid == g_ObjectBackColorBrowser)
                {
                    RemoveObjectMaterial(objectid, materialindex);

                    SetObjectMaterialText(
                        objectid,
                        GetObjectMaterialText(objectid, materialindex),
                        materialindex,
                        GetObjectTextMaterialSize(objectid, materialindex),
                        GetObjectTextFont(objectid, materialindex),
                        GetObjectTextFontSize(objectid, materialindex),
                        IsObjectTextBold(objectid, materialindex),
                        GetObjectTextColor(objectid, materialindex),
                        RGBAtoARGB(g_VehicleColors[pageitem]),
                        GetObjectTextAlignment(objectid, materialindex)
                    );
                }

                new new_objectid = DuplicateObject(objectid);
                if(new_objectid != INVALID_OBJECT_ID)
                {
                    g_pEditObject[playerid] = new_objectid;
                    DestroyObject(objectid);
                }
            }
        }
        return 1;
    }

    #if defined o_OnCBrowserResponse
        return o_OnCBrowserResponse(playerid, browserid, response, color);
    #else
        return 0;
    #endif
}
#if defined _ALS_OnCBrowserResponse
    #undef OnCBrowserResponse
#else
    #define _ALS_OnCBrowserResponse
#endif
#define OnCBrowserResponse o_OnCBrowserResponse
#if defined o_OnCBrowserResponse
    forward o_OnCBrowserResponse(playerid, browserid, response, color);
#endif

/******************************************************************************/

public OnCBrowserShown(playerid, browserid, page)
{
    if(
        browserid == g_ObjectTextureColorBrowser ||
        browserid == g_ObjectFontColorBrowser ||
        browserid == g_ObjectBackColorBrowser
    ){
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

    #if defined o_OnCBrowserShown
        return o_OnCBrowserShown(playerid, browserid, page);
    #else
        return 0;
    #endif
}
#if defined _ALS_OnCBrowserShown
    #undef OnCBrowserShown
#else
    #define _ALS_OnCBrowserShown
#endif
#define OnCBrowserShown o_OnCBrowserShown
#if defined o_OnCBrowserShown
    forward o_OnCBrowserShown(playerid, browserid, page);
#endif

/******************************************************************************/

public OnToolbarResponse(playerid, response)
{
    if(response == TOOLBAR_OBJECT)
    {
        ShowPlayerObjectDialog(playerid, g_ObjectMainDialog);
        return 1;
    }

    #if defined o_OnToolbarResponse
        return o_OnToolbarResponse(playerid, response);
    #else
        return 0;
    #endif
}
#if defined _ALS_OnToolbarResponse
    #undef OnToolbarResponse
#else
    #define _ALS_OnToolbarResponse
#endif
#define OnToolbarResponse o_OnToolbarResponse
#if defined o_OnToolbarResponse
    forward o_OnToolbarResponse(playerid, response);
#endif

/******************************************************************************/

public OnPlayerSelectObject(playerid, type, objectid, modelid, Float:fX, Float:fY, Float:fZ)
{
    g_pEditObject[playerid] = objectid;

    HideMBrowser(playerid);
    ShowPlayerObjectDialog(playerid, g_ObjectEditDialog);

    CancelEdit(playerid);
    SelectTextDraw(playerid, 0xFF0000FF);

    SendClientMessage(playerid, RGBA_GREEN,
        sprintf("You have selected the object \"%s\".", GetObjectModelName(modelid))
    );

    #if defined o_OnPlayerSelectObject
        o_OnPlayerSelectObject(playerid, type, objectid, modelid, Float:fX, Float:fY, Float:fZ);
    #endif
}
#if defined _ALS_OnPlayerSelectObject
    #undef OnPlayerSelectObject
#else
    #define _ALS_OnPlayerSelectObject
#endif
#define OnPlayerSelectObject o_OnPlayerSelectObject
#if defined o_OnPlayerSelectObject
    forward o_OnPlayerSelectObject(playerid, type, objectid, modelid, Float:fX, Float:fY, Float:fZ);
#endif
