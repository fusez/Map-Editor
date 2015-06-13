stock CreateMBrowserTextdraws(playerid)
{
    g_mbBackgroundTD[playerid][0] =
    CreatePlayerTextDraw            (playerid, 238.0, 121.0, "_");
    PlayerTextDrawAlignment         (playerid, g_mbBackgroundTD[playerid][0], 2);
    PlayerTextDrawBackgroundColor   (playerid, g_mbBackgroundTD[playerid][0], 255);
    PlayerTextDrawFont              (playerid, g_mbBackgroundTD[playerid][0], 1);
    PlayerTextDrawLetterSize        (playerid, g_mbBackgroundTD[playerid][0], 0.500000, 0.899998);
    PlayerTextDrawColor             (playerid, g_mbBackgroundTD[playerid][0], -1);
    PlayerTextDrawSetOutline        (playerid, g_mbBackgroundTD[playerid][0], 0);
    PlayerTextDrawSetProportional   (playerid, g_mbBackgroundTD[playerid][0], 1);
    PlayerTextDrawSetShadow         (playerid, g_mbBackgroundTD[playerid][0], 1);
    PlayerTextDrawUseBox            (playerid, g_mbBackgroundTD[playerid][0], 1);
    PlayerTextDrawBoxColor          (playerid, g_mbBackgroundTD[playerid][0], 100);
    PlayerTextDrawTextSize          (playerid, g_mbBackgroundTD[playerid][0], 0.0, 146.0);
    PlayerTextDrawSetSelectable     (playerid, g_mbBackgroundTD[playerid][0], 0);

    g_mbBackgroundTD[playerid][1] =
    CreatePlayerTextDraw            (playerid, 238.0, 134.0, "_");
    PlayerTextDrawAlignment         (playerid, g_mbBackgroundTD[playerid][1], 2);
    PlayerTextDrawBackgroundColor   (playerid, g_mbBackgroundTD[playerid][1], 255);
    PlayerTextDrawFont              (playerid, g_mbBackgroundTD[playerid][1], 1);
    PlayerTextDrawLetterSize        (playerid, g_mbBackgroundTD[playerid][1], 0.500000, 0.900000);
    PlayerTextDrawColor             (playerid, g_mbBackgroundTD[playerid][1], -1);
    PlayerTextDrawSetOutline        (playerid, g_mbBackgroundTD[playerid][1], 0);
    PlayerTextDrawSetProportional   (playerid, g_mbBackgroundTD[playerid][1], 1);
    PlayerTextDrawSetShadow         (playerid, g_mbBackgroundTD[playerid][1], 1);
    PlayerTextDrawUseBox            (playerid, g_mbBackgroundTD[playerid][1], 1);
    PlayerTextDrawBoxColor          (playerid, g_mbBackgroundTD[playerid][1], 100);
    PlayerTextDrawTextSize          (playerid, g_mbBackgroundTD[playerid][1], 0.0, 146.0);
    PlayerTextDrawSetSelectable     (playerid, g_mbBackgroundTD[playerid][1], 0);

    g_mbBackgroundTD[playerid][2] =
    CreatePlayerTextDraw            (playerid, 238.0, 147.0, "_");
    PlayerTextDrawAlignment         (playerid, g_mbBackgroundTD[playerid][2], 2);
    PlayerTextDrawBackgroundColor   (playerid, g_mbBackgroundTD[playerid][2], 255);
    PlayerTextDrawFont              (playerid, g_mbBackgroundTD[playerid][2], 1);
    PlayerTextDrawLetterSize        (playerid, g_mbBackgroundTD[playerid][2], 0.500000, 0.900000);
    PlayerTextDrawColor             (playerid, g_mbBackgroundTD[playerid][2], -1);
    PlayerTextDrawSetOutline        (playerid, g_mbBackgroundTD[playerid][2], 0);
    PlayerTextDrawSetProportional   (playerid, g_mbBackgroundTD[playerid][2], 1);
    PlayerTextDrawSetShadow         (playerid, g_mbBackgroundTD[playerid][2], 1);
    PlayerTextDrawUseBox            (playerid, g_mbBackgroundTD[playerid][2], 1);
    PlayerTextDrawBoxColor          (playerid, g_mbBackgroundTD[playerid][2], 100);
    PlayerTextDrawTextSize          (playerid, g_mbBackgroundTD[playerid][2], 0.0, 146.0);
    PlayerTextDrawSetSelectable     (playerid, g_mbBackgroundTD[playerid][2], 0);

    g_mbBackgroundTD[playerid][3] =
    CreatePlayerTextDraw            (playerid, 238.0, 160.0, "_");
    PlayerTextDrawAlignment         (playerid, g_mbBackgroundTD[playerid][3], 2);
    PlayerTextDrawBackgroundColor   (playerid, g_mbBackgroundTD[playerid][3], 255);
    PlayerTextDrawFont              (playerid, g_mbBackgroundTD[playerid][3], 1);
    PlayerTextDrawLetterSize        (playerid, g_mbBackgroundTD[playerid][3], 0.500000, 20.100006);
    PlayerTextDrawColor             (playerid, g_mbBackgroundTD[playerid][3], -1);
    PlayerTextDrawSetOutline        (playerid, g_mbBackgroundTD[playerid][3], 0);
    PlayerTextDrawSetProportional   (playerid, g_mbBackgroundTD[playerid][3], 1);
    PlayerTextDrawSetShadow         (playerid, g_mbBackgroundTD[playerid][3], 1);
    PlayerTextDrawUseBox            (playerid, g_mbBackgroundTD[playerid][3], 1);
    PlayerTextDrawBoxColor          (playerid, g_mbBackgroundTD[playerid][3], 100);
    PlayerTextDrawTextSize          (playerid, g_mbBackgroundTD[playerid][3], 0.0, 146.0);
    PlayerTextDrawSetSelectable     (playerid, g_mbBackgroundTD[playerid][3], 0);

    g_mbBackgroundTD[playerid][4] =
    CreatePlayerTextDraw            (playerid, 395.0, 121.0, "_");
    PlayerTextDrawAlignment         (playerid, g_mbBackgroundTD[playerid][4], 2);
    PlayerTextDrawBackgroundColor   (playerid, g_mbBackgroundTD[playerid][4], 255);
    PlayerTextDrawFont              (playerid, g_mbBackgroundTD[playerid][4], 1);
    PlayerTextDrawLetterSize        (playerid, g_mbBackgroundTD[playerid][4], 0.500000, 20.300001);
    PlayerTextDrawColor             (playerid, g_mbBackgroundTD[playerid][4], -1);
    PlayerTextDrawSetOutline        (playerid, g_mbBackgroundTD[playerid][4], 0);
    PlayerTextDrawSetProportional   (playerid, g_mbBackgroundTD[playerid][4], 1);
    PlayerTextDrawSetShadow         (playerid, g_mbBackgroundTD[playerid][4], 1);
    PlayerTextDrawUseBox            (playerid, g_mbBackgroundTD[playerid][4], 1);
    PlayerTextDrawBoxColor          (playerid, g_mbBackgroundTD[playerid][4], 100);
    PlayerTextDrawTextSize          (playerid, g_mbBackgroundTD[playerid][4], 0.0, 160.0);
    PlayerTextDrawSetSelectable     (playerid, g_mbBackgroundTD[playerid][4], 0);

    g_mbBackgroundTD[playerid][5] =
    CreatePlayerTextDraw            (playerid, 395.0, 309.0, "_");
    PlayerTextDrawAlignment         (playerid, g_mbBackgroundTD[playerid][5], 2);
    PlayerTextDrawBackgroundColor   (playerid, g_mbBackgroundTD[playerid][5], 255);
    PlayerTextDrawFont              (playerid, g_mbBackgroundTD[playerid][5], 1);
    PlayerTextDrawLetterSize        (playerid, g_mbBackgroundTD[playerid][5], 0.500000, 3.500001);
    PlayerTextDrawColor             (playerid, g_mbBackgroundTD[playerid][5], -1);
    PlayerTextDrawSetOutline        (playerid, g_mbBackgroundTD[playerid][5], 0);
    PlayerTextDrawSetProportional   (playerid, g_mbBackgroundTD[playerid][5], 1);
    PlayerTextDrawSetShadow         (playerid, g_mbBackgroundTD[playerid][5], 1);
    PlayerTextDrawUseBox            (playerid, g_mbBackgroundTD[playerid][5], 1);
    PlayerTextDrawBoxColor          (playerid, g_mbBackgroundTD[playerid][5], 100);
    PlayerTextDrawTextSize          (playerid, g_mbBackgroundTD[playerid][5], 0.0, 160.0);
    PlayerTextDrawSetSelectable     (playerid, g_mbBackgroundTD[playerid][5], 0);

    g_mbCloseTD[playerid] =
    CreatePlayerTextDraw            (playerid, 302.0, 120.0, "LD_BEAT:cross");
    PlayerTextDrawAlignment         (playerid, g_mbCloseTD[playerid], 2);
    PlayerTextDrawBackgroundColor   (playerid, g_mbCloseTD[playerid], 255);
    PlayerTextDrawFont              (playerid, g_mbCloseTD[playerid], 4);
    PlayerTextDrawLetterSize        (playerid, g_mbCloseTD[playerid], 0.400000, 1.200000);
    PlayerTextDrawColor             (playerid, g_mbCloseTD[playerid], -1);
    PlayerTextDrawSetOutline        (playerid, g_mbCloseTD[playerid], 1);
    PlayerTextDrawSetProportional   (playerid, g_mbCloseTD[playerid], 1);
    PlayerTextDrawTextSize          (playerid, g_mbCloseTD[playerid], 10.0, 10.0);
    PlayerTextDrawSetSelectable     (playerid, g_mbCloseTD[playerid], 1);

    g_mbTitleTD[playerid] =
    CreatePlayerTextDraw            (playerid, 168.0, 111.0, "Title");
    PlayerTextDrawBackgroundColor   (playerid, g_mbTitleTD[playerid], 255);
    PlayerTextDrawFont              (playerid, g_mbTitleTD[playerid], 0);
    PlayerTextDrawLetterSize        (playerid, g_mbTitleTD[playerid], 0.580000, 1.800000);
    PlayerTextDrawColor             (playerid, g_mbTitleTD[playerid], -1);
    PlayerTextDrawSetOutline        (playerid, g_mbTitleTD[playerid], 1);
    PlayerTextDrawSetProportional   (playerid, g_mbTitleTD[playerid], 1);
    PlayerTextDrawSetSelectable     (playerid, g_mbTitleTD[playerid], 0);

    g_mbPreviewTD[playerid] =
    CreatePlayerTextDraw            (playerid, 320.0, 127.0, "_");
    PlayerTextDrawBackgroundColor   (playerid, g_mbPreviewTD[playerid], 0);
    PlayerTextDrawFont              (playerid, g_mbPreviewTD[playerid], 5);
    PlayerTextDrawLetterSize        (playerid, g_mbPreviewTD[playerid], 0.500000, 1.0);
    PlayerTextDrawColor             (playerid, g_mbPreviewTD[playerid], -1);
    PlayerTextDrawSetOutline        (playerid, g_mbPreviewTD[playerid], 0);
    PlayerTextDrawSetProportional   (playerid, g_mbPreviewTD[playerid], 1);
    PlayerTextDrawSetShadow         (playerid, g_mbPreviewTD[playerid], 1);
    PlayerTextDrawUseBox            (playerid, g_mbPreviewTD[playerid], 1);
    PlayerTextDrawBoxColor          (playerid, g_mbPreviewTD[playerid], 0);
    PlayerTextDrawTextSize          (playerid, g_mbPreviewTD[playerid], 150.0, 170.0);
    PlayerTextDrawSetSelectable     (playerid, g_mbPreviewTD[playerid], 0);

    g_mbButtonTD[playerid] =
    CreatePlayerTextDraw            (playerid, 395.000000, 314.000000, "Button");
    PlayerTextDrawAlignment         (playerid, g_mbButtonTD[playerid], 2);
    PlayerTextDrawBackgroundColor   (playerid, g_mbButtonTD[playerid], 255);
    PlayerTextDrawFont              (playerid, g_mbButtonTD[playerid], 2);
    PlayerTextDrawLetterSize        (playerid, g_mbButtonTD[playerid], 0.400000, 2.000000);
    PlayerTextDrawColor             (playerid, g_mbButtonTD[playerid], -1);
    PlayerTextDrawSetOutline        (playerid, g_mbButtonTD[playerid], 1);
    PlayerTextDrawSetProportional   (playerid, g_mbButtonTD[playerid], 1);
    PlayerTextDrawTextSize          (playerid, g_mbButtonTD[playerid], 15.0, 80.0);
    PlayerTextDrawSetSelectable     (playerid, g_mbButtonTD[playerid], 1);

    g_mbSearchTD[playerid][0] =
    CreatePlayerTextDraw            (playerid, 167.0, 133.0, "Search:");
    PlayerTextDrawBackgroundColor   (playerid, g_mbSearchTD[playerid][0], 255);
    PlayerTextDrawFont              (playerid, g_mbSearchTD[playerid][0], 2);
    PlayerTextDrawLetterSize        (playerid, g_mbSearchTD[playerid][0], 0.230000, 1.0);
    PlayerTextDrawColor             (playerid, g_mbSearchTD[playerid][0], -1);
    PlayerTextDrawSetOutline        (playerid, g_mbSearchTD[playerid][0], 1);
    PlayerTextDrawSetProportional   (playerid, g_mbSearchTD[playerid][0], 1);
    PlayerTextDrawTextSize          (playerid, g_mbSearchTD[playerid][0], 210.0, 7.0);
    PlayerTextDrawSetSelectable     (playerid, g_mbSearchTD[playerid][0], 1);

    g_mbSearchTD[playerid][1] =
    CreatePlayerTextDraw            (playerid, 309.0, 133.0, "Searching For");
    PlayerTextDrawAlignment         (playerid, g_mbSearchTD[playerid][1], 3);
    PlayerTextDrawBackgroundColor   (playerid, g_mbSearchTD[playerid][1], 255);
    PlayerTextDrawFont              (playerid, g_mbSearchTD[playerid][1], 2);
    PlayerTextDrawLetterSize        (playerid, g_mbSearchTD[playerid][1], 0.230000, 1.0);
    PlayerTextDrawColor             (playerid, g_mbSearchTD[playerid][1], -1);
    PlayerTextDrawSetOutline        (playerid, g_mbSearchTD[playerid][1], 1);
    PlayerTextDrawSetProportional   (playerid, g_mbSearchTD[playerid][1], 1);
    PlayerTextDrawSetSelectable     (playerid, g_mbSearchTD[playerid][1], 0);

    g_mbPageTD[playerid][0] =
    CreatePlayerTextDraw            (playerid, 165.0, 146.0, "LD_BEAT:left");
    PlayerTextDrawAlignment         (playerid, g_mbPageTD[playerid][0], 2);
    PlayerTextDrawBackgroundColor   (playerid, g_mbPageTD[playerid][0], 255);
    PlayerTextDrawFont              (playerid, g_mbPageTD[playerid][0], 4);
    PlayerTextDrawLetterSize        (playerid, g_mbPageTD[playerid][0], 0.23, 1.0);
    PlayerTextDrawColor             (playerid, g_mbPageTD[playerid][0], -1);
    PlayerTextDrawSetOutline        (playerid, g_mbPageTD[playerid][0], 1);
    PlayerTextDrawSetProportional   (playerid, g_mbPageTD[playerid][0], 1);
    PlayerTextDrawUseBox            (playerid, g_mbPageTD[playerid][0], 1);
    PlayerTextDrawBoxColor          (playerid, g_mbPageTD[playerid][0], 0);
    PlayerTextDrawTextSize          (playerid, g_mbPageTD[playerid][0], 10.0, 10.0);
    PlayerTextDrawSetSelectable     (playerid, g_mbPageTD[playerid][0], 1);

    g_mbPageTD[playerid][1] =
    CreatePlayerTextDraw            (playerid, 239.0, 146.0, "Page");
    PlayerTextDrawAlignment         (playerid, g_mbPageTD[playerid][1], 2);
    PlayerTextDrawBackgroundColor   (playerid, g_mbPageTD[playerid][1], 255);
    PlayerTextDrawFont              (playerid, g_mbPageTD[playerid][1], 2);
    PlayerTextDrawLetterSize        (playerid, g_mbPageTD[playerid][1], 0.230000, 1.0);
    PlayerTextDrawColor             (playerid, g_mbPageTD[playerid][1], -1);
    PlayerTextDrawSetOutline        (playerid, g_mbPageTD[playerid][1], 1);
    PlayerTextDrawSetProportional   (playerid, g_mbPageTD[playerid][1], 1);
    PlayerTextDrawTextSize          (playerid, g_mbPageTD[playerid][1], 10.0, 60.0);
    PlayerTextDrawSetSelectable     (playerid, g_mbPageTD[playerid][1], 1);

    g_mbPageTD[playerid][2] =
    CreatePlayerTextDraw            (playerid, 301.0, 146.0, "LD_BEAT:right");
    PlayerTextDrawAlignment         (playerid, g_mbPageTD[playerid][2], 2);
    PlayerTextDrawBackgroundColor   (playerid, g_mbPageTD[playerid][2], 255);
    PlayerTextDrawFont              (playerid, g_mbPageTD[playerid][2], 4);
    PlayerTextDrawLetterSize        (playerid, g_mbPageTD[playerid][2], 0.23, 1.0);
    PlayerTextDrawColor             (playerid, g_mbPageTD[playerid][2], -1);
    PlayerTextDrawSetOutline        (playerid, g_mbPageTD[playerid][2], 1);
    PlayerTextDrawSetProportional   (playerid, g_mbPageTD[playerid][2], 1);
    PlayerTextDrawUseBox            (playerid, g_mbPageTD[playerid][2], 1);
    PlayerTextDrawBoxColor          (playerid, g_mbPageTD[playerid][2], 0);
    PlayerTextDrawTextSize          (playerid, g_mbPageTD[playerid][2], 10.0, 10.0);
    PlayerTextDrawSetSelectable     (playerid, g_mbPageTD[playerid][2], 1);

    for(new item; item < 20; item ++)
    {
        g_mbListTD[playerid][item] =
        CreatePlayerTextDraw          (playerid, 167.0, 160.00 + (item * 9.0), "Listitem");
        PlayerTextDrawBackgroundColor (playerid, g_mbListTD[playerid][item], 255);
        PlayerTextDrawFont            (playerid, g_mbListTD[playerid][item], 2);
        PlayerTextDrawLetterSize      (playerid, g_mbListTD[playerid][item], 0.230000, 1.0);
        PlayerTextDrawColor           (playerid, g_mbListTD[playerid][item], -1);
        PlayerTextDrawSetOutline      (playerid, g_mbListTD[playerid][item], 1);
        PlayerTextDrawSetProportional (playerid, g_mbListTD[playerid][item], 1);
        PlayerTextDrawTextSize        (playerid, g_mbListTD[playerid][item], 310.0, 7.0);
        PlayerTextDrawSetSelectable   (playerid, g_mbListTD[playerid][item], 1);
    }
}

