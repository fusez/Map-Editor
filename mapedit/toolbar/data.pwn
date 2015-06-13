#define MAX_TOOLBAR_RESPONSES 9

enum
{
    Text: TOOLBAR_VEHICLE,
    Text: TOOLBAR_OBJECT,
    Text: TOOLBAR_PICKUP,
    Text: TOOLBAR_ATTACH,
    Text: TOOLBAR_SAVE,
    Text: TOOLBAR_OPEN,
    Text: TOOLBAR_NEW,
    Text: TOOLBAR_CAM,
    Text: TOOLBAR_INFO
}

enum
{
    Text: TOOLBAR_ICON,
    Text: TOOLBAR_TEXT
}

new Text: g_tbIconTD [MAX_TOOLBAR_RESPONSES][2];

forward OnToolbarResponse(playerid, response);

#include "mapedit/toolbar/callbacks.pwn"
