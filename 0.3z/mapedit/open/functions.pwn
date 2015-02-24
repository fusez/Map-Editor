OpenMap(const mapname[])
{
	if(isempty(mapname))
		return 0;

	if(!IsValidFilename(mapname))
		return 0;

	new directory[32];
	format(directory, sizeof directory, "maps/%s.project", mapname);
	if(!fexist(directory))
		return 0;

	new File:project = fopen(directory, io_read);
	if(!project)
		return 0;

	new	buffer			[200],
		slot_objectid	[MAX_OBJECTS] = {INVALID_OBJECT_ID, ...},
		slot_vehicleid	[MAX_VEHICLES] = {INVALID_VEHICLE_ID, ...};

	while(fread(project, buffer))
	{
		new count,
		    output[16][50];

		strtrim(buffer);
		if(isempty(buffer))
		    continue;

		count = strexplode(output, buffer, ";");
		if(isequal(output[0], "object") && count == 9)
		{
			new slot = strval(output[1]),
				modelid = strval(output[2]),
				Float:x = floatstr(output[3]),
				Float:y = floatstr(output[4]),
				Float:z = floatstr(output[5]),
				Float:rx = floatstr(output[6]),
				Float:ry = floatstr(output[7]),
				Float:rz = floatstr(output[8]);

			if(slot < 0 || slot >= MAX_OBJECTS)
				continue;

			slot_objectid[slot] = CreateObject(modelid, x, y, z, rx, ry, rz);
		}
		else if(isequal(output[0], "vehicle") && count == 9)
		{
			new slot = strval(output[1]),
				modelid = strval(output[2]),
				Float:x = floatstr(output[3]),
				Float:y = floatstr(output[4]),
				Float:z = floatstr(output[5]),
				Float:r = floatstr(output[6]),
				color1 = strval(output[7]),
				color2 = strval(output[8]);

			if(slot < 0 || slot >= MAX_VEHICLES)
				continue;

			slot_vehicleid[slot] = CreateVehicle(modelid, x, y, z, r, color1, color2, -1);
		}
		else if(isequal(output[0], "pickup") && count == 5)
		{
			new modelid = strval(output[1]),
				Float:x = floatstr(output[2]),
				Float:y = floatstr(output[3]),
				Float:z = floatstr(output[4]);

			CreatePickup(modelid, 1, x, y, z);
		}
		else if(isequal(output[0], "texture") && count == 5)
		{
			new slot = strval(output[1]),
				materialindex = strval(output[2]),
				textureid = strval(output[3]),
				color = strval(output[4]);

			if(slot < 0 || slot >= MAX_OBJECTS)
			    continue;

			if(materialindex < 0 || materialindex >= MAX_OBJECT_INDEX)
				continue;

			new objectid = slot_objectid[slot];
			if(objectid == INVALID_OBJECT_ID)
				continue;

			SetObjectMaterial(objectid, materialindex, textureid, color);
		}
		else if(isequal(output[0], "text") && count == 11)
		{
			new slot = strval(output[1]),
				materialindex = strval(output[3]),
				materialsize = strval(output[4]),
				fontsize = strval(output[6]),
				bool:bold = (strval(output[7]) > 0) ? (true) : (false),
				fontcolor = strval(output[8]),
				backcolor = strval(output[9]),
				textalignment = strval(output[10]);

			if(slot < 0 || slot >= MAX_OBJECTS)
			    continue;

			if(materialindex < 0 || materialindex >= MAX_OBJECT_INDEX)
				continue;

			new objectid = slot_objectid[slot];
			if(objectid == INVALID_OBJECT_ID)
				continue;

			SetObjectMaterialText(objectid, output[2], materialindex, materialsize, output[5], fontsize, bold, fontcolor, backcolor, textalignment);
		}
		else if(isequal(output[0], "attach_object") && count == 9)
		{
			new slot = strval(output[1]),
			    attach_slot = strval(output[2]),
			    Float:x = floatstr(output[3]),
			    Float:y = floatstr(output[4]),
			    Float:z = floatstr(output[5]),
			    Float:rx = floatstr(output[6]),
			    Float:ry = floatstr(output[7]),
			    Float:rz = floatstr(output[8]);

			if(slot < 0 || slot >= MAX_OBJECTS)
			    continue;

			if(attach_slot < 0 || attach_slot >= MAX_OBJECTS)
				continue;

			new objectid = slot_objectid[slot];
			if(objectid == INVALID_OBJECT_ID)
			    continue;

		    new attachtoid = slot_objectid[attach_slot];
			if(attachtoid == INVALID_OBJECT_ID)
				continue;

			if(objectid == attachtoid)
				continue;

			AttachObjectToObject(objectid, attachtoid, x, y, z, rx, ry, rz);
		}
		else if(isequal(output[0], "attach_vehicle") && count == 9)
		{
			new slot = strval(output[1]),
			    attach_slot = strval(output[2]),
			    Float:x = floatstr(output[3]),
			    Float:y = floatstr(output[4]),
			    Float:z = floatstr(output[5]),
			    Float:rx = floatstr(output[6]),
			    Float:ry = floatstr(output[7]),
			    Float:rz = floatstr(output[8]);

			if(slot < 0 || slot >= MAX_OBJECTS || attach_slot < 0 || attach_slot >= MAX_VEHICLES)
			    continue;

			new objectid = slot_objectid[slot];
			if(objectid == INVALID_OBJECT_ID)
				continue;

			new attachtoid = slot_vehicleid[attach_slot];
			if(attachtoid == INVALID_VEHICLE_ID)
				continue;

			AttachObjectToVehicle(objectid, attachtoid, x, y, z, rx, ry, rz);
		}
		else if(isequal(output[0], "component") && count == 3)
		{
			new slot = strval(output[1]),
			    componentid = strval(output[2]);

			if(slot < 0 || slot >= MAX_VEHICLES)
			    continue;

			new vehicleid = slot_vehicleid[slot];
			if(vehicleid == INVALID_VEHICLE_ID)
			    continue;

			switch(componentid)
			{
				case 1000..1193:
					AddVehicleComponent(vehicleid, componentid);
			}
		}
		else if(isequal(output[0], "paintjob") && count == 3)
		{
			new slot = strval(output[1]),
			    paintjobid = strval(output[2]);

			if(slot < 0 || slot >= MAX_VEHICLES)
			    continue;

			new vehicleid = slot_vehicleid[slot];
			if(vehicleid == INVALID_VEHICLE_ID)
			    continue;

			switch(paintjobid)
			{
				case 0,1,2:
					ChangeVehiclePaintjob(vehicleid, paintjobid);
			}
		}
		else if(isequal(output[0], "attach_player") && count == 15)
		{
			new	modelid = strval(output[2]),
				boneid = strval(output[3]),
				Float:x = floatstr(output[4]),
				Float:y = floatstr(output[5]),
				Float:z = floatstr(output[6]),
				Float:rx = floatstr(output[7]),
				Float:ry = floatstr(output[8]),
				Float:rz = floatstr(output[9]),
				Float:sx = floatstr(output[10]),
				Float:sy = floatstr(output[11]),
				Float:sz = floatstr(output[12]),
				color1 = strval(output[13]),
				color2 = strval(output[14]);

			if(boneid < 1 || boneid >= MAX_ATTACHED_BONE)
				continue;

			for(new playerid; playerid < MAX_PLAYERS; playerid ++)
			{
				if(!IsPlayerConnected(playerid))
					continue;

				if(!isequal(output[1], ret_GetPlayerName(playerid)))
					continue;

				for(new index; index < MAX_ATTACHED_INDEX; index ++)
				{
					if(IsPlayerAttachedObjectSlotUsed(playerid, index))
					    continue;

					SetPlayerAttachedObject(playerid, index, modelid, boneid, x, y, z, rx, ry, rz, sx, sy, sz, color1, color2);
					break;
				}
			}
		}
	}
	fclose(project);
	return 1;
}
