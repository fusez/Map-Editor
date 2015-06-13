/******************************************************************************/

stock o_CreateObject(modelid, Float:X, Float:Y, Float:Z, Float:rX, Float:rY, Float:rZ, Float:DrawDistance = 0.0)
{
    new objectid = CreateObject(modelid, X, Y, Z, rX, rY, rZ, DrawDistance);
    if(objectid != INVALID_OBJECT_ID)
    {
        for(new materialindex; materialindex < MAX_OBJECT_INDEX; materialindex ++)
        {
            RemoveObjectMaterial(objectid, materialindex);
            RemoveObjectMaterialText(objectid, materialindex);
        }
    }
    return objectid;
}
#if defined _ALS_CreateObject
    #undef CreateObject
#else
    #define _ALS_CreateObject
#endif
#define CreateObject o_CreateObject

/******************************************************************************/

stock o_DestroyObject(objectid)
{
    if(IsValidObject(objectid))
    {
        if(
            GetObjectAttachedToObject(objectid) != INVALID_OBJECT_ID ||
            GetObjectAttachedToVehicle(objectid) != INVALID_VEHICLE_ID
        ){
            UnAttachObject(objectid);
        }

        for(new loop_objectid = 1; loop_objectid <= MAX_OBJECTS; loop_objectid ++)
        {
            if(GetObjectAttachedToObject(loop_objectid) == objectid)
                DestroyObject(loop_objectid);
        }

        for(new materialindex; materialindex < MAX_OBJECT_INDEX; materialindex ++)
        {
            RemoveObjectMaterial(objectid, materialindex);
            RemoveObjectMaterialText(objectid, materialindex);
        }

        for(new playerid; playerid < MAX_PLAYERS; playerid ++)
        {
            if(!IsPlayerConnected(playerid))
                continue;

            if(g_pEditObject[playerid] == objectid)
            {
                new mbrowserid = GetPlayerMBrowser(playerid),
                    cbrowserid = GetPlayerCBrowser(playerid),
                    dialogid = GetPlayerDialog(playerid);

                if(
                    mbrowserid == g_ObjectSelectBrowser ||
                    mbrowserid == g_ObjectCreateBrowser ||
                    mbrowserid == g_ObjectMaterialBrowser
                ){
                    HideMBrowser(playerid);
                }

                if(
                    cbrowserid == g_ObjectTextureColorBrowser ||
                    cbrowserid == g_ObjectFontColorBrowser ||
                    cbrowserid == g_ObjectBackColorBrowser
                ){
                    HideCBrowser(playerid);
                }

                if(
                    dialogid == g_ObjectMainDialog ||
                    dialogid == g_ObjectEditDialog ||
                    dialogid == g_ObjectIndexDialog ||
                    dialogid == g_ObjectXDialog ||
                    dialogid == g_ObjectYDialog ||
                    dialogid == g_ObjectZDialog ||
                    dialogid == g_ObjectRXDialog ||
                    dialogid == g_ObjectRYDialog ||
                    dialogid == g_ObjectRZDialog ||
                    dialogid == g_ObjectTextStringDialog ||
                    dialogid == g_ObjectTextMaterialSizeDialog ||
                    dialogid == g_ObjectTextFontDialog ||
                    dialogid == g_ObjectTextFontSizeDialog ||
                    dialogid == g_ObjectTextAlignmentDialog
                ){
                    HidePlayerDialog(playerid);
                }

                g_pEditObject[playerid] = INVALID_OBJECT_ID;
            }

            if(g_pSelectedAttachObject[playerid] == objectid)
                g_pSelectedAttachObject[playerid] = INVALID_OBJECT_ID;

            if(g_pSelectObjectChoice[playerid] == objectid)
            {
                if(GetPlayerMBrowser(playerid) == g_ObjectSelectBrowser)
                    HideMBrowserModel(playerid);

                g_pSelectObjectChoice[playerid] = INVALID_OBJECT_ID;
            }

            for(new listitem; listitem < MAX_MBROWSER_PAGESIZE; listitem ++)
            {
                if(g_pSelectObjectResult[playerid][listitem] == objectid)
                {
                    if(GetPlayerMBrowser(playerid) == g_ObjectSelectBrowser)
                        HideMBrowserListItem(playerid, listitem);

                    g_pSelectObjectResult[playerid][listitem] = INVALID_OBJECT_ID;
                }
            }
        }
    }
    DestroyObject(objectid);
}
#if defined _ALS_DestroyObject
    #undef DestroyObject
#else
    #define _ALS_DestroyObject
#endif
#define DestroyObject o_DestroyObject

/******************************************************************************/

stock o_SetObjectMaterial(objectid, materialindex, modelid, txdname[], texturename[], materialcolor = 0xFFFFFFFF)
{
    new textureid = GetTextureID(modelid, txdname, texturename);

    g_ObjectTextureID        [objectid - 1][materialindex] = textureid;
    g_ObjectTextureColor    [objectid - 1][materialindex] = materialcolor;

    SetObjectMaterial(
        objectid,
        materialindex,
        modelid,
        txdname,
        texturename,
        materialcolor
    );
}
#if defined _ALS_SetObjectMaterial
    #undef SetObjectMaterial
