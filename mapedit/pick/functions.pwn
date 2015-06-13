stock GetPickupPos(pickupid, &Float:x, &Float:y, &Float:z)
{
    x = g_PickupPos[pickupid][0];
    y = g_PickupPos[pickupid][1];
    z = g_PickupPos[pickupid][2];
}

stock ShowPlayerPickupDialog(playerid, dialogid)
{
    if(dialogid == g_PickupMainDialog)
    {
        ShowPlayerDialog(
            playerid,
            dialogid,
            DIALOG_STYLE_LIST,
            "Pickup",
            "Select Pickup\nCreate Pickup",
            "Choose",
            "Close"
        );
        return 1;
    }
    else if(dialogid == g_PickupEditDialog)
    {
        new
            pickupid = g_pEditPickup[playerid],
            Float:x,
            Float:y,
            Float:z,
            info[100]
        ;

        GetPickupPos(pickupid, x, y, z);

        strcat(info, "Remove\n");
        strcat(info, "Duplicate\n");
        strcat(info, "Move\n");
        strcat(info, sprintf("X Position:\t\t%.4f\n", x) );
        strcat(info, sprintf("Y Position:\t\t%.4f\n", y) );
        strcat(info, sprintf("Z Position:\t\t%.4f\n", z) );

        ShowPlayerDialog(
            playerid,
            dialogid,
            DIALOG_STYLE_LIST,
            "Edit Pickup",
            info,
            "Choose",
            "Back"
        );
        return 1;
    }
    else if(
        dialogid == g_PickupXDialog ||
        dialogid == g_PickupYDialog ||
        dialogid == g_PickupZDialog
    ){
        new
            pickupid = g_pEditPickup[playerid],
            Float:x,
            Float:y,
            Float:z,
            caption[18],
            info[22]
        ;

        GetPickupPos(pickupid, x, y, z);

        if(dialogid == g_PickupXDialog)
        {
            caption = "Pickup X Position";
            format(info, sizeof info, "X Position: %.4f", x);
        }
        else if(dialogid == g_PickupYDialog)
        {
            caption = "Pickup Y Position";
            format(info, sizeof info, "Y Position: %.4f", y);
        }
        else if(dialogid == g_PickupZDialog)
        {
            caption = "Pickup Z Position";
            format(info, sizeof info, "Z Position: %.4f", z);
        }

        ShowPlayerDialog(
            playerid,
            dialogid,
            DIALOG_STYLE_INPUT,
            caption,
            info,
            "Set",
            "Back"
        );
        return 1;
    }
    return 0;
}