stock DestroyMBrowserTextdraws(playerid)
{
    for(new i; i < 6; i ++)
        PlayerTextDrawDestroy(playerid, g_mbBackgroundTD[playerid][i]);
    PlayerTextDrawDestroy(playerid, g_mbCloseTD[playerid]);
    PlayerTextDrawDestroy(playerid, g_mbTitleTD[playerid]);
    PlayerTextDrawDestroy(playerid, g_mbPreviewTD[playerid]);
    PlayerTextDrawDestroy(playerid, g_mbButtonTD[playerid]);
    for(new i; i < 2; i ++)
        PlayerTextDrawDestroy(playerid, g_mbSearchTD[playerid][i]);
    for(new i; i < 3; i ++)
        PlayerTextDrawDestroy(playerid, g_mbPageTD[playerid][i]);
    for(new i; i < 20; i ++)
        PlayerTextDrawDestroy(playerid, g_mbListTD[playerid][i]);
}

stock ShowMBrowser(playerid, browserid)
{
    if(browserid != g_mbID[playerid])
    {
        g_mbID[playerid] = browserid;
        HideMBrowserModel(playerid);

        for(new td; td < 4; td ++)
            PlayerTextDrawShow(playerid, g_mbBackgroundTD[playerid][td]);
        PlayerTextDrawShow(playerid, g_mbCloseTD[playerid]);
        PlayerTextDrawShow(playerid, g_mbTitleTD[playerid]);
        PlayerTextDrawShow(playerid, g_mbSearchTD[playerid][0]);
        for(new td; td < 3; td ++)
            PlayerTextDrawShow(playerid, g_mbPageTD[playerid][td]);

        PlayerTextDrawSetString(playerid, g_mbTitleTD[playerid], g_mbTitleString[browserid]);
        PlayerTextDrawSetString(playerid, g_mbButtonTD[playerid], g_mbButtonString[browserid]);
    }
    return OnMBrowserShown(playerid, browserid);
}

