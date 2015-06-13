stock CreateCBrowserTextdraws(playerid)
{
    g_cbBackgroundTD[playerid][0] =
    CreatePlayerTextDraw            (playerid, 320.0, 120.0, "_");
    PlayerTextDrawAlignment         (playerid, g_cbBackgroundTD[playerid][0], 2);
    PlayerTextDrawBackgroundColor   (playerid, g_cbBackgroundTD[playerid][0], 0);
    PlayerTextDrawFont              (playerid, g_cbBackgroundTD[playerid][0], 1);
    PlayerTextDrawLetterSize        (playerid, g_cbBackgroundTD[playerid][0], 0.500000, 1.0);
    PlayerTextDrawColor             (playerid, g_cbBackgroundTD[playerid][0], 0);
    PlayerTextDrawSetOutline        (playerid, g_cbBackgroundTD[playerid][0], 0);
    PlayerTextDrawSetProportional   (playerid, g_cbBackgroundTD[playerid][0], 1);
    PlayerTextDrawSetShadow         (playerid, g_cbBackgroundTD[playerid][0], 1);
    PlayerTextDrawUseBox            (playerid, g_cbBackgroundTD[playerid][0], 1);
    PlayerTextDrawBoxColor          (playerid, g_cbBackgroundTD[playerid][0], 100);
    PlayerTextDrawTextSize          (playerid, g_cbBackgroundTD[playerid][0], 0.0, 170.0);
    PlayerTextDrawSetSelectable     (playerid, g_cbBackgroundTD[playerid][0], 0);

    g_cbBackgroundTD[playerid][1] =
    CreatePlayerTextDraw            (playerid, 320.0, 133.0, "_");
    PlayerTextDrawAlignment         (playerid, g_cbBackgroundTD[playerid][1], 2);
    PlayerTextDrawBackgroundColor   (playerid, g_cbBackgroundTD[playerid][1], 0);
    PlayerTextDrawFont              (playerid, g_cbBackgroundTD[playerid][1], 1);
    PlayerTextDrawLetterSize        (playerid, g_cbBackgroundTD[playerid][1], 0.500000, 1.0);
    PlayerTextDrawColor             (playerid, g_cbBackgroundTD[playerid][1], 0);
    PlayerTextDrawSetOutline        (playerid, g_cbBackgroundTD[playerid][1], 0);
    PlayerTextDrawSetProportional   (playerid, g_cbBackgroundTD[playerid][1], 1);
    PlayerTextDrawSetShadow         (playerid, g_cbBackgroundTD[playerid][1], 1);
    PlayerTextDrawUseBox            (playerid, g_cbBackgroundTD[playerid][1], 1);
    PlayerTextDrawBoxColor          (playerid, g_cbBackgroundTD[playerid][1], 100);
    PlayerTextDrawTextSize          (playerid, g_cbBackgroundTD[playerid][1], 0.0, 170.0);
    PlayerTextDrawSetSelectable     (playerid, g_cbBackgroundTD[playerid][1], 0);

    g_cbBackgroundTD[playerid][2] =
    CreatePlayerTextDraw            (playerid, 320.0, 146.0, "_");
    PlayerTextDrawAlignment         (playerid, g_cbBackgroundTD[playerid][2], 2);
    PlayerTextDrawBackgroundColor   (playerid, g_cbBackgroundTD[playerid][2], 0);
    PlayerTextDrawFont              (playerid, g_cbBackgroundTD[playerid][2], 1);
    PlayerTextDrawLetterSize        (playerid, g_cbBackgroundTD[playerid][2], 0.500000, 19.399997);
    PlayerTextDrawColor             (playerid, g_cbBackgroundTD[playerid][2], 0);
    PlayerTextDrawSetOutline        (playerid, g_cbBackgroundTD[playerid][2], 0);
    PlayerTextDrawSetProportional   (playerid, g_cbBackgroundTD[playerid][2], 1);
    PlayerTextDrawSetShadow         (playerid, g_cbBackgroundTD[playerid][2], 1);
    PlayerTextDrawUseBox            (playerid, g_cbBackgroundTD[playerid][2], 1);
    PlayerTextDrawBoxColor          (playerid, g_cbBackgroundTD[playerid][2], 100);
    PlayerTextDrawTextSize          (playerid, g_cbBackgroundTD[playerid][2], 0.0, 170.0);
    PlayerTextDrawSetSelectable     (playerid, g_cbBackgroundTD[playerid][2], 0);

    g_cbTitleTD[playerid] =
    CreatePlayerTextDraw            (playerid, 239.0, 108.0, "Title");
    PlayerTextDrawBackgroundColor   (playerid, g_cbTitleTD[playerid], 255);
    PlayerTextDrawFont              (playerid, g_cbTitleTD[playerid], 0);
    PlayerTextDrawLetterSize        (playerid, g_cbTitleTD[playerid], 0.500000, 2.0);
    PlayerTextDrawColor             (playerid, g_cbTitleTD[playerid], -1);
    PlayerTextDrawSetOutline        (playerid, g_cbTitleTD[playerid], 1);
    PlayerTextDrawSetProportional   (playerid, g_cbTitleTD[playerid], 1);
    PlayerTextDrawSetSelectable     (playerid, g_cbTitleTD[playerid], 0);

    g_cbCloseTD[playerid] =
    CreatePlayerTextDraw            (playerid, 396.0, 119.0, "LD_BEAT:cross");
    PlayerTextDrawAlignment         (playerid, g_cbCloseTD[playerid], 2);
    PlayerTextDrawBackgroundColor   (playerid, g_cbCloseTD[playerid], 255);
    PlayerTextDrawFont              (playerid, g_cbCloseTD[playerid], 4);
    PlayerTextDrawLetterSize        (playerid, g_cbCloseTD[playerid], 0.349999, 1.299999);
    PlayerTextDrawColor             (playerid, g_cbCloseTD[playerid], -1);
    PlayerTextDrawSetOutline        (playerid, g_cbCloseTD[playerid], 1);
    PlayerTextDrawSetProportional   (playerid, g_cbCloseTD[playerid], 1);
    PlayerTextDrawUseBox            (playerid, g_cbCloseTD[playerid], 1);
    PlayerTextDrawBoxColor          (playerid, g_cbCloseTD[playerid], 255);
    PlayerTextDrawTextSize          (playerid, g_cbCloseTD[playerid], 10.0, 10.0);
    PlayerTextDrawSetSelectable     (playerid, g_cbCloseTD[playerid], 1);

    g_cbPageTD[playerid][0] =
    CreatePlayerTextDraw            (playerid, 235.0, 132.0, "LD_BEAT:left");
    PlayerTextDrawAlignment         (playerid, g_cbPageTD[playerid][0], 2);
    PlayerTextDrawBackgroundColor   (playerid, g_cbPageTD[playerid][0], 255);
    PlayerTextDrawFont              (playerid, g_cbPageTD[playerid][0], 4);
    PlayerTextDrawLetterSize        (playerid, g_cbPageTD[playerid][0], 0.34, 1.299999);
    PlayerTextDrawColor             (playerid, g_cbPageTD[playerid][0], -1);
    PlayerTextDrawSetOutline        (playerid, g_cbPageTD[playerid][0], 1);
    PlayerTextDrawSetProportional   (playerid, g_cbPageTD[playerid][0], 1);
    PlayerTextDrawUseBox            (playerid, g_cbPageTD[playerid][0], 1);
    PlayerTextDrawBoxColor          (playerid, g_cbPageTD[playerid][0], 255);
    PlayerTextDrawTextSize          (playerid, g_cbPageTD[playerid][0], 12.0, 12.0);
    PlayerTextDrawSetSelectable     (playerid, g_cbPageTD[playerid][0], 1);

    g_cbPageTD[playerid][1] =
    CreatePlayerTextDraw            (playerid, 320.0, 131.0, "Page");
    PlayerTextDrawAlignment         (playerid, g_cbPageTD[playerid][1], 2);
    PlayerTextDrawBackgroundColor   (playerid, g_cbPageTD[playerid][1], 255);
    PlayerTextDrawFont              (playerid, g_cbPageTD[playerid][1], 2);
    PlayerTextDrawLetterSize        (playerid, g_cbPageTD[playerid][1], 0.33, 1.3);
    PlayerTextDrawColor             (playerid, g_cbPageTD[playerid][1], -1);
    PlayerTextDrawSetOutline        (playerid, g_cbPageTD[playerid][1], 1);
    PlayerTextDrawSetProportional   (playerid, g_cbPageTD[playerid][1], 1);
    PlayerTextDrawSetSelectable     (playerid, g_cbPageTD[playerid][1], 0);

    g_cbPageTD[playerid][2] =
    CreatePlayerTextDraw            (playerid, 394.0, 132.0, "LD_BEAT:right");
    PlayerTextDrawAlignment         (playerid, g_cbPageTD[playerid][2], 2);
    PlayerTextDrawBackgroundColor   (playerid, g_cbPageTD[playerid][2], 255);
    PlayerTextDrawFont              (playerid, g_cbPageTD[playerid][2], 4);
    PlayerTextDrawLetterSize        (playerid, g_cbPageTD[playerid][2], 0.34, 1.299999);
    PlayerTextDrawColor             (playerid, g_cbPageTD[playerid][2], -1);
    PlayerTextDrawSetOutline        (playerid, g_cbPageTD[playerid][2], 1);
    PlayerTextDrawSetProportional   (playerid, g_cbPageTD[playerid][2], 1);
    PlayerTextDrawUseBox            (playerid, g_cbPageTD[playerid][2], 1);
    PlayerTextDrawBoxColor          (playerid, g_cbPageTD[playerid][2], 255);
    PlayerTextDrawTextSize          (playerid, g_cbPageTD[playerid][2], 12.0, 12.0);
    PlayerTextDrawSetSelectable     (playerid, g_cbPageTD[playerid][2], 1);

    for(new height, index; height < 5; height ++)
    {
        for(new width; width < 5; width ++, index ++)
        {
            g_cbColorTD[playerid][index] =
            CreatePlayerTextDraw            (playerid, 252.0 + (34.0 * width), 148.0 + (35.0 * height), "_");
            PlayerTextDrawAlignment         (playerid, g_cbColorTD[playerid][index], 2);
            PlayerTextDrawBackgroundColor   (playerid, g_cbColorTD[playerid][index], 0);
            PlayerTextDrawFont              (playerid, g_cbColorTD[playerid][index], 1);
            PlayerTextDrawLetterSize        (playerid, g_cbColorTD[playerid][index], 0.500000, 3.399999);
            PlayerTextDrawColor             (playerid, g_cbColorTD[playerid][index], 0);
            PlayerTextDrawSetOutline        (playerid, g_cbColorTD[playerid][index], 0);
            PlayerTextDrawSetProportional   (playerid, g_cbColorTD[playerid][index], 1);
            PlayerTextDrawSetShadow         (playerid, g_cbColorTD[playerid][index], 1);
            PlayerTextDrawUseBox            (playerid, g_cbColorTD[playerid][index], 1);
            PlayerTextDrawBoxColor          (playerid, g_cbColorTD[playerid][index], 255);
            PlayerTextDrawTextSize          (playerid, g_cbColorTD[playerid][index], 30.0, 30.0);
            PlayerTextDrawSetSelectable     (playerid, g_cbColorTD[playerid][index], 1);
        }
    }
}

