SaveMap(const mapname[])
{
	if(isempty(mapname))
		return 0;

	if(!IsValidFilename(mapname))
		return 0;

	new	File:project = fopen( sprintf("maps/%s.project", mapname), io_write),
		File:export = fopen( sprintf("maps/%s.export", mapname), io_write);

	if(!project || !export)
	{
		if(project)
			fclose(project);

		if(export)
		    fclose(export);
		return 0;
	}

	new valid_objects,
	    valid_vehicles,
	    valid_pickups,
		slot_objectid       [MAX_OBJECTS],
		slot_vehicleid      [MAX_VEHICLES],
		slot_pickupid       [MAX_PICKUPS],
		objectid_slot       [MAX_OBJECTS],
		vehicleid_slot      [MAX_VEHICLES];

	for(new objectid = 1; objectid <= MAX_OBJECTS; objectid ++)
	{
		if(!IsValidObject(objectid))
			continue;

		slot_objectid[valid_objects] = objectid;
		objectid_slot[objectid - 1] = valid_objects;
		valid_objects ++;
	}

	for(new vehicleid = 1; vehicleid <= MAX_VEHICLES; vehicleid ++)
	{
		if(!IsValidVehicle(vehicleid))
		    continue;

		slot_vehicleid[valid_vehicles] = vehicleid;
		vehicleid_slot[vehicleid - 1] = valid_vehicles;
		valid_vehicles ++;
	}

	for(new pickupid; pickupid < MAX_PICKUPS; pickupid ++)
	{
		if(IsValidPickup(pickupid))
			slot_pickupid[valid_pickups ++] = pickupid;
	}

	if(valid_objects > 0)
		fwrite( export, sprintf("new g_Object[%i];\r\n", valid_objects) );

	if(valid_vehicles > 0)
		fwrite( export, sprintf("new g_Vehicle[%i];\r\n", valid_vehicles) );

	if(valid_pickups > 0)
		fwrite( export, sprintf("new g_Pickup[%i];\r\n", valid_pickups)	);

	// objects, object textures, object text
	for(new o; o < valid_objects; o ++)
	{
		new objectid = slot_objectid[o],
			modelid = GetObjectModel(objectid),
			Float:x,
			Float:y,
			Float:z,
			Float:rx,
			Float:ry,
			Float:rz,
			project_str[150],
			export_str[200];

		GetObjectPos(objectid, x, y, z);
		GetObjectRot(objectid, rx, ry, rz);

		format(project_str, sizeof project_str,
			"object;%i;%i;%.4f;%.4f;%.4f;%.4f;%.4f;%.4f\r\n",
			o, modelid, x, y, z, rx, ry, rz
		);

		format(export_str, sizeof export_str,
			"g_Object[%i] = CreateObject(%i, %.4f, %.4f, %.4f, %.4f, %.4f, %.4f); //%s\r\n",
			o, modelid, x, y, z, rx, ry, rz, GetObjectModelName(modelid)
		);

		fwrite(project, project_str);
		fwrite(export, export_str);

		for(new index; index < MAX_OBJECT_INDEX; index ++)
		{
			if(IsObjectTextured(objectid, index))
			{
				new textureid = GetObjectTextureID(objectid, index);

				format(project_str, sizeof project_str,
					"texture;%i;%i;%i;%i\r\n",
					o,
					index,
					textureid,
					GetObjectTextureColor(objectid, index)
				);

				format(export_str, sizeof export_str,
					"SetObjectMaterial(g_Object[%i], %i, %i, \"%s\", \"%s\", 0x%08x);\r\n",
					o,
					index,
					GetTextureModel(textureid),
					GetTextureTXD(textureid),
					GetTextureName(textureid),
					GetObjectTextureColor(objectid, index)
				);

				fwrite(project, project_str);
				fwrite(export, export_str);
			}
			else if(IsObjectText(objectid, index))
			{
				format(project_str, sizeof project_str,
					"text;%i;%s;%i;%i;%s;%i;%b;%i;%i;%i\r\n",
					o,
					GetObjectMaterialText(objectid, index),
					index,
					GetObjectTextMaterialSize(objectid, index),
					GetObjectTextFont(objectid, index),
					GetObjectTextFontSize(objectid, index),
					IsObjectTextBold(objectid, index),
					GetObjectTextColor(objectid, index),
					GetObjectTextBackColor(objectid, index),
					GetObjectTextAlignment(objectid, index)
				);

				format(export_str, sizeof export_str,
					"SetObjectMaterialText(g_Object[%i], \"%s\", %i, %i, \"%s\", %i, %b, 0x%x, 0x%x, %i);\r\n",
					o,
					GetObjectMaterialText(objectid, index),
					index,
					GetObjectTextMaterialSize(objectid, index),
					GetObjectTextFont(objectid, index),
					GetObjectTextFontSize(objectid, index),
					IsObjectTextBold(objectid, index),
					GetObjectTextColor(objectid, index),
					GetObjectTextBackColor(objectid, index),
					GetObjectTextAlignment(objectid, index)
				);

				fwrite(project, project_str);
				fwrite(export, export_str);
			}
		}
	}

	// vehicles, vehicle components, vehicle paintjobs
	for(new v; v < valid_vehicles; v ++)
	{
		new vehicleid = slot_vehicleid[v],
			modelid = GetVehicleModel(vehicleid),
			Float:x,
			Float:y,
			Float:z,
			Float:r,
			color[2],
			project_str[100],
			export_str[150];

		GetVehiclePos(vehicleid, x, y, z);
		GetVehicleZAngle(vehicleid, r);
		GetVehicleColor(vehicleid, color[0], color[1]);

		format(project_str, sizeof project_str,
			"vehicle;%i;%i;%.4f;%.4f;%.4f;%.4f;%i;%i\r\n",
			v, modelid, x, y, z, r, color[0], color[1]
		);

		format(export_str, sizeof export_str,
			"g_Vehicle[%i] = CreateVehicle(%i, %.4f, %.4f, %.4f, %.4f, %i, %i, -1); //%s\r\n",
			v, modelid, x, y, z, r, color[0], color[1], GetVehicleModelName(modelid)
		);

		fwrite(project, project_str);
		fwrite(export, export_str);

		for(new s; s < 14; s ++)
		{
		    new componentid = GetVehicleComponentInSlot(vehicleid, s);
			if(componentid)
			{
				format(project_str, sizeof project_str,
					"component;%i;%i\r\n", v, componentid
				);

				format(export_str, sizeof export_str,
					"AddVehicleComponent(g_Vehicle[%i], %i);\r\n", v, componentid
				);

				fwrite(project, project_str);
				fwrite(export, export_str);
			}
		}

		new paintjobid = GetVehiclePaintjob(vehicleid);
		if(paintjobid != 3)
		{
			format(project_str, sizeof project_str,
				"paintjob;%i;%i\r\n", v, paintjobid
			);

			format(export_str, sizeof export_str,
				"ChangeVehiclePaintjob(g_Vehicle[%i], %i);\r\n", v, paintjobid
			);

			fwrite(project, project_str);
			fwrite(export, export_str);
		}
	}

	// pickups
	for(new p; p < valid_pickups; p ++)
	{
		new pickupid = slot_pickupid[p],
			modelid = GetPickupModel(pickupid),
			Float:x,
			Float:y,
			Float:z,
			project_str[100],
			export_str[150];

		GetPickupPos(pickupid, x, y, z);

		format(project_str, sizeof project_str,
			"pickup;%i;%.4f;%.4f;%.4f\r\n", modelid, x, y, z
		);
		
		format(export_str, sizeof export_str,
			"g_Pickup[%i] = CreatePickup(%i, 1, %.4f, %.4f, %.4f); //%s\r\n", p, modelid, x, y, z, GetObjectModelName(modelid)
		);

		fwrite(project, project_str);
		fwrite(export, export_str);
	}

	// Objects attached to other objects & vehicles
	for(new o; o < valid_objects; o ++)
	{
		new objectid = slot_objectid[o],
			attach_objectid = GetObjectAttachedToObject(objectid),
	        attach_vehicleid = GetObjectAttachedToVehicle(objectid),
			project_str[150],
			export_str[200];

		if(attach_objectid != INVALID_OBJECT_ID)
		{
			new o_a_o = objectid_slot[attach_objectid - 1],
				Float:x,
				Float:y,
				Float:z,
				Float:rx,
				Float:ry,
				Float:rz;

			GetObjectAttachOffset(objectid, x, y, z, rx, ry, rz);

			format(project_str, sizeof project_str,
				"attach_object;%i;%i;%.4f;%.4f;%.4f;%.4f;%.4f;%.4f\r\n",
				o, o_a_o, x, y, z, rx, ry, rz
			);

			format(export_str, sizeof export_str,
				"AttachObjectToObject(g_Object[%i], g_Object[%i], %.4f, %.4f, %.4f, %.4f, %.4f, %.4f);\r\n",
				o, o_a_o, x, y, z, rx, ry, rz
			);

			fwrite(project, project_str);
			fwrite(export, export_str);
		}
		else if(attach_vehicleid != INVALID_VEHICLE_ID)
		{
			new	o_a_v = vehicleid_slot[attach_vehicleid - 1],
				Float:x,
				Float:y,
				Float:z,
				Float:rx,
				Float:ry,
				Float:rz;

			GetObjectAttachOffset(objectid, x, y, z, rx, ry, rz);

			format(project_str, sizeof project_str,
				"attach_vehicle;%i;%i;%.4f;%.4f;%.4f;%.4f;%.4f;%.4f\r\n",
				o, o_a_v, x, y, z, rx, ry, rz
			);

			format(export_str, sizeof export_str,
				"AttachObjectToVehicle(g_Object[%i], g_Vehicle[%i], %.4f, %.4f, %.4f, %.4f, %.4f, %.4f);\r\n",
				o, o_a_v, x, y, z, rx, ry, rz
			);

			fwrite(project, project_str);
			fwrite(export, export_str);
		}
	}

	// attached player objects
	for(new playerid; playerid < MAX_PLAYERS; playerid ++)
	{
		if(!IsPlayerConnected(playerid))
		    continue;

		new name[MAX_PLAYER_NAME + 1];
		GetPlayerName(playerid, name, sizeof name);

		for(new index; index < MAX_ATTACHED_INDEX; index ++)
		{
			if(!IsPlayerAttachedObjectSlotUsed(playerid, index))
			    continue;

			new modelid = GetPlayerAttachedObjectModel(playerid, index),
			    boneid = GetPlayerAttachedObjectBone(playerid, index),
			    Float:x,
			    Float:y,
			    Float:z,
			    Float:rx,
			    Float:ry,
			    Float:rz,
			    Float:sx,
			    Float:sy,
			    Float:sz,
			    color[2],
				project_str[150],
				export_str[300];

			GetPlayerAttachedObjectOffset	( playerid, index, x, y, z );
			GetPlayerAttachedObjectRot		( playerid, index, rx, ry, rz );
			GetPlayerAttachedObjectScale	( playerid, index, sx, sy, sz );
			GetPlayerAttachedObjectColor	( playerid, index, color[0], color[1] );

			format(project_str, sizeof project_str,
				"attach_player;%s;%i;%i;%.4f;%.4f;%.4f;%.4f;%.4f;%.4f;%.4f;%.4f;%.4f;%i;%i\r\n",
				name, modelid, boneid, x, y, z, rx, ry, rz, sx, sy, sz, color[0], color[1]
			);

			format(export_str, sizeof export_str,
				"SetPlayerAttachedObject(playerid, %i, %i, %i, %.4f, %.4f, %.4f, %.4f, %.4f, %.4f, %.4f, %.4f, %.4f, 0x%08x, 0x%08x); // %s attached to the %s of %s\r\n",
				index, modelid, boneid, x, y, z, rx, ry, rz, sx, sy, sz, color[0], color[1], GetObjectModelName(modelid), GetBoneName(boneid), name
			);

			fwrite(project, project_str);
			fwrite(export, export_str);
		}
	}
	fclose(project);
	fclose(export);
	return 1;
}