#else
    #define _ALS_SetObjectMaterial
#endif
#define SetObjectMaterial o_SetObjectMaterial

/******************************************************************************/

stock o_SetObjectMaterialText(objectid, text[], materialindex = 0, materialsize = OBJECT_MATERIAL_SIZE_256x128, fontface[] = "Arial", fontsize = 24, bold = 1, fontcolor = 0xFFFFFFFF, backcolor = 0, textalignment = 0)
{
    new success = SetObjectMaterialText(objectid, text, materialindex, materialsize, fontface, fontsize, bold, fontcolor, backcolor, textalignment);
    if(success)
    {
        new bool: b_bold = (bold == 0) ? (false) : (true);

        g_IsObjectText            [objectid - 1][materialindex] = true;
        format(g_ObjectText        [objectid - 1][materialindex], MAX_OBJECT_TEXT, text);
        g_ObjectMaterialSize    [objectid - 1][materialindex] = materialsize;
        format(g_ObjectFont        [objectid - 1][materialindex], MAX_OBJECT_FONT, fontface);
        g_ObjectFontSize        [objectid - 1][materialindex] = fontsize;
        g_IsObjectTextBold        [objectid - 1][materialindex] = b_bold;
        g_ObjectTextColor        [objectid - 1][materialindex] = fontcolor;
        g_ObjectTextBackColor    [objectid - 1][materialindex] = backcolor;
        g_ObjectTextAlignment    [objectid - 1][materialindex] = textalignment;
    }
    return success;
}
#if defined _ALS_SetObjectMaterialText
    #undef SetObjectMaterialText
#else
    #define _ALS_SetObjectMaterialText
#endif
#define SetObjectMaterialText o_SetObjectMaterialText

/******************************************************************************/

stock o_AttachObjectToObject(objectid, attachtoid, Float:OffsetX, Float:OffsetY, Float:OffsetZ, Float:RotX, Float:RotY, Float:RotZ, SyncRotation = 1)
{
    if(!IsValidObject(objectid))
        return 0;

    if(!IsValidObject(attachtoid))
        return 0;

    if(objectid == attachtoid)
        return 0;

    AttachObjectToObject(objectid, attachtoid, OffsetX, OffsetY, OffsetZ, RotX, RotY, RotZ, SyncRotation);

    for(new loop_objectid = 1; loop_objectid <= MAX_OBJECTS; loop_objectid  ++)
    {
        if(GetObjectAttachedToObject(loop_objectid) == objectid)
            UnAttachObject(loop_objectid);
    }

    g_ObjectAttachToObject  [objectid - 1]    = attachtoid;
    g_ObjectAttachToVehicle [objectid - 1]    = INVALID_VEHICLE_ID;
    g_ObjectAttachOffset    [objectid - 1][0] = OffsetX;
    g_ObjectAttachOffset    [objectid - 1][1] = OffsetY;
    g_ObjectAttachOffset    [objectid - 1][2] = OffsetZ;
    g_ObjectAttachOffset    [objectid - 1][3] = RotX;
    g_ObjectAttachOffset    [objectid - 1][4] = RotY;
    g_ObjectAttachOffset    [objectid - 1][5] = RotZ;

    return 1;
}
#if defined _ALS_AttachObjectToObject
    #undef AttachObjectToObject
#else
    #define _ALS_AttachObjectToObject
#endif
#define AttachObjectToObject o_AttachObjectToObject

/******************************************************************************/

stock o_AttachObjectToVehicle(objectid, vehicleid, Float:OffsetX, Float:OffsetY, Float:OffsetZ, Float:RotX, Float:RotY, Float:RotZ)
{
    if(!IsValidObject(objectid))
        return 0;

    if(!IsValidVehicle(vehicleid))
        return 0;

    AttachObjectToVehicle(objectid, vehicleid, OffsetX, OffsetY, OffsetZ, RotX, RotY, RotZ);

    for(new loop_objectid = 1; loop_objectid <= MAX_OBJECTS; loop_objectid  ++)
    {
        if(GetObjectAttachedToObject(loop_objectid) == objectid)
            UnAttachObject(loop_objectid);
    }

    g_ObjectAttachToObject  [objectid - 1]    = INVALID_OBJECT_ID;
    g_ObjectAttachToVehicle [objectid - 1]    = vehicleid;
    g_ObjectAttachOffset    [objectid - 1][0] = OffsetX;
    g_ObjectAttachOffset    [objectid - 1][1] = OffsetY;
    g_ObjectAttachOffset    [objectid - 1][2] = OffsetZ;
    g_ObjectAttachOffset    [objectid - 1][3] = RotX;
    g_ObjectAttachOffset    [objectid - 1][4] = RotY;
    g_ObjectAttachOffset    [objectid - 1][5] = RotZ;
    return 1;
}
#if defined _ALS_AttachObjectToVehicle
    #undef AttachObjectToVehicle
#else
    #define _ALS_AttachObjectToVehicle
#endif
#define AttachObjectToVehicle o_AttachObjectToVehicle

/******************************************************************************/