stock HideMBrowser(playerid)
{
    if(g_mbID[playerid] == INVALID_MBROWSER_ID)
        return 0;

    g_mbID[playerid] = INVALID_MBROWSER_ID;
    g_mbModelShown{playerid} = false;

    for(new td; td < 6; td ++)
        PlayerTextDrawHide(playerid, g_mbBackgroundTD[playerid][td]);
    PlayerTextDrawHide(playerid, g_mbCloseTD[playerid]);
    PlayerTextDrawHide(playerid, g_mbTitleTD[playerid]);
    PlayerTextDrawHide(playerid, g_mbPreviewTD[playerid]);
    PlayerTextDrawHide(playerid, g_mbButtonTD[playerid]);
    for(new td; td < 2; td ++)
        PlayerTextDrawHide(playerid, g_mbSearchTD[playerid][td]);
    for(new td; td < 3; td ++)
        PlayerTextDrawHide(playerid, g_mbPageTD[playerid][td]);
    for(new td; td < 20; td ++)
        PlayerTextDrawHide(playerid, g_mbListTD[playerid][td]);
    return 1;
}

stock SetMBrowserPage(playerid, page)
{
    new string[10];
    format(string, sizeof string, "Page %i", page + 1);
    PlayerTextDrawSetString(playerid, g_mbPageTD[playerid][1], string);
}

