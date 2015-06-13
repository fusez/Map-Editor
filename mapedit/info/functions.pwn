CreateInfoTextdraws()
{
    g_InfoBackgroundTD =
    TextDrawCreate          (320.0, 69.0, "_");
    TextDrawAlignment       (g_InfoBackgroundTD, 2);
    TextDrawLetterSize      (g_InfoBackgroundTD, 0.0, 33.3);
    TextDrawUseBox          (g_InfoBackgroundTD, 1);
    TextDrawBoxColor        (g_InfoBackgroundTD, 150);
    TextDrawTextSize        (g_InfoBackgroundTD, 0.0, 350.0);

    g_InfoTitleTD =
    TextDrawCreate          (150.0, 53.0, "Map Editor Information");
    TextDrawBackgroundColor (g_InfoTitleTD, 255);
    TextDrawFont            (g_InfoTitleTD, 0);
    TextDrawLetterSize      (g_InfoTitleTD, 0.73, 2.5);
    TextDrawColor           (g_InfoTitleTD, -1);
    TextDrawSetOutline      (g_InfoTitleTD, 1);
    TextDrawSetProportional (g_InfoTitleTD, 1);

    g_InfoCloseTD =
    TextDrawCreate          (482.0, 68.0, "LD_BEAT:cross");
    TextDrawFont            (g_InfoCloseTD, 4);
    TextDrawColor           (g_InfoCloseTD, -1);
    TextDrawUseBox          (g_InfoCloseTD, 1);
    TextDrawTextSize        (g_InfoCloseTD, 14.0, 14.0);
    TextDrawSetSelectable   (g_InfoCloseTD, 1);

    g_InfoContentTD =
    TextDrawCreate          (320.0, 82.0, "Information");
    TextDrawAlignment       (g_InfoContentTD, 2);
    TextDrawBackgroundColor (g_InfoContentTD, 255);
    TextDrawFont            (g_InfoContentTD, 1);
    TextDrawLetterSize      (g_InfoContentTD, 0.25, 1.2);
    TextDrawColor           (g_InfoContentTD, -1);
    TextDrawSetOutline      (g_InfoContentTD, 0);
    TextDrawSetProportional (g_InfoContentTD, 1);
    TextDrawSetShadow       (g_InfoContentTD, 1);

    for(new r; r < MAX_INFO_KEYSTROKES; r ++)
    {
        g_InfoKeysTD[r][0] =
        TextDrawCreate       (318.0, 210.0 + (r * 11.0), "<this key>");
        TextDrawAlignment    (g_InfoKeysTD[r][0], 3);

        g_InfoKeysTD[r][1] =
        TextDrawCreate        (322.0, 210.0 + (r * 11.0), "<does this>");
        TextDrawAlignment     (g_InfoKeysTD[r][1], 1);

        for(new c; c < 2; c ++)
        {
            TextDrawBackgroundColor (g_InfoKeysTD[r][c], 255);
            TextDrawFont            (g_InfoKeysTD[r][c], 2);
            TextDrawLetterSize      (g_InfoKeysTD[r][c], 0.25, 1.2);
            TextDrawColor           (g_InfoKeysTD[r][c], -1);
            TextDrawSetOutline      (g_InfoKeysTD[r][c], 0);
            TextDrawSetProportional (g_InfoKeysTD[r][c], 1);
            TextDrawSetShadow       (g_InfoKeysTD[r][c], 1);
        }

        switch(r)
        {
            case 0:
            {
                TextDrawSetString(g_InfoKeysTD[r][0], "~r~~k~~CONVERSATION_YES~ / ~k~~PED_DUCK~");
                TextDrawSetString(g_InfoKeysTD[r][1], "~y~toggle (mouse mode)");
            }
            case 1:
            {
                TextDrawSetString(g_InfoKeysTD[r][0], "~r~ESC");
                TextDrawSetString(g_InfoKeysTD[r][1], "~y~untoggle (mouse mode)");
            }
            case 2:
            {
                TextDrawSetString(g_InfoKeysTD[r][0], "~r~~k~~PED_SPRINT~ + ~k~~VEHICLE_TURRETLEFT~ / ~k~~VEHICLE_TURRETRIGHT~");
                TextDrawSetString(g_InfoKeysTD[r][1], "~y~set mode (offset edit)");
            }
            case 3:
            {
                TextDrawSetString(g_InfoKeysTD[r][0], "~r~~k~~VEHICLE_TURRETLEFT~ / ~k~~VEHICLE_TURRETRIGHT~");
                TextDrawSetString(g_InfoKeysTD[r][1], "~y~move object (offset edit)");
            }
            case 4:
            {
                TextDrawSetString(g_InfoKeysTD[r][0], "~r~~k~~SNEAK_ABOUT~");
                TextDrawSetString(g_InfoKeysTD[r][1], "~y~move slower (offset edit)");
            }
            case 5:
            {
                TextDrawSetString(g_InfoKeysTD[r][0], "~r~~k~~VEHICLE_ENTER_EXIT~");
                TextDrawSetString(g_InfoKeysTD[r][1], "~y~untoggle (offset edit)");
            }
            case 6:
            {
                TextDrawSetString(g_InfoKeysTD[r][0], "~r~~k~~PED_SPRINT~");
                TextDrawSetString(g_InfoKeysTD[r][1], "~y~look around (object edit)");
            }
            case 7:
            {
                TextDrawSetString(g_InfoKeysTD[r][0], "~r~ESC");
                TextDrawSetString(g_InfoKeysTD[r][1], "~y~untoggle (object edit)");
            }
            case 8:
            {
                TextDrawSetString(g_InfoKeysTD[r][0], "~r~~k~~GO_FORWARD~");
                TextDrawSetString(g_InfoKeysTD[r][1], "~y~move forward (camera mode)");
            }
            case 9:
            {
                TextDrawSetString(g_InfoKeysTD[r][0], "~r~~k~~GO_BACK~");
                TextDrawSetString(g_InfoKeysTD[r][1], "~y~move back (camera mode)");
            }
            case 10:
            {
                TextDrawSetString(g_InfoKeysTD[r][0], "~r~~k~~GO_LEFT~");
                TextDrawSetString(g_InfoKeysTD[r][1], "~y~move left (camera mode)");
            }
            case 11:
            {
                TextDrawSetString(g_InfoKeysTD[r][0], "~r~~k~~GO_RIGHT~");
                TextDrawSetString(g_InfoKeysTD[r][1], "~y~move right (camera mode)");
            }
            case 12:
            {
                TextDrawSetString(g_InfoKeysTD[r][0], "~r~~k~~SNEAK_ABOUT~");
                TextDrawSetString(g_InfoKeysTD[r][1], "~y~move slower (camera mode)");
            }
            case 13:
            {
                TextDrawSetString(g_InfoKeysTD[r][0], "~r~~k~~PED_JUMPING~");
                TextDrawSetString(g_InfoKeysTD[r][1], "~y~move faster (camera mode)");
            }
        }
    }

    static info[1024];
	info = "";

    strcat(info, "~y~What is this?~w~~n~");
    strcat(info, "This is a script designed for creating maps ingame; a map editor!~n~");
    strcat(info, "~n~~y~What can i do with this mapeditor?~w~~n~");
    strcat(info, "Create & modify vehicles, objects, pickups, and player attachments~n~");
    strcat(info, "Attach objects to other objects & vehicles~n~");
    strcat(info, "Apply textures & text to objects~n~");
    strcat(info, "Apply components & paintjobs to vehicles easily~n~");
    strcat(info, "Apply colors to objects, vehicles, and player attachments~n~");
    strcat(info, "Move your camera around in camera mode~n~");
    strcat(info, "Save, load, and clear the map~n~");

    TextDrawSetString(g_InfoContentTD, info);

    return 1;
}

