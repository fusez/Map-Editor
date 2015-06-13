stock SaveObjectPos(objectid, Float:x, Float:y, Float:z)
{
    g_ObjectSavePos[objectid - 1][0] = x;
    g_ObjectSavePos[objectid - 1][1] = y;
    g_ObjectSavePos[objectid - 1][2] = z;
}

stock LoadObjectPos(objectid, &Float:x, &Float:y, &Float:z)
{
    x = g_ObjectSavePos[objectid - 1][0];
    y = g_ObjectSavePos[objectid - 1][1];
    z = g_ObjectSavePos[objectid - 1][2];
}

stock SaveObjectRot(objectid, Float:rx, Float:ry, Float:rz)
{
    g_ObjectSaveRot[objectid - 1][0] = rx;
    g_ObjectSaveRot[objectid - 1][1] = ry;
    g_ObjectSaveRot[objectid - 1][2] = rz;
}

stock LoadObjectRot(objectid, &Float:rx, &Float:ry, &Float:rz)
{
    rx = g_ObjectSaveRot[objectid - 1][0];
    ry = g_ObjectSaveRot[objectid - 1][1];
    rz = g_ObjectSaveRot[objectid - 1][2];
}

stock SavePlayerObjectPos(playerid, objectid, Float:x, Float:y, Float:z)
{
    g_pObjectSavePos[playerid][objectid - 1][0] = x;
    g_pObjectSavePos[playerid][objectid - 1][1] = y;
    g_pObjectSavePos[playerid][objectid - 1][2] = z;
}

stock LoadPlayerObjectPos(playerid, objectid, &Float:x, &Float:y, &Float:z)
{
    x = g_pObjectSavePos[playerid][objectid - 1][0];
    y = g_pObjectSavePos[playerid][objectid - 1][1];
    z = g_pObjectSavePos[playerid][objectid - 1][2];
}

stock SavePlayerObjectRot(playerid, objectid, Float:rx, Float:ry, Float:rz)
{
    g_pObjectSaveRot[playerid][objectid - 1][0] = rx;
    g_pObjectSaveRot[playerid][objectid - 1][1] = ry;
    g_pObjectSaveRot[playerid][objectid - 1][2] = rz;
}

stock LoadPlayerObjectRot(playerid, objectid, &Float:rx, &Float:ry, &Float:rz)
{
    rx = g_pObjectSaveRot[playerid][objectid - 1][0];
    ry = g_pObjectSaveRot[playerid][objectid - 1][1];
    rz = g_pObjectSaveRot[playerid][objectid - 1][2];
}

DuplicateObject(old_objectid, bool:duplicate_attachments = true)
{
    if(old_objectid == INVALID_OBJECT_ID)
        return INVALID_OBJECT_ID;

    new new_objectid,
        modelid = GetObjectModel(old_objectid),
        Float:x,
        Float:y,
        Float:z,
        Float:rx,
        Float:ry,
        Float:rz,
        attach_to_objectid = GetObjectAttachedToObject(old_objectid),
        attach_to_vehicleid = GetObjectAttachedToVehicle(old_objectid);

    GetObjectPos(old_objectid, x, y, z);
    GetObjectRot(old_objectid, rx, ry, rz);

    new_objectid = CreateObject(modelid, x, y, z, rx, ry, rz);
    if(new_objectid == INVALID_OBJECT_ID)
        return INVALID_OBJECT_ID;

    for(new materialindex; materialindex < MAX_OBJECT_INDEX; materialindex ++)
    {
        if(IsObjectTextured(old_objectid, materialindex))
        {
            new textureid = GetObjectTextureID(old_objectid, materialindex);

            SetObjectMaterial(
                new_objectid,
                materialindex,
                GetTextureModel            (textureid),
                GetTextureTXD           (textureid),
                GetTextureName            (textureid),
                GetObjectTextureColor    (old_objectid, materialindex)
            );
        }
        else if(IsObjectText(old_objectid, materialindex))
        {
            SetObjectMaterialText(
                new_objectid,
                GetObjectMaterialText        (old_objectid, materialindex),
                materialindex,
                GetObjectTextMaterialSize    (old_objectid, materialindex),
                GetObjectTextFont            (old_objectid, materialindex),
                GetObjectTextFontSize        (old_objectid, materialindex),
                IsObjectTextBold            (old_objectid, materialindex),
                GetObjectTextColor            (old_objectid, materialindex),
                GetObjectTextBackColor        (old_objectid, materialindex),
                GetObjectTextAlignment        (old_objectid, materialindex)
            );
        }
    }

    if(attach_to_objectid != INVALID_OBJECT_ID)
    {
        new
            Float:ox,
            Float:oy,
            Float:oz,
            Float:orx,
            Float:ory,
            Float:orz
        ;

        GetObjectAttachOffset(old_objectid, ox, oy, oz, orx, ory, orz);
        AttachObjectToObject(new_objectid, attach_to_objectid, ox, oy, oz, orx, ory, orz);
    }
    else if(attach_to_vehicleid != INVALID_VEHICLE_ID)
    {
        new    Float:ox,
            Float:oy,
            Float:oz,
            Float:orx,
            Float:ory,
            Float:orz;

        GetObjectAttachOffset(old_objectid, ox, oy, oz, orx, ory, orz);
        AttachObjectToVehicle(new_objectid, attach_to_vehicleid, ox, oy, oz, orx, ory, orz);
    }

    if(!duplicate_attachments)
        return new_objectid;

    for(new loop_objectid = 1; loop_objectid <= MAX_OBJECTS; loop_objectid ++)
    {
        if(GetObjectAttachedToObject(loop_objectid) == old_objectid)
        {
            new attach_objectid = DuplicateObject(loop_objectid, false);
            if(attach_objectid == INVALID_OBJECT_ID)
                continue;

            new    Float:ox,
                Float:oy,
                Float:oz,
                Float:orx,
                Float:ory,
                Float:orz;

            GetObjectAttachOffset(attach_objectid, ox, oy, oz, orx, ory, orz);
            AttachObjectToObject(attach_objectid, new_objectid, ox, oy, oz, orx, ory, orz);
        }
    }

    return new_objectid;
}

RemoveObjectMaterial(objectid, materialindex)
{
    if(!IsValidObject(objectid))
        return 0;

    g_ObjectTextureID        [objectid - 1][materialindex] = -1;
    g_ObjectTextureColor    [objectid - 1][materialindex] = 0;
    return 1;
}

RemoveObjectMaterialText(objectid, materialindex)
{
    if(!IsValidObject(objectid))
        return 0;

    g_IsObjectText            [objectid - 1][materialindex] = false;
    g_ObjectText            [objectid - 1][materialindex] = "";
    g_ObjectMaterialSize    [objectid - 1][materialindex] = OBJECT_MATERIAL_SIZE_256x128;
    g_ObjectFont            [objectid - 1][materialindex] = "Arial";
    g_ObjectFontSize        [objectid - 1][materialindex] = 24;
    g_IsObjectTextBold        [objectid - 1][materialindex] = true;
    g_ObjectTextColor        [objectid - 1][materialindex] = 0xFFFFFFFF;
    g_ObjectTextBackColor    [objectid - 1][materialindex] = 0;
    g_ObjectTextAlignment    [objectid - 1][materialindex] = 0;
    return 1;
}
