GetBoneName(boneid)
{
    new output[16];

    switch(boneid)
    {
        case 1:
            strunpack(output, !"Spine");
        case 2:
            strunpack(output, !"Head");
        case 3:
            strunpack(output, !"Left Upper Arm");
        case 4:
            strunpack(output, !"Right Upper Arm");
        case 5:
            strunpack(output, !"Left Hand");
        case 6:
            strunpack(output, !"Right Hand");
        case 7:
            strunpack(output, !"Left Thigh");
        case 8:
            strunpack(output, !"Right Thigh");
        case 9:
            strunpack(output, !"Left Foot");
        case 10:
            strunpack(output, !"Right Foot");
        case 11:
            strunpack(output, !"Right Calf");
        case 12:
            strunpack(output, !"Left Calf");
        case 13:
            strunpack(output, !"Left Forearm");
        case 14:
            strunpack(output, !"Right Forearm");
        case 15:
            strunpack(output, !"Left Clavicle");
        case 16:
            strunpack(output, !"Right Clavicle");
        case 17:
            strunpack(output, !"Neck");
        case 18:
            strunpack(output, !"Jaw");
        default:
            strunpack(output, !"Unknown Bone");
    }
    return output;
}

stock ShowPlayerAttachDialog(playerid, dialogid)
{
    if(dialogid == g_AttachIndexDialog)
    {
        new info[1000];
        for(new index; index < MAX_ATTACHED_INDEX; index ++)
        {
            if(IsPlayerAttachedObjectSlotUsed(playerid, index))
            {
                new
                    modelid = GetPlayerAttachedObjectModel(playerid, index),
                    boneid = GetPlayerAttachedObjectBone(playerid, index)
                ;

                strcat(info,
                    sprintf("%s attached to %s\n", GetObjectModelName(modelid), GetBoneName(boneid))
                );
            }
            else
                strcat(info, "<empty>\n");
        }

        ShowPlayerDialog(
            playerid,
            dialogid,
            DIALOG_STYLE_LIST,
            "Attached Objects",
            info,
            "Select",
            "Close"
        );

        return 1;
    }
    else if(dialogid == g_AttachEditDialog)
    {
        new
            index = g_pEditAttachIndex{playerid},
            modelid = GetPlayerAttachedObjectModel(playerid, index),
            boneid = GetPlayerAttachedObjectBone(playerid, index),
            Float: o    [3],
            Float: r    [3],
            Float: s    [3],
            attach_argb [2],
            info        [500]
        ;

        GetPlayerAttachedObjectOffset   ( playerid, index, o[0], o[1], o[2] );
        GetPlayerAttachedObjectRot      ( playerid, index, r[0], r[1], r[2] );
        GetPlayerAttachedObjectScale    ( playerid, index, s[0], s[1], s[2] );
        GetPlayerAttachedObjectColor    ( playerid, index, attach_argb[0], attach_argb[1] );

        strcat ( info, "Remove\n" );
        strcat ( info, "Move\n" );
        strcat ( info, sprintf("Model:     \t\t%s\n", GetObjectModelName(modelid)) );
        strcat ( info, sprintf("Bone:      \t\t%s\n", GetBoneName(boneid)) );
        strcat ( info, sprintf("X Offset:  \t\t%.4f\n", o[0]) );
        strcat ( info, sprintf("Y Offset:  \t\t%.4f\n", o[1]) );
        strcat ( info, sprintf("Z Offset:  \t\t%.4f\n", o[2]) );
        strcat ( info, sprintf("X Rotation:\t\t%.4f\n", r[0]) );
        strcat ( info, sprintf("Y Rotation:\t\t%.4f\n", r[1]) );
        strcat ( info, sprintf("Z Rotation:\t\t%.4f\n", r[2]) );
        strcat ( info, sprintf("X Scale:   \t\t%.4f\n", s[0]) );
        strcat ( info, sprintf("Y Scale:   \t\t%.4f\n", s[1]) );
        strcat ( info, sprintf("Z Scale:   \t\t%.4f\n", s[2]) );
        for(new i; i < 2; i ++)
            strcat ( info, sprintf("Set Color %i\n", i + 1) );

        ShowPlayerDialog(
            playerid,
            dialogid,
            DIALOG_STYLE_LIST,
            "Attached Object Settings",
            info,
            "Continue",
            "Back"
        );

        return 1;
    }
    else if(dialogid == g_AttachBoneDialog)
    {
        new info[200];
        for(new boneid = 1; boneid < MAX_ATTACHED_BONE; boneid ++)
            strcat( info, sprintf("%s\n", GetBoneName(boneid)) );

        ShowPlayerDialog(
            playerid,
            dialogid,
            DIALOG_STYLE_LIST,
            "Attached Object Bone",
            info,
            "Select",
            "Back"
        );

        return 1;
    }
    else if(
        dialogid == g_AttachXDialog ||
        dialogid == g_AttachYDialog ||
        dialogid == g_AttachZDialog ||
        dialogid == g_AttachRXDialog ||
        dialogid == g_AttachRYDialog ||
        dialogid == g_AttachRZDialog ||
        dialogid == g_AttachSXDialog ||
        dialogid == g_AttachSYDialog ||
        dialogid == g_AttachSZDialog
    ){
        new    index = g_pEditAttachIndex{playerid},
            Float: o    [3],
            Float: r    [3],
            Float: s    [3],
            caption        [27],
            info        [22];

        GetPlayerAttachedObjectOffset    ( playerid, index, o[0], o[1], o[2] );
        GetPlayerAttachedObjectRot        ( playerid, index, r[0], r[1], r[2] );
        GetPlayerAttachedObjectScale    ( playerid, index, s[0], s[1], s[2] );

        if(dialogid == g_AttachXDialog)
        {
            caption = "Attached Object X Offset";
            format(info, sizeof info, "X Offset: %.4f", o[0]);
        }
        else if(dialogid == g_AttachYDialog)
        {
            caption = "Attached Object Y Offset";
            format(info, sizeof info, "Y Offset: %.4f", o[1]);
        }
        else if(dialogid == g_AttachZDialog)
        {
            caption = "Attached Object Z Offset";
            format(info, sizeof info, "Z Offset: %.4f", o[2]);
        }
        else if(dialogid == g_AttachRXDialog)
        {
            caption = "Attached Object X Rotation";
            format(info, sizeof info, "X Rotation: %.4f", r[0]);
        }
        else if(dialogid == g_AttachRYDialog)
        {
            caption = "Attached Object Y Rotation";
            format(info, sizeof info, "Y Rotation: %.4f", r[1]);
        }
        else if(dialogid == g_AttachRZDialog)
        {
            caption = "Attached Object Z Rotation";
            format(info, sizeof info, "Z Rotation: %.4f", r[2]);
        }
        else if(dialogid == g_AttachSXDialog)
        {
            caption = "Attached Object X Scale";
            format(info, sizeof info, "X Scale: %.4f", s[0]);
        }
        else if(dialogid == g_AttachSYDialog)
        {
            caption = "Attached Object Y Scale";
            format(info, sizeof info, "Y Scale: %.4f", s[1]);
        }
        else if(dialogid == g_AttachSZDialog)
        {
            caption = "Attached Object Z Scale";
            format(info, sizeof info, "Z Scale: %.4f", s[2]);
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
