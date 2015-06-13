/******************************************************************************/

public OnFilterScriptInit()
{
    CreateDialog(g_mbSearchDialog);
    CreateDialog(g_mbPageDialog);

    for(new playerid; playerid < MAX_PLAYERS; playerid ++)
    {
        if(IsPlayerConnected(playerid))
               CreateMBrowserTextdraws(playerid);
    }

    #if defined mb_OnFilterScriptInit
        mb_OnFilterScriptInit();
    #endif
}
#if defined _ALS_OnFilterScriptInit
    #undef OnFilterScriptInit
#else
    #define _ALS_OnFilterScriptInit
#endif
#define OnFilterScriptInit mb_OnFilterScriptInit
#if defined mb_OnFilterScriptInit
    forward mb_OnFilterScriptInit();
#endif

/******************************************************************************/

public OnFilterScriptExit()
{
    for(new playerid; playerid < MAX_PLAYERS; playerid ++)
    {
        if(IsPlayerConnected(playerid))
               DestroyMBrowserTextdraws(playerid);
    }

    #if defined mb_OnFilterScriptExit
        mb_OnFilterScriptExit();
    #endif
}
#if defined _ALS_OnFilterScriptExit
    #undef OnFilterScriptExit
#else
    #define _ALS_OnFilterScriptExit
#endif
#define OnFilterScriptExit mb_OnFilterScriptExit
#if defined mb_OnFilterScriptExit
    forward mb_OnFilterScriptExit();
#endif

/******************************************************************************/

public OnPlayerConnect(playerid)
{
    CreateMBrowserTextdraws(playerid);

    #if defined mb_OnPlayerConnect
        mb_OnPlayerConnect(playerid);
    #endif
}
#if defined _ALS_OnPlayerConnect
    #undef OnPlayerConnect
#else
    #define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect mb_OnPlayerConnect
#if defined mb_OnPlayerConnect
    forward mb_OnPlayerConnect(playerid);
#endif

/******************************************************************************/

public OnPlayerDisconnect(playerid, reason)
{
    g_mbID[playerid] = INVALID_MBROWSER_ID;
    g_mbModelShown{playerid} = false;

    DestroyMBrowserTextdraws(playerid);

    #if defined mb_OnPlayerDisconnect
        mb_OnPlayerDisconnect(playerid, reason);
    #endif
}
#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect mb_OnPlayerDisconnect
#if defined mb_OnPlayerDisconnect
    forward mb_OnPlayerDisconnect(playerid, reason);
#endif

/******************************************************************************/

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == g_mbSearchDialog)
    {
        if(!response)
            return 1;

        OnMBrowserResponse(playerid, g_mbID[playerid], MBROWSER_RESPONSE_SEARCH, 0, 0, inputtext);
        return 1;
    }
    else if(dialogid == g_mbPageDialog)
    {
        if(!response)
            return 1;

        if(strlen(inputtext) == 0)
        {
            ShowPlayerDialog(playerid, g_mbPageDialog, DIALOG_STYLE_INPUT, "Page", " ", "Set Page", "Cancel");
            return 1;
        }

        new page = strval(inputtext) - 1;
        if(page < 0)
        {
            ShowPlayerDialog(playerid, g_mbPageDialog, DIALOG_STYLE_INPUT, "Page", " ", "Set Page", "Cancel");
            return 1;
        }

        OnMBrowserResponse(playerid, g_mbID[playerid], MBROWSER_RESPONSE_PAGE_SET, page, 0, "");
        return 1;
    }

    #if defined mb_OnDialogResponse
        return mb_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
    #else
        return 0;
    #endif
}
#if defined _ALS_OnDialogResponse
    #undef OnDialogResponse
#else
    #define _ALS_OnDialogResponse
#endif
#define OnDialogResponse mb_OnDialogResponse
#if defined mb_OnDialogResponse
    forward mb_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);
#endif

/******************************************************************************/

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
    if(playertextid == g_mbCloseTD[playerid])
    {
        OnMBrowserResponse(playerid, g_mbID[playerid], MBROWSER_RESPONSE_CLOSE, 0, 0, "");
        PlayerPlaySound(playerid, 1084, 0.0, 0.0, 0.0);
        return 1;
    }
    if(playertextid == g_mbButtonTD[playerid])
    {
        OnMBrowserResponse(playerid, g_mbID[playerid], MBROWSER_RESPONSE_BUTTON, 0, 0, "");
        PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
        return 1;
    }
    if(playertextid == g_mbSearchTD[playerid][0])
    {
        ShowPlayerDialog(playerid, g_mbSearchDialog, DIALOG_STYLE_INPUT, "Search", " ", "Search", "Cancel");
        PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
        return 1;
    }
    if(playertextid == g_mbPageTD[playerid][0])
    {
        OnMBrowserResponse(playerid, g_mbID[playerid], MBROWSER_RESPONSE_PAGE_BACK, 0, 0, "");
        PlayerPlaySound(playerid, 1084, 0.0, 0.0, 0.0);
        return 1;
    }
    if(playertextid == g_mbPageTD[playerid][1])
    {
        ShowPlayerDialog(playerid, g_mbPageDialog, DIALOG_STYLE_INPUT, "Page", " ", "Set Page", "Cancel");
        PlayerPlaySound(playerid, 1084, 0.0, 0.0, 0.0);
        return 1;
    }
    if(playertextid == g_mbPageTD[playerid][2])
    {
        OnMBrowserResponse(playerid, g_mbID[playerid], MBROWSER_RESPONSE_PAGE_NEXT, 0, 0, "");
        PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
        return 1;
    }
    for(new listitem; listitem < MAX_MBROWSER_PAGESIZE; listitem ++)
    {
        if(playertextid == g_mbListTD[playerid][listitem])
        {
            OnMBrowserResponse(playerid, g_mbID[playerid], MBROWSER_RESPONSE_LISTITEM, 0, listitem, "");
            PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
            return 1;
        }
    }

    #if defined mb_OnPlayerClickPlayerTextDraw
        return mb_OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid);
    #else
        return 0;
    #endif
}
#if defined _ALS_OnPlayerClickPTD
    #undef OnPlayerClickPlayerTextDraw
#else
    #define _ALS_OnPlayerClickPTD
#endif
#define OnPlayerClickPlayerTextDraw mb_OnPlayerClickPlayerTextDraw
#if defined mb_OnPlayerClickPlayerTextDraw
    forward mb_OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid);
#endif

/******************************************************************************/