stock DestroyCBrowserTextdraws(playerid)
{
    PlayerTextDrawDestroy(playerid, g_cbTitleTD[playerid]);
    PlayerTextDrawDestroy(playerid, g_cbCloseTD[playerid]);

    for(new i; i < 3; i ++)
        PlayerTextDrawDestroy(playerid, g_cbBackgroundTD[playerid][i]);

    for(new i; i < 3; i ++)
        PlayerTextDrawDestroy(playerid, g_cbPageTD[playerid][i]);

    for(new i; i < 25; i ++)
        PlayerTextDrawDestroy(playerid, g_cbColorTD[playerid][i]);
}

stock ShowCBrowser(playerid, browserid, page)
{
    if(g_cbID[playerid] != browserid)
    {
        g_cbID[playerid] = browserid;

        for(new i; i < 3; i ++)
            PlayerTextDrawShow(playerid, g_cbBackgroundTD[playerid][i]);

        for(new i; i < 3; i ++)
            PlayerTextDrawShow(playerid, g_cbPageTD[playerid][i]);

        PlayerTextDrawShow(playerid, g_cbTitleTD[playerid]);
        PlayerTextDrawShow(playerid, g_cbCloseTD[playerid]);

        PlayerTextDrawSetString ( playerid, g_cbTitleTD[playerid], g_cbTitleString[browserid] );
    }

    PlayerTextDrawSetString ( playerid, g_cbPageTD[playerid][1], sprintf("Page %i", page + 1) );
    return OnCBrowserShown(playerid, browserid, page);
}

