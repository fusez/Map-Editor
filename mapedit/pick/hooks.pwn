/******************************************************************************/

stock p_CreatePickup(model, type, Float:x, Float:y, Float:z, virtualworld = 0)
{
    new pickupid = CreatePickup(model, type, x, y, z, virtualworld);
    if(pickupid != INVALID_PICKUP_ID)
    {
        g_IsPickupValid    {pickupid} = true;
        g_PickupModel    [pickupid] = model;
        g_PickupPos        [pickupid][0] = x;
        g_PickupPos        [pickupid][1] = y;
        g_PickupPos        [pickupid][2] = z;
    }
    return pickupid;
}
#if defined _ALS_CreatePickup
    #undef CreatePickup
#else
    #define _ALS_CreatePickup
#endif
#define CreatePickup p_CreatePickup

/******************************************************************************/

stock p_DestroyPickup(pickupid)
{
    if(pickupid >= 0 && pickupid < MAX_PICKUPS)
    {
        g_IsPickupValid{pickupid} = false;
        g_PickupModel[pickupid] = 0;

        for(new i; i < 3; i ++)
            g_PickupPos[pickupid][i] = 0.0;

        for(new playerid; playerid < MAX_PLAYERS; playerid ++)
        {
            if(!IsPlayerConnected(playerid))
                continue;

            if(g_pEditPickup[playerid] == pickupid)
            {
                new mbrowserid = GetPlayerMBrowser(playerid),
                    dialogid = GetPlayerDialog(playerid);

                if(
                    mbrowserid == g_PickupSelectBrowser ||
                    mbrowserid == g_PickupCreateBrowser
                ){
                    HideMBrowser(playerid);
                }

                if(
                    dialogid == g_PickupMainDialog ||
                    dialogid == g_PickupEditDialog ||
                    dialogid == g_PickupXDialog ||
                    dialogid == g_PickupYDialog ||
                    dialogid == g_PickupZDialog
                ){
                    HidePlayerDialog(playerid);
                }

                g_pEditPickup[playerid] = INVALID_PICKUP_ID;
            }

            if(g_pSelectPickupChoice[playerid] == pickupid)
            {
                if(GetPlayerMBrowser(playerid) == g_PickupSelectBrowser)
                    HideMBrowserModel(playerid);

                g_pSelectPickupChoice[playerid] = INVALID_PICKUP_ID;
            }

            for(new listitem; listitem < MAX_MBROWSER_PAGESIZE; listitem ++)
            {
                if(g_pSelectPickupResult[playerid][listitem] == pickupid)
                {
                    if(GetPlayerMBrowser(playerid) == g_PickupSelectBrowser)
                        HideMBrowserListItem(playerid, listitem);

                    g_pSelectPickupResult[playerid][listitem] = INVALID_PICKUP_ID;
                }
            }
        }
    }
    DestroyPickup(pickupid);
}
#if defined _ALS_DestroyPickup
    #undef DestroyPickup
#else
    #define _ALS_DestroyPickup
#endif
#define DestroyPickup p_DestroyPickup

/******************************************************************************/
