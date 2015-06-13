stock d_ShowPlayerDialog(playerid, dialogid, style, caption[], info[], button1[], button2[])
{
    g_pDialogID[playerid] = dialogid;
    ShowPlayerDialog(playerid, dialogid, style, caption, info, button1, button2);
}
#if defined _ALS_ShowPlayerDialog
    #undef ShowPlayerDialog
#else
    #define _ALS_ShowPlayerDialog
#endif
#define ShowPlayerDialog d_ShowPlayerDialog