stock SetMBrowserSearch(playerid, search[])
{
    PlayerTextDrawSetString(playerid, g_mbSearchTD[playerid][1], search);
    PlayerTextDrawShow(playerid, g_mbSearchTD[playerid][1]);
}

stock SetMBrowserModel(playerid, modelid, color1 = 0, color2 = 0)
{
    PlayerTextDrawSetPreviewModel(playerid, g_mbPreviewTD[playerid], modelid);
    PlayerTextDrawSetPreviewRot(playerid, g_mbPreviewTD[playerid], -30.0, 0.0, -45.0, 2.0);
    switch(modelid)
    {
        case 400..611:
            PlayerTextDrawSetPreviewVehCol(playerid, g_mbPreviewTD[playerid], color1, color2);
    }
    PlayerTextDrawShow(playerid, g_mbPreviewTD[playerid]);

    if(g_mbModelShown{playerid} == true)
        return 0;

    PlayerTextDrawShow(playerid, g_mbBackgroundTD[playerid][4]);
    PlayerTextDrawShow(playerid, g_mbBackgroundTD[playerid][5]);
    PlayerTextDrawShow(playerid, g_mbButtonTD[playerid]);

    g_mbModelShown{playerid} = true;
    return 1;
}

stock HideMBrowserModel(playerid)
{
    if(g_mbModelShown{playerid} == false)
        return 0;

    PlayerTextDrawHide(playerid, g_mbBackgroundTD[playerid][4]);
    PlayerTextDrawHide(playerid, g_mbBackgroundTD[playerid][5]);
    PlayerTextDrawHide(playerid, g_mbButtonTD[playerid]);
    PlayerTextDrawHide(playerid, g_mbPreviewTD[playerid]);

    g_mbModelShown{playerid} = false;
    return 1;
}

stock SetMBrowserListItem(playerid, listitem, string[])
{
    PlayerTextDrawSetString(playerid, g_mbListTD[playerid][listitem], string);
    PlayerTextDrawShow(playerid, g_mbListTD[playerid][listitem]);
}

stock CreateMBrowser(&browserid, title[], button[])
{
    static mbrowsers;
    if(mbrowsers == MAX_MBROWSER_ID)
        return 0;

    browserid = mbrowsers ++;

    format(g_mbTitleString[browserid], MAX_MBROWSER_TITLE, title);
    format(g_mbButtonString[browserid], MAX_MBROWSER_BUTTON, button);
    return 1;
}
