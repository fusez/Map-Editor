ShowPlayerOffsetEditorToggle(playerid)
{
    if(g_pOffsetEditToggled{playerid})
        GameTextForPlayer(playerid, "~w~offset editor ~g~toggled", 4000, 4);
    else
        GameTextForPlayer(playerid, "~w~offset editor ~r~untoggled", 4000, 4);
}

ShowPlayerOffsetEditorMode(playerid)
{
    switch(g_pOffsetEditMode{playerid})
    {
        case OFFSET_MODE_X:
            GameTextForPlayer(playerid, "~r~editing x offset", 2000, 4);
        case OFFSET_MODE_Y:
            GameTextForPlayer(playerid, "~r~editing y offset", 2000, 4);
        case OFFSET_MODE_Z:
            GameTextForPlayer(playerid, "~r~editing z offset", 2000, 4);
        case OFFSET_MODE_RX:
            GameTextForPlayer(playerid, "~r~editing x rotation", 2000, 4);
        case OFFSET_MODE_RY:
            GameTextForPlayer(playerid, "~r~editing y rotation", 2000, 4);
        case OFFSET_MODE_RZ:
            GameTextForPlayer(playerid, "~r~editing z rotation", 2000, 4);
    }
}

ShowPlayerOffsetEditorUpdate(playerid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
    new string[30];
    switch(g_pOffsetEditMode{playerid})
    {
        case OFFSET_MODE_X:
            format(string, sizeof string, "~r~x offset: ~w~%.4f", x);
        case OFFSET_MODE_Y:
            format(string, sizeof string, "~r~y offset: ~w~%.4f", y);
        case OFFSET_MODE_Z:
            format(string, sizeof string, "~r~z offset: ~w~%.4f", z);
        case OFFSET_MODE_RX:
            format(string, sizeof string, "~r~x rotation: ~w~%.4f", rx);
        case OFFSET_MODE_RY:
            format(string, sizeof string, "~r~y rotation: ~w~%.4f", ry);
        case OFFSET_MODE_RZ:
            format(string, sizeof string, "~r~z rotation: ~w~%.4f", rz);
        default:
            return 0;
    }

    GameTextForPlayer(playerid, string, 1000, 4);
    return 1;
}

TogglePlayerOffsetEditor(playerid, bool:toggle)
{
    if(toggle == g_pOffsetEditToggled{playerid})
        return 0;

    g_pOffsetEditToggled    {playerid} = toggle;
    g_pOffsetEditMode        {playerid} = OFFSET_MODE_NONE;
    g_pOffsetEditSpeed        [playerid] = 0.0;

    if(toggle)
        g_pOffsetEditTimer[playerid] = SetTimerEx("OnPlayerOffsetEditUpdate", 100, true, "i", playerid);
    else
    {
        KillTimer(g_pOffsetEditTimer[playerid]);

        if(g_pEditObject[playerid] != INVALID_OBJECT_ID)
        {
            SelectTextDraw(playerid, 0xFF0000FF);
            ShowPlayerObjectDialog(playerid, g_ObjectEditDialog);
        }
    }

    ShowPlayerOffsetEditorToggle(playerid);
    return 1;
}
