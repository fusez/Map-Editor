/******************************************************************************/

public OnFilterScriptInit()
{
    CreateDialog(g_SaveDialog);

    if(!fexist("maps/"))
        printf("ERROR: The file path .../scriptfiles/maps does not exist!");

    #if defined save_OnFilterScriptInit
        save_OnFilterScriptInit();
    #endif
}
#if defined _ALS_OnFilterScriptInit
    #undef OnFilterScriptInit
#else
    #define _ALS_OnFilterScriptInit
#endif
#define OnFilterScriptInit save_OnFilterScriptInit
#if defined save_OnFilterScriptInit
    forward save_OnFilterScriptInit();
#endif

/******************************************************************************/

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == g_SaveDialog)
    {
        if(!response)
            return 1;

        new
            tick = GetTickCount(),
            success = SaveMap(inputtext)
        ;

        if(!success)
        {
            SendClientMessage(playerid, RGBA_RED, "This map could not be saved!");
            ShowPlayerDialog(playerid, g_SaveDialog, DIALOG_STYLE_INPUT, "Save Map", "Enter the name of the map", "Save", "Close");
            return 1;
        }

        SendClientMessageToAll(RGBA_WHITE,
            sprintf("%s (ID: %i) has saved this map as \"%s\", saving this map took %i ms.",
                ret_GetPlayerName(playerid), playerid, inputtext, GetTickCount() - tick
            )
        );
        return 1;
    }

    #if defined save_OnDialogResponse
        return save_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
    #else
        return 0;
    #endif
}
#if defined _ALS_OnDialogResponse
    #undef OnDialogResponse
#else
    #define _ALS_OnDialogResponse
#endif
#define OnDialogResponse save_OnDialogResponse
#if defined save_OnDialogResponse
    forward save_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);
#endif

/******************************************************************************/

public OnToolbarResponse(playerid, response)
{
    if(response == TOOLBAR_SAVE)
    {
        ShowPlayerDialog(playerid, g_SaveDialog, DIALOG_STYLE_INPUT, "Save Map", "Enter the name of the map", "Save", "Close");
        return 1;
    }

    #if defined save_OnToolbarResponse
        return save_OnToolbarResponse(playerid, response);
    #else
        return 0;
    #endif
}
#if defined _ALS_OnToolbarResponse
    #undef OnToolbarResponse
#else
    #define _ALS_OnToolbarResponse
#endif
#define OnToolbarResponse save_OnToolbarResponse
#if defined save_OnToolbarResponse
    forward save_OnToolbarResponse(playerid, response);
#endif

/******************************************************************************/
