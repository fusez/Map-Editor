/******************************************************************************/

public OnFilterScriptInit()
{
    CreateDialog(g_NewDialog);
    ClearMap();

    #if defined new_OnFilterScriptInit
        new_OnFilterScriptInit();
    #endif
}
#if defined _ALS_OnFilterScriptInit
    #undef OnFilterScriptInit
#else
    #define _ALS_OnFilterScriptInit
#endif
#define OnFilterScriptInit new_OnFilterScriptInit
#if defined new_OnFilterScriptInit
    forward new_OnFilterScriptInit();
#endif

/******************************************************************************/

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == g_NewDialog)
    {
        if(!response)
            return 1;

        ClearMap();

        SendClientMessageToAll(RGBA_WHITE,
            sprintf("%s (ID: %i) has created a new map.", ret_GetPlayerName(playerid), playerid)
        );
        return 1;
    }
    #if defined new_OnDialogResponse
        return new_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
    #else
        return 0;
    #endif
}
#if defined _ALS_OnDialogResponse
    #undef OnDialogResponse
#else
    #define _ALS_OnDialogResponse
#endif
#define OnDialogResponse new_OnDialogResponse
#if defined new_OnDialogResponse
    forward new_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);
#endif

/******************************************************************************/

public OnToolbarResponse(playerid, response)
{
    if(response == TOOLBAR_NEW)
    {
        ShowPlayerDialog(playerid, g_NewDialog, DIALOG_STYLE_MSGBOX, "New Map", "Are you sure you want to start a new map?", "Yes", "No");
        return 1;
    }

    #if defined new_OnToolbarResponse
        return new_OnToolbarResponse(playerid, response);
    #else
        return 0;
    #endif
}
#if defined _ALS_OnToolbarResponse
    #undef OnToolbarResponse
#else
    #define _ALS_OnToolbarResponse
#endif
#define OnToolbarResponse new_OnToolbarResponse
#if defined new_OnToolbarResponse
    forward new_OnToolbarResponse(playerid, response);
#endif

/******************************************************************************/
