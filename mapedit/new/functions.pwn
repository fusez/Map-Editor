ClearMap()
{
    for(new objectid = 1; objectid <= MAX_OBJECTS; objectid ++)
        DestroyObject(objectid);

    for(new vehicleid = 1; vehicleid <= MAX_VEHICLES; vehicleid ++)
        DestroyVehicle(vehicleid);

    for(new pickupid; pickupid < MAX_PICKUPS; pickupid ++)
        DestroyPickup(pickupid);

    for(new playerid, max_playerid = GetMaxPlayers(); playerid < max_playerid; playerid ++)
    {
        if(!IsPlayerConnected(playerid))
            continue;

        for(new index; index < MAX_ATTACHED_INDEX; index ++)
            RemovePlayerAttachedObject(playerid, index);
    }
}
