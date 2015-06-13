ShowPlayerVehicleDialog(playerid, dialogid)
{
    if(dialogid == g_VehicleMainDialog)
    {
        ShowPlayerDialog(
            playerid,
            dialogid,
            DIALOG_STYLE_LIST,
            "Vehicle",
            "Select Vehicle\nCreate Vehicle",
            "Choose",
            "Close"
        );
        return 1;
    }
    else if(dialogid == g_VehicleEditDialog)
    {
        new
            vehicleid = g_pEditVehicle[playerid],
            modelid = GetVehicleModel(vehicleid),
            modshopid = GetVehicleModelTuningShop(modelid),
            attach_objectid = g_pSelectedAttachObject[playerid],
            Float:x,
            Float:y,
            Float:z,
            Float:r,
            info[400]
        ;

        GetVehiclePos(vehicleid, x, y, z);
        GetVehicleZAngle(vehicleid, r);

        strcat ( info, "Remove\n" );
        strcat ( info, "Duplicate\n" );
        strcat ( info, "Move\n" );
        strcat ( info, sprintf("X Position:\t\t%.4f\n", x) );
        strcat ( info, sprintf("Y Position:\t\t%.4f\n", y) );
        strcat ( info, sprintf("Z Position:\t\t%.4f\n", z) );
        strcat ( info, sprintf("Rotation:  \t\t%.4f\n", r) );
        strcat ( info, "Set Color 1\n" );
        strcat ( info, "Set Color 2\n" );
        strcat ( info, "Repair Vehicle\n" );

        switch(modshopid)
        {
            case TUNINGSHOP_TRANSFENDER:
                strcat ( info, "Tune Vehicle @ Transfender\n" );
            case TUNINGSHOP_LOCOLOW:
                strcat ( info, "Tune Vehicle @ Loco Low Co\n" );
            case TUNINGSHOP_WHEELARCH:
                strcat ( info, "Tune Vehicle @ Wheel Arch Angels\n" );
            default:
                strcat ( info, "Tune Vehicle <Disabled>\n" );
        }

        if(attach_objectid == INVALID_OBJECT_ID)
            strcat ( info, "Attach Selected Object <None Selected>\n" );
        else
        {
            new attach_modelid = GetObjectModel(attach_objectid);

            strcat(info,
                sprintf("Attach Selected Object: %s\n", GetObjectModelName(attach_modelid))
            );
        }

        ShowPlayerDialog(
            playerid,
            dialogid,
            DIALOG_STYLE_LIST,
            "Edit Vehicle",
            info,
            "Continue",
            "Back"
        );
        return 1;
    }
    else if(
        dialogid == g_VehicleXDialog ||
        dialogid == g_VehicleYDialog ||
        dialogid == g_VehicleZDialog ||
        dialogid == g_VehicleRDialog
    ){

        new
            vehicleid = g_pEditVehicle[playerid],
            Float:x,
            Float:y,
            Float:z,
            Float:r,
            caption[19],
            info[22]
        ;

        GetVehiclePos(vehicleid, x, y, z);
        GetVehicleZAngle(vehicleid, r);

        if(dialogid == g_VehicleXDialog)
        {
            caption = "Vehicle X Position";
            format(info, sizeof info, "X Position: %.4f", x);
        }
        else if(dialogid == g_VehicleYDialog)
        {
            caption = "Vehicle Y Position";
            format(info, sizeof info, "Y Position: %.4f", y);
        }
        else if(dialogid == g_VehicleZDialog)
        {
            caption = "Vehicle Z Position";
            format(info, sizeof info, "Z Position: %.4f", z);
        }
        else if(dialogid == g_VehicleRDialog)
        {
            caption = "Vehicle Rotation";
            format(info, sizeof info, "Rotation: %.4f", r);
        }

        ShowPlayerDialog(
            playerid,
            dialogid,
            DIALOG_STYLE_INPUT,
            caption,
            info,
            "Enter",
            "Back"
        );
        return 1;
    }
    return 0;
}

DuplicateVehicle(old_vehicleid)
{
    if(old_vehicleid == INVALID_VEHICLE_ID)
        return INVALID_VEHICLE_ID;

    new
        modelid,
        Float:x,
        Float:y,
        Float:z,
        Float:r,
        color[2],
        new_vehicleid
    ;

    modelid = GetVehicleModel(old_vehicleid);
    GetVehiclePos(old_vehicleid, x, y, z);
    GetVehicleZAngle(old_vehicleid, r);
    GetVehicleColor(old_vehicleid, color[0], color[1]);

    new_vehicleid = CreateVehicle(modelid, x, y, z, r, color[0], color[1], -1);
    if(new_vehicleid == INVALID_VEHICLE_ID)
        return INVALID_VEHICLE_ID;

    new paintjobid = GetVehiclePaintjob(old_vehicleid);
    if(paintjobid != 3)
        ChangeVehiclePaintjob(new_vehicleid, paintjobid);

    for(new slot; slot < 14; slot ++)
    {
        new componentid = GetVehicleComponentInSlot(old_vehicleid, slot);
        if(componentid != 0)
            AddVehicleComponent(new_vehicleid, componentid);
    }

    for(new objectid = 1; objectid <= MAX_OBJECTS; objectid ++)
    {
        if(GetObjectAttachedToVehicle(objectid) == old_vehicleid)
        {
            new attach_objectid = DuplicateObject(objectid, false);
            if(attach_objectid == INVALID_OBJECT_ID)
                continue;

            new
                Float:ox,
                Float:oy,
                Float:oz,
                Float:orx,
                Float:ory,
                Float:orz
            ;

            GetObjectAttachOffset(attach_objectid, ox, oy, oz, orx, ory, orz);
            AttachObjectToVehicle(attach_objectid, new_vehicleid, ox, oy, oz, orx, ory, orz);
        }
    }
    return new_vehicleid;
}
