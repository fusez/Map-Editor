public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    new
        soundid = (response) ? (1083) : (1084)
    ;

    PlayerPlaySound(playerid, soundid, 0.0, 0.0, 0.0);
    g_pDialogID[playerid] = INVALID_DIALOG_ID;

    #if defined d_OnDialogResponse
        return d_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
    #else
        return 0;
    #endif
}
#if defined _ALS_OnDialogResponse
    #undef OnDialogResponse
#else
    #define _ALS_OnDialogResponse
#endif
#define OnDialogResponse d_OnDialogResponse
#if defined d_OnDialogResponse
    forward d_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);
#endif