stock HideCBrowser(playerid)
{
    if(g_cbID[playerid] == INVALID_CBROWSER_ID)
        return 0;

    g_cbID[playerid] = INVALID_CBROWSER_ID;

    PlayerTextDrawHide(playerid, g_cbTitleTD[playerid]);
    PlayerTextDrawHide(playerid, g_cbCloseTD[playerid]);

    for(new td = 0; td < 3; td ++)
        PlayerTextDrawHide(playerid, g_cbBackgroundTD[playerid][td]);

    for(new i; i < 3; i ++)
        PlayerTextDrawHide(playerid, g_cbPageTD[playerid][i]);

    for(new i; i < 25; i ++)
        PlayerTextDrawHide(playerid, g_cbColorTD[playerid][i]);
    return 1;
}

stock SetCBrowserColor(playerid, index, color)
{
    PlayerTextDrawBoxColor(playerid, g_cbColorTD[playerid][index], color);
    PlayerTextDrawShow(playerid, g_cbColorTD[playerid][index]);
}

stock CreateCBrowser(&browserid, const title[])
{
    static browsers;
    if(browsers == MAX_CBROWSER_ID)
        return 0;

    browserid = browsers ++;
    format(g_cbTitleString[browserid], MAX_CBROWSER_TITLE, title);
    return 1;
}
