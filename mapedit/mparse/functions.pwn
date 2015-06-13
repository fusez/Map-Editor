mparse_SetPrefixData(type, prefix[], id)
{
    strtrim(prefix, " ");

    switch(type)
    {
        case MPARSE_PREFIX_OBJECT:
        {
            if(g_ObjectsAdded == MAX_OBJECTS)
                return 0;

            strpack(g_ObjectVariables[g_ObjectsAdded][MPARSE_PREFIX_NAME], prefix, MAX_MPARSE_PREFIX);
            g_ObjectVariables[g_ObjectsAdded ++][MPARSE_PREFIX_ID] = id;
        }
        case MPARSE_PREFIX_VEHICLE:
        {
            if(g_VehiclesAdded == MAX_VEHICLES)
                return 0;

            strpack(g_VehicleVariables[g_VehiclesAdded][MPARSE_PREFIX_NAME], prefix, MAX_MPARSE_PREFIX);
            g_VehicleVariables[g_VehiclesAdded ++][MPARSE_PREFIX_ID] = id;
        }
        case MPARSE_PREFIX_PICKUP:
        {
            if(g_PickupsAdded == MAX_PICKUPS)
                return 0;

            strpack(g_PickupVariables[g_PickupsAdded][MPARSE_PREFIX_NAME], prefix, MAX_MPARSE_PREFIX);
            g_PickupVariables[g_PickupsAdded ++][MPARSE_PREFIX_ID] = id;
        }
        default:
            return 0;
    }
    return 1;
}

mparse_GetPrefixData(type, prefix[])
{
    new
        prefix_packed[MAX_MPARSE_PREFIX]
    ;

    strtrim(prefix, " ");
    strpack(prefix_packed, prefix, MAX_MPARSE_PREFIX);

    switch(type)
    {
        case MPARSE_PREFIX_OBJECT:
        {
            for(new index = g_ObjectsAdded - 1; index >= 0; index --)
            {
                if(strcmp(g_ObjectVariables[index][MPARSE_PREFIX_NAME], prefix_packed) == 0)
                    return g_ObjectVariables[index][MPARSE_PREFIX_ID];
            }
            return INVALID_OBJECT_ID;
        }
        case MPARSE_PREFIX_VEHICLE:
        {
            for(new index = g_VehiclesAdded - 1; index >= 0; index --)
            {
                if(strcmp(g_VehicleVariables[index][MPARSE_PREFIX_NAME], prefix_packed) == 0)
                    return g_VehicleVariables[index][MPARSE_PREFIX_ID];
            }
            return INVALID_VEHICLE_ID;
        }
        case MPARSE_PREFIX_PICKUP:
        {
            for(new index = g_PickupsAdded - 1; index >= 0; index --)
            {
                if(strcmp(g_PickupVariables[index][MPARSE_PREFIX_NAME], prefix_packed) == 0)
                    return g_PickupVariables[index][MPARSE_PREFIX_ID];
            }
            return INVALID_PICKUP_ID;
        }
    }
    return 0;
}

