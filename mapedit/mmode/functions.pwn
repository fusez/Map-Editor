CreatePlayerMousemodeTextdraw(playerid)
{
    g_MouseModeTD[playerid] =
    CreatePlayerTextDraw          (playerid, 637.0, 375.0, "_");
    PlayerTextDrawAlignment       (playerid, g_MouseModeTD[playerid], 3);
    PlayerTextDrawBackgroundColor (playerid, g_MouseModeTD[playerid], 255);
    PlayerTextDrawFont            (playerid, g_MouseModeTD[playerid], 3);
    PlayerTextDrawLetterSize      (playerid, g_MouseModeTD[playerid], 0.529999, 1.899999);
    PlayerTextDrawColor           (playerid, g_MouseModeTD[playerid], -1);
    PlayerTextDrawSetOutline      (playerid, g_MouseModeTD[playerid], 1);
    PlayerTextDrawSetProportional (playerid, g_MouseModeTD[playerid], 1);
    PlayerTextDrawSetSelectable   (playerid, g_MouseModeTD[playerid], 0);
    PlayerTextDrawShow            (playerid, g_MouseModeTD[playerid]);

    UpdatePlayerMousemodeTextdraw(playerid);
}

UpdatePlayerMousemodeTextdraw(playerid)
{
    if(g_IsPlayerInMouseMode{playerid})
    {
        PlayerTextDrawSetString(playerid, g_MouseModeTD[playerid],
            "~w~Press ~r~ESC~w~ to exit mouse mode");
    }
    else
    {
        if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING)
        {
            PlayerTextDrawSetString(playerid, g_MouseModeTD[playerid],
             "~w~Press ~r~~k~~PED_DUCK~~w~ to use mouse mode"
            );
        } else {
            PlayerTextDrawSetString(playerid, g_MouseModeTD[playerid],
                "~w~Press ~r~~k~~CONVERSATION_YES~~w~ to use mouse mode"
            );
        }
    }
}
