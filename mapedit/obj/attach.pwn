stock GetObjectAttachOffset(objectid, &Float:x, &Float:y, &Float:z, &Float:rx, &Float:ry, &Float:rz)
{
    if(!IsValidObject(objectid))
        return 0;

    x = g_ObjectAttachOffset[objectid - 1][0];
    y = g_ObjectAttachOffset[objectid - 1][1];
    z = g_ObjectAttachOffset[objectid - 1][2];
    rx = g_ObjectAttachOffset[objectid - 1][3];
    ry = g_ObjectAttachOffset[objectid - 1][4];
    rz = g_ObjectAttachOffset[objectid - 1][5];
    return 1;
}

UnAttachObject(objectid)
{
    if(!IsValidObject(objectid))
        return 0;

    g_ObjectAttachToObject   [objectid - 1] = INVALID_OBJECT_ID;
    g_ObjectAttachToVehicle  [objectid - 1] = INVALID_VEHICLE_ID;
    for(new i; i < 6; i ++)
        g_ObjectAttachOffset [objectid - 1][i] = 0.0;
    return 1;
}
