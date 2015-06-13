/******************************************************************************/

public OnFilterScriptInit()
{
    CreateDialog(g_OpenDialog);

    #if defined open_OnFilterScriptInit
        open_OnFilterScriptInit();
    #endif
}
#if defined _ALS_OnFilterScriptInit
    #undef OnFilterScriptInit
#else
    #define _ALS_OnFilterScriptInit
#endif
#define OnFilterScriptInit open_OnFilterScriptInit
#if defined open_OnFilterScriptInit
    forward open_OnFilterScriptInit();
#endif

/******************************************************************************/

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == g_OpenDialog)
    {
        if(!response)
            return 1;

        new
            pre_tick = GetTickCount(),
            success = mparse_LoadMap(inputtext),
            post_tick = GetTickCount()
        ;

        if(!success)
        {
            SendClientMessage(playerid, RGBA_RED, "This map could not be opened!");
            ShowPlayerDialog(playerid, g_OpenDialog, DIALOG_STYLE_INPUT, "Open Map", "Enter the name of the map", "Open", "Close");
            return 1;
        }

        SendClientMessageToAll(RGBA_WHITE,
            sprintf("%s (ID: %i) has opened the map \"%s\", loading this map took %i ms.",
                ret_GetPlayerName(playerid), playerid, inputtext, post_tick - pre_tick
            )
        );
        return 1;
    }

    #if defined open_OnDialogResponse
        return open_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
    #else
        return 0;
    #endif
}
#if defined _ALS_OnDialogResponse
    #undef OnDialogResponse
#else
    #define _ALS_OnDialogResponse
#endif
#define OnDialogResponse open_OnDialogResponse
#if defined open_OnDialogResponse
    forward open_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);
#endif

/******************************************************************************/

public OnToolbarResponse(playerid, response)
{
    if(response == TOOLBAR_OPEN)
    {
        ShowPlayerDialog(playerid, g_OpenDialog, DIALOG_STYLE_INPUT, "Open Map", "Enter the name of the map", "Open", "Close");
        return 1;
    }

    #if defined open_OnToolbarResponse
        return open_OnToolbarResponse(playerid, response);
    #else
        return 0;
    #endif
}
#if defined _ALS_OnToolbarResponse
    #undef OnToolbarResponse
#else
    #define _ALS_OnToolbarResponse
#endif
#define OnToolbarResponse open_OnToolbarResponse
#if defined open_OnToolbarResponse
    forward open_OnToolbarResponse(playerid, response);
#endif

/******************************************************************************/
