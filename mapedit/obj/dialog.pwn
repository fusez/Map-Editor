ShowPlayerObjectDialog(playerid, dialogid)
{
    if(dialogid == g_ObjectMainDialog)
    {
        ShowPlayerDialog(
            playerid,
            dialogid,
            DIALOG_STYLE_LIST,
            "Object",
            "Select Object (List)\nSelect Object (3D Selection)\nCreate Object (List)",
            "Choose",
            "Close"
        );
        return 1;
    }
    else if(dialogid == g_ObjectEditDialog)
    {
        new
            objectid = g_pEditObject[playerid],
            select_attach_object = g_pSelectedAttachObject[playerid],
            attach_to_objectid = GetObjectAttachedToObject(objectid),
            attach_to_vehicleid = GetObjectAttachedToVehicle(objectid),
            Float: position    [3],
            Float: rotation    [3],
            info            [1000]
        ;

        strcat(info, "Remove\n");
        strcat(info, "Duplicate\n");
        strcat(info, "Move\n");

        strcat(info, "Select As Attachment\n");

        if(select_attach_object == INVALID_OBJECT_ID)
            strcat(info, "Attach Selected Object <None Selected>\n");
        else if(select_attach_object == objectid)
            strcat(info, "Attach Selected Object <Disabled>\n");
        else
        {
            new modelid = GetObjectModel(select_attach_object);

            strcat(info,
                sprintf("Attach Selected Object: %s\n", GetObjectModelName(modelid))
            );
        }

        if(attach_to_objectid != INVALID_OBJECT_ID)
        {
            new modelid = GetObjectModel(attach_to_objectid);

            strcat(info,
                sprintf("Unattach From Object: %s\n", GetObjectModelName(modelid))
            );
        }
        else if(attach_to_vehicleid != INVALID_VEHICLE_ID)
        {
            new modelid = GetVehicleModel(attach_to_vehicleid);

            strcat(info,
                sprintf("Unattach From Vehicle: %s\n", GetVehicleModelName(modelid))
            );
        }
        else
            strcat(info, "Unattach <Not Attached>\n");

        if(
            attach_to_objectid != INVALID_OBJECT_ID ||
            attach_to_vehicleid != INVALID_VEHICLE_ID
        ){
            GetObjectAttachOffset(
                objectid,
                position[0],
                position[1],
                position[2],
                rotation[0],
                rotation[1],
                rotation[2]
            );

            strcat(info, sprintf("X Offset: %.4f\n", position[0]) );
            strcat(info, sprintf("Y Offset: %.4f\n", position[1]) );
            strcat(info, sprintf("Z Offset: %.4f\n", position[2]) );
            strcat(info, sprintf("RX Offset: %.4f\n", rotation[0]) );
            strcat(info, sprintf("RY Offset: %.4f\n", rotation[1]) );
            strcat(info, sprintf("RZ Offset: %.4f\n", rotation[2]) );
        }
        else
        {
            GetObjectPos(objectid, position[0], position[1], position[2]);
            GetObjectRot(objectid, rotation[0], rotation[1], rotation[2]);

            strcat(info, sprintf("X Position: %.4f\n", position[0]) );
            strcat(info, sprintf("Y Position: %.4f\n", position[1]) );
            strcat(info, sprintf("Z Position: %.4f\n", position[2]) );
            strcat(info, sprintf("X Rotation: %.4f\n", rotation[0]) );
            strcat(info, sprintf("Y Rotation: %.4f\n", rotation[1]) );
            strcat(info, sprintf("Z Rotation: %.4f\n", rotation[2]) );
        }

        for(new index; index < MAX_OBJECT_INDEX; index ++)
        {
            if(IsObjectTextured(objectid, index))
            {
                new textureid = GetObjectTextureID(objectid, index);

                strcat(info,
                    sprintf("Index %02i Texture: %s\n", index, GetTextureName(textureid))
                );
            }
            else if(IsObjectText(objectid, index))
            {
                strcat(info,
                    sprintf("Index %02i Text: %s\n", index, GetObjectMaterialText(objectid, index))
                );
            }
            else
                strcat( info, sprintf("Index %02i: <Empty>\n", index) );
        }

        ShowPlayerDialog(
            playerid,
            dialogid,
            DIALOG_STYLE_LIST,
            "Edit Object",
            info,
            "Choose",
            "Back"
        );
        return 1;
    }

    else if(
        dialogid == g_ObjectXDialog ||
        dialogid == g_ObjectYDialog ||
        dialogid == g_ObjectZDialog ||
        dialogid == g_ObjectRXDialog ||
        dialogid == g_ObjectRYDialog ||
        dialogid == g_ObjectRZDialog
    ){
        new objectid = g_pEditObject[playerid],
            attach_to_objectid = GetObjectAttachedToObject(objectid),
            attach_to_vehicleid = GetObjectAttachedToVehicle(objectid),
            bool:is_attached = (attach_to_objectid == INVALID_OBJECT_ID && attach_to_vehicleid == INVALID_VEHICLE_ID) ? (false) : (true),
            Float: position    [3],
            Float: rotation    [3],
            caption            [18],
            info            [22];

        if(is_attached)
            GetObjectAttachOffset(objectid, position[0], position[1], position[2], rotation[0], rotation[1], rotation[2]);
        else
        {
            GetObjectPos(objectid, position[0], position[1], position[2]);
            GetObjectRot(objectid, rotation[0], rotation[1], rotation[2]);
        }

        if(dialogid == g_ObjectXDialog)
        {
            if(is_attached)
            {
                caption = "Object X Offset";
                format(info, sizeof info, "X Offset: %.4f", position[0]);
            }
            else
            {
                caption = "Object X Position";
                format(info, sizeof info, "X Position: %.4f", position[0]);
            }
        }
        else if(dialogid == g_ObjectYDialog)
        {
            if(is_attached)
            {
                caption = "Object Y Offset";
                format(info, sizeof info, "Y Offset: %.4f", position[1]);
            }
            else
            {
                caption = "Object Y Position";
                format(info, sizeof info, "Y Position: %.4f", position[1]);
            }
        }
        else if(dialogid == g_ObjectZDialog)
        {
            if(is_attached)
            {
                caption = "Object Z Offset";
                format(info, sizeof info, "Z Offset: %.4f", position[2]);
            }
            else
            {
                caption = "Object Z Position";
                format(info, sizeof info, "Z Position: %.4f", position[2]);
            }
        }
        else if(dialogid == g_ObjectRXDialog)
        {
            if(is_attached)
            {
                caption = "Object RX Offset";
                format(info, sizeof info, "RX Offset: %.4f", rotation[0]);
            }
            else
            {
                caption = "Object X Rotation";
                format(info, sizeof info, "X Rotation: %.4f", rotation[0]);
            }
        }
        else if(dialogid == g_ObjectRYDialog)
        {
            if(is_attached)
            {
                caption = "Object RY Offset";
                format(info, sizeof info, "RY Offset: %.4f", rotation[1]);
            }
            else
            {
                caption = "Object Y Rotation";
                format(info, sizeof info, "Y Rotation: %.4f", rotation[1]);
            }
        }
        else if(dialogid == g_ObjectRZDialog)
        {
            if(is_attached)
            {
                caption = "Object RZ Offset";
                format(info, sizeof info, "RZ Offset: %.4f", rotation[2]);
            }
            else
            {
                caption = "Object Z Rotation";
                format(info, sizeof info, "Z Rotation: %.4f", rotation[2]);
            }
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
    else if(dialogid == g_ObjectIndexDialog)
    {
        new objectid = g_pEditObject[playerid],
            index = g_pEditObjectIndex{playerid},
            info[500];

        if(IsObjectTextured(objectid, index))
        {
            new textureid = GetObjectTextureID(objectid, index);

            strcat(info,
                sprintf("Texture: %s\n", GetTextureName(textureid))
            );
        }
        else
            strcat( info, "Texture: <default>\n" );

        strcat ( info, "Set Texture Color\n" );

        if(IsObjectText(objectid, index))
            strcat(info, sprintf("Text: %s\n", GetObjectMaterialText(objectid, index)) );
        else
            strcat(info, "Text: <none>\n");

        if(IsObjectText(objectid, index))
        {
            new size = (GetObjectTextMaterialSize(objectid, index) / 10) - 1;
            strcat(info, sprintf("Material Size: %s\n", g_TextSizes[size]));
        }
        else
            strcat(info, "Material Size: <none>\n");

        if(IsObjectText(objectid, index))
            strcat(info, sprintf("Font: %s\n", GetObjectTextFont(objectid, index)) );
        else
            strcat(info, "Font: <none>\n");

        if(IsObjectText(objectid, index))
            strcat(info, sprintf("Font Size: %i\n", GetObjectTextFontSize(objectid, index)) );
        else
            strcat(info, "Font Size: <none>\n");

        if(IsObjectText(objectid, index))
            strcat(info, sprintf("Bold: %s\n", (IsObjectTextBold(objectid, index)) ? ("Yes") : ("No")) );
        else
            strcat(info, "Bold: <none>\n");

        if(IsObjectText(objectid, index))
        {
            new alignment = GetObjectTextAlignment(objectid, index);
            strcat(info, sprintf("Alignment: %s\n", g_TextAlignments[alignment]));
        }
        else
            strcat(info, "Alignment: <none>\n");

        if(IsObjectText(objectid, index))
            strcat(info, sprintf("Font Color: 0x%08x\n", GetObjectTextColor(objectid, index)) );
        else
            strcat(info, "Font Color: <none>\n");

        if(IsObjectText(objectid, index))
            strcat(info, sprintf("Background Color: 0x%08x\n", GetObjectTextBackColor(objectid, index)) );
        else
            strcat(info, "Background Color: <none>\n");

        strcat ( info, "Reset Texture\n" );
        strcat ( info, "Remove Text\n" );
        strcat ( info, "Reset Texture Color\n" );
        strcat ( info, "Remove Text Background\n" );

        ShowPlayerDialog(
            playerid,
            dialogid,
            DIALOG_STYLE_LIST,
            sprintf("Object Index %i", index),
            info,
            "Continue",
            "Back"
        );

        return 1;
    }
    else if(dialogid == g_ObjectTextStringDialog)
    {
        new objectid = g_pEditObject[playerid],
            index = g_pEditObjectIndex{playerid};

        ShowPlayerDialog(
            playerid,
            dialogid,
            DIALOG_STYLE_INPUT,
            "Set Text",
            sprintf("Current Text: %s", GetObjectMaterialText(objectid, index)),
            "Enter",
            "Back"
        );

        return 1;
    }
    else if(dialogid == g_ObjectTextMaterialSizeDialog)
    {
        new info[500];
        for(new i; i < g_MaxTextSizes; i ++)
            strcat( info, sprintf("%s\n", g_TextSizes[i]) );

        ShowPlayerDialog(
            playerid,
            dialogid,
            DIALOG_STYLE_LIST,
            "Set Material Size",
            info,
            "Select",
            "Back"
        );
        return 1;
    }
    else if(dialogid == g_ObjectTextFontDialog)
    {
        new info[500];
        for(new i; i < g_MaxFonts; i ++)
            strcat( info, sprintf("%s\n", g_Fonts[i]) );

        ShowPlayerDialog(
            playerid,
            dialogid,
            DIALOG_STYLE_LIST,
            "Set Font",
            info,
            "Select",
            "Back"
        );
        return 1;
    }
    else if(dialogid == g_ObjectTextFontSizeDialog)
    {
        new
            objectid = g_pEditObject[playerid],
            index = g_pEditObjectIndex{playerid}
        ;

        ShowPlayerDialog(
            playerid,
            dialogid,
            DIALOG_STYLE_INPUT,
            "Set Font Size",
            sprintf("Font Size: %i", GetObjectTextFontSize(objectid, index)),
            "Enter",
            "Back"
        );
        return 1;
    }
    else if(dialogid == g_ObjectTextAlignmentDialog)
    {
        new info[100];
        for(new i; i < g_MaxTextAlignments; i ++)
            strcat(info, sprintf("%s\n", g_TextAlignments[i]) );

        ShowPlayerDialog(
            playerid,
            dialogid,
            DIALOG_STYLE_LIST,
            "Set Alignment",
            info,
            "Select",
            "Back"
        );
        return 1;
    }
    return 0;
}
