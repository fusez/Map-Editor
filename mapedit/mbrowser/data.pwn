#define INVALID_MBROWSER_ID   (-1)
#define MAX_MBROWSER_ID       (20)
#define MAX_MBROWSER_TITLE    (20+1)
#define MAX_MBROWSER_BUTTON   (20+1)
#define MAX_MBROWSER_SEARCH   (20+1)
#define MAX_MBROWSER_PAGESIZE (20)

new
    PlayerText: g_mbBackgroundTD [MAX_PLAYERS][6],
    PlayerText: g_mbCloseTD      [MAX_PLAYERS],
    PlayerText: g_mbTitleTD      [MAX_PLAYERS],
    PlayerText: g_mbPreviewTD    [MAX_PLAYERS],
    PlayerText: g_mbButtonTD     [MAX_PLAYERS],
    PlayerText: g_mbSearchTD     [MAX_PLAYERS][2],
    PlayerText: g_mbPageTD       [MAX_PLAYERS][3],
    PlayerText: g_mbListTD       [MAX_PLAYERS][MAX_MBROWSER_PAGESIZE],

    g_mbTitleString              [MAX_MBROWSER_ID][MAX_MBROWSER_TITLE],
    g_mbButtonString             [MAX_MBROWSER_ID][MAX_MBROWSER_BUTTON],

    bool: g_mbModelShown         [MAX_PLAYERS char],
    g_mbID                       [MAX_PLAYERS] = {INVALID_MBROWSER_ID, ...},

    g_mbSearchDialog,
    g_mbPageDialog;

enum
{
    MBROWSER_RESPONSE_CLOSE,
    MBROWSER_RESPONSE_SEARCH,
    MBROWSER_RESPONSE_PAGE_BACK,
    MBROWSER_RESPONSE_PAGE_NEXT,
    MBROWSER_RESPONSE_PAGE_SET,
    MBROWSER_RESPONSE_BUTTON,
    MBROWSER_RESPONSE_LISTITEM
}

forward OnMBrowserShown(playerid, browserid);
forward OnMBrowserResponse(playerid, browserid, response, page, listitem, search[]);

#include "mapedit/mbrowser/macros.pwn"
#include "mapedit/mbrowser/functions.pwn"
#include "mapedit/mbrowser/callbacks.pwn"
