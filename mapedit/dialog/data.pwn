#define MIN_DIALOG_ID     (1000)
#define INVALID_DIALOG_ID (-1)

new
    g_pDialogID[MAX_PLAYERS],
    g_DialogsCreated = MIN_DIALOG_ID
;

#include "mapedit/dialog/macros.pwn"
#include "mapedit/dialog/hooks.pwn"
#include "mapedit/dialog/callbacks.pwn"
