#define HidePlayerDialog(%0) \
    (ShowPlayerDialog(%0, INVALID_DIALOG_ID, 0, "", "", "", ""))

#define GetPlayerDialog(%0) \
    (g_pDialogID[%0])

#define CreateDialog(%0) \
    (%0 = g_DialogsCreated ++)