DestroyInfoTextdraws()
{
    TextDrawDestroy(g_InfoBackgroundTD);
    TextDrawDestroy(g_InfoTitleTD);
    TextDrawDestroy(g_InfoCloseTD);
    TextDrawDestroy(g_InfoContentTD);

    for(new r; r < MAX_INFO_KEYSTROKES; r ++)
    {
        for(new c; c < 2; c ++)
            TextDrawDestroy(g_InfoKeysTD[r][c]);
    }

    return 1;
}

ShowPlayerInfoTextdraws(playerid)
{
    TextDrawShowForPlayer(playerid, g_InfoBackgroundTD);
    TextDrawShowForPlayer(playerid, g_InfoTitleTD);
    TextDrawShowForPlayer(playerid, g_InfoCloseTD);
    TextDrawShowForPlayer(playerid, g_InfoContentTD);

    for(new r; r < MAX_INFO_KEYSTROKES; r ++)
    {
        for(new c; c < 2; c ++)
            TextDrawShowForPlayer(playerid, g_InfoKeysTD[r][c]);
    }

    return 1;
}

HidePlayerInfoTextdraws(playerid)
{
    TextDrawHideForPlayer(playerid, g_InfoBackgroundTD);
    TextDrawHideForPlayer(playerid, g_InfoTitleTD);
    TextDrawHideForPlayer(playerid, g_InfoCloseTD);
    TextDrawHideForPlayer(playerid, g_InfoContentTD);

    for(new r; r < MAX_INFO_KEYSTROKES; r ++)
    {
        for(new c; c < 2; c ++)
            TextDrawHideForPlayer(playerid, g_InfoKeysTD[r][c]);
    }

    return 1;
}
