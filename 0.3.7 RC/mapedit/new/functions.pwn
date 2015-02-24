ClearMap(bool:objects, bool:vehicles, bool:pickups, bool:attached)
{
	if(objects)
	{
		for(new objectid = 1; objectid <= MAX_OBJECTS; objectid ++)
			DestroyObject(objectid);
	}

	if(vehicles)
	{
		for(new vehicleid = 1; vehicleid <= MAX_VEHICLES; vehicleid ++)
			DestroyVehicle(vehicleid);
	}

	if(pickups)
	{
		for(new pickupid; pickupid < MAX_PICKUPS; pickupid ++)
			DestroyPickup(pickupid);
	}

	if(attached)
	{
		for(new playerid; playerid < MAX_PLAYERS; playerid ++)
		{
			if(!IsPlayerConnected(playerid))
		    	continue;

			for(new index; index < MAX_ATTACHED_INDEX; index ++)
			    RemovePlayerAttachedObject(playerid, index);
		}
	}
}