mparse_LoadMap(map[])
{
    new path[50];
    format(path, sizeof path, "maps/%s.map", map);

    if(!fexist(path))
        return 0;

    new
        File:file_handle = fopen(path, io_read),
        buffer[300]
    ;

    if(!file_handle)
        return 0;

    while(fread(file_handle, buffer))
    {
        new start_index;
        if((start_index = strfind(buffer, "SetObjectMaterialText")) != -1)
        {
            new
                prefix[MAX_MPARSE_PREFIX],
                text[50],
                materialindex,
                materialsize,
                fontface[50],
                fontsize,
                bold,
                fontcolor,
                backcolor,
                alignment
            ;

            if(
                sscanf(buffer[start_index], "p<(>{s[22]}p<,>s[31]s[50]iis[50]iixxp<)>i", prefix, text, materialindex, materialsize, fontface, fontsize, bold, fontcolor, backcolor, alignment) &&
                sscanf(buffer[start_index], "p<(>{s[22]}p<,>s[31]s[50]iis[50]iiiip<)>i", prefix, text, materialindex, materialsize, fontface, fontsize, bold, fontcolor, backcolor, alignment)
            ){
                continue;
            }

            new objectid = mparse_GetPrefixData(MPARSE_PREFIX_OBJECT, prefix);
            if(objectid == INVALID_OBJECT_ID)
                continue;

            strtrim(text, "\"");
            strtrim(fontface, "\"");

            SetObjectMaterialText(
                objectid,
                text,
                materialindex,
                materialsize,
                fontface,
                fontsize,
                bold,
                fontcolor,
                backcolor,
                alignment
            );
        }
        else if((start_index = strfind(buffer, "SetObjectMaterial")) != -1)
        {
            new
                prefix[MAX_MPARSE_PREFIX],
                materialindex,
                modelid,
                txd[50],
                texture[50],
                color
            ;

            if(
                sscanf(buffer[start_index], "p<(>{s[18]}p<,>s[31]iis[50]s[50]p<)>x", prefix, materialindex, modelid, txd, texture, color) &&
                sscanf(buffer[start_index], "p<(>{s[18]}p<,>s[31]iis[50]s[50]p<)>i", prefix, materialindex, modelid, txd, texture, color)
            ){
                continue;
            }

            new objectid = mparse_GetPrefixData(MPARSE_PREFIX_OBJECT, prefix);
            if(objectid == INVALID_OBJECT_ID)
                continue;

            strtrim(txd, "\"");
            strtrim(texture, "\"");

            SetObjectMaterial(
                objectid,
                materialindex,
                modelid,
                txd,
                texture,
                color
            );
        }
        else if((start_index = strfind(buffer, "AddVehicleComponent")) != -1)
        {
            new
                prefix[MAX_MPARSE_PREFIX],
                componentid
            ;

            if(sscanf(buffer[start_index], "p<(>{s[20]}p<,>s[31]p<)>i", prefix, componentid))
                continue;

            new vehicleid = mparse_GetPrefixData(MPARSE_PREFIX_VEHICLE, prefix);
            if(vehicleid != INVALID_VEHICLE_ID)
                AddVehicleComponent(vehicleid, componentid);
        }
        else if((start_index = strfind(buffer, "ChangeVehiclePaintjob")) != -1)
        {
            new
                prefix[MAX_MPARSE_PREFIX],
                paintjobid
            ;

            if(sscanf(buffer[start_index], "p<(>{s[22]}p<,>s[31]p<)>i", prefix, paintjobid))
                continue;

            new vehicleid = mparse_GetPrefixData(MPARSE_PREFIX_VEHICLE, prefix);
            if(vehicleid != INVALID_VEHICLE_ID)
                ChangeVehiclePaintjob(vehicleid, paintjobid);
        }
        else if((start_index = strfind(buffer, "AttachObjectToObject")) != -1)
        {
            new
                object_prefix[MAX_MPARSE_PREFIX],
                attachto_prefix[MAX_MPARSE_PREFIX],
                Float:x,
                Float:y,
                Float:z,
                Float:rx,
                Float:ry,
                Float:rz
            ;

            if(sscanf(buffer[start_index], "p<(>{s[21]}p<,>s[31]s[31]fffffp<)>f", object_prefix, attachto_prefix, x, y, z, rx, ry, rz))
                continue;

            new objectid = mparse_GetPrefixData(MPARSE_PREFIX_OBJECT, object_prefix);
            if(objectid == INVALID_OBJECT_ID)
                continue;

            new attachtoid = mparse_GetPrefixData(MPARSE_PREFIX_OBJECT, attachto_prefix);
            if(attachtoid == INVALID_OBJECT_ID)
                continue;

            AttachObjectToObject(objectid, attachtoid, x, y, z, rx, ry, rz);
        }
        else if((start_index = strfind(buffer, "AttachObjectToVehicle")) != -1)
        {
            new
                object_prefix[MAX_MPARSE_PREFIX],
                vehicle_prefix[MAX_MPARSE_PREFIX],
                Float:x,
                Float:y,
                Float:z,
                Float:rx,
                Float:ry,
                Float:rz
            ;

            if(sscanf(buffer[start_index], "p<(>{s[22]}p<,>s[31]s[31]fffffp<)>f", object_prefix, vehicle_prefix, x, y, z, rx, ry, rz))
                continue;

            new objectid = mparse_GetPrefixData(MPARSE_PREFIX_OBJECT, object_prefix);
            if(objectid == INVALID_OBJECT_ID)
                continue;

            new vehicleid = mparse_GetPrefixData(MPARSE_PREFIX_VEHICLE, vehicle_prefix);
            if(vehicleid == INVALID_VEHICLE_ID)
                continue;

            AttachObjectToVehicle(objectid, vehicleid, x, y, z, rx, ry, rz);
        }
        else if((start_index = strfind(buffer, "CreateObject")) != -1)
        {
            new
                bool:prefix_found,
                prefix[MAX_MPARSE_PREFIX],
                modelid,
                Float:x,
                Float:y,
                Float:z,
                Float:rx,
                Float:ry,
                Float:rz,
                Float:stream_distance
            ;

            if(start_index > 0 && !sscanf(buffer, "p<=>s[31]p<(>{s[14]}p<,>ifffffp<)>f", prefix, modelid, x, y, z, rx, ry, rz))
                prefix_found = true, stream_distance = 0.0;
            else if(start_index > 0 && !sscanf(buffer, "p<=>s[31]p<(>{s[14]}p<,>iffffffp<)>f", prefix, modelid, x, y, z, rx, ry, rz, stream_distance))
                prefix_found = true;
            else if(!sscanf(buffer[start_index], "p<(>{s[13]}p<,>ifffffp<)>f", modelid, x, y, z, rx, ry, rz))
                prefix_found = false, stream_distance = 0.0;
            else if(!sscanf(buffer[start_index], "p<(>{s[13]}p<,>iffffffp<)>f", modelid, x, y, z, rx, ry, rz, stream_distance))
                prefix_found = false;
            else
                continue;

            new objectid = CreateObject(modelid, x, y, z, rx, ry, rz, stream_distance);
            if(prefix_found && objectid != INVALID_OBJECT_ID)
                mparse_SetPrefixData(MPARSE_PREFIX_OBJECT, prefix, objectid);
        }
        else if(
            (start_index = strfind(buffer, "AddStaticVehicleEx")) != -1 ||
            (start_index = strfind(buffer, "AddStaticVehicle")) != -1 ||
            (start_index = strfind(buffer, "CreateVehicle")) != -1
        ){
            new
                bool:prefix_found,
                prefix[MAX_MPARSE_PREFIX],
                modelid,
                Float:x,
                Float:y,
                Float:z,
                Float:r,
                color1,
                color2,
                respawn_delay
            ;

            if(start_index > 0 && !sscanf(buffer, "p<=>s[31]p<(>{s[20]}p<,>iffffip<)>i", prefix, modelid, x, y, z, r, color1, color2))
                prefix_found = true, respawn_delay = -1;
            else if(start_index > 0 && !sscanf(buffer, "p<=>s[31]p<(>{s[20]}p<,>iffffiip<)>i", prefix, modelid, x, y, z, r, color1, color2, respawn_delay))
                prefix_found = true;
            else if(!sscanf(buffer[start_index], "p<(>{s[19]}p<,>iffffip<)>i", modelid, x, y, z, r, color1, color2))
                prefix_found = false, respawn_delay = -1;
            else if(!sscanf(buffer[start_index], "p<(>{s[19]}p<,>iffffiip<)>i", modelid, x, y, z, r, color1, color2, respawn_delay))
                prefix_found = false;
            else
                continue;

            new vehicleid = CreateVehicle(modelid, x, y, z, r, color1, color2, respawn_delay);
            if(prefix_found && vehicleid != INVALID_VEHICLE_ID)
                mparse_SetPrefixData(MPARSE_PREFIX_VEHICLE, prefix, vehicleid);
        }
        else if(
            (start_index = strfind(buffer, "AddStaticPickup")) != -1 ||
            (start_index = strfind(buffer, "CreatePickup")) != -1
        ){
            new
                bool:prefix_found,
                prefix[MAX_MPARSE_PREFIX],
                modelid,
                type,
                Float:x,
                Float:y,
                Float:z,
                virtual_world
            ;

            if(start_index > 0 && !sscanf(buffer, "p<=>s[31]p<(>{s[17]}p<,>iiffp<)>f", prefix, modelid, type, x, y, z))
                prefix_found = true, virtual_world = -1;
            else if(start_index > 0 && !sscanf(buffer, "p<=>s[31]p<(>{s[17]}p<,>iifffp<)>i", prefix, modelid, type, x, y, z, virtual_world))
                prefix_found = true;
            else if(!sscanf(buffer[start_index], "p<(>{s[16]}p<,>iiffp<)>f", modelid, type, x, y, z))
                prefix_found = false, virtual_world = -1;
            else if(!sscanf(buffer[start_index], "p<(>{s[16]}p<,>iifffp<)>i", modelid, type, x, y, z, virtual_world))
                prefix_found = false;
            else
                continue;

            new pickupid = CreatePickup(modelid, type, x, y, z, virtual_world);
            if(prefix_found && pickupid != INVALID_PICKUP_ID)
                mparse_SetPrefixData(MPARSE_PREFIX_PICKUP, prefix, pickupid);
        }
        else if((start_index = strfind(buffer, "SetPlayerAttachedObject")) != -1)
        {
            new
                index,
                modelid,
                bone,
                Float:x,
                Float:y,
                Float:z,
                Float:rx,
                Float:ry,
                Float:rz,
                Float:sx,
                Float:sy,
                Float:sz,
                color1,
                color2
            ;

            if(
                sscanf(buffer[start_index], "p<(>{s[24]}p<,>{s[9]}iiifffffffffxp<)>x", index, modelid, bone, x, y, z, rx, ry, rz, sx, sy, sz, color1, color2) &&
                sscanf(buffer[start_index], "p<(>{s[24]}p<,>{s[9]}iiifffffffffip<)>i", index, modelid, bone, x, y, z, rx, ry, rz, sx, sy, sz, color1, color2)
            ){
                continue;
            }

            for(new playerid, max_playerid = GetMaxPlayers(); playerid < max_playerid; playerid ++)
            {
                if(IsPlayerConnected(playerid))
                    SetPlayerAttachedObject(playerid, index, modelid, bone, x, y, z, rx, ry, rz, sx, sy, sz, color1, color2);
            }
        }
    }

    g_ObjectsAdded = 0;
    g_VehiclesAdded = 0;
    g_PickupsAdded = 0;

    fclose(file_handle);
    return 1;
}
