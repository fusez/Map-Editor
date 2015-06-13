#define    INVALID_CBROWSER_ID      ( -1   )
#define    MAX_CBROWSER_ID          ( 20   )
#define    MAX_CBROWSER_TITLE       ( 20+1 )
#define    MAX_CBROWSER_PAGESIZE    ( 25   )

new
    PlayerText: g_cbBackgroundTD    [MAX_PLAYERS][3],
    PlayerText: g_cbTitleTD         [MAX_PLAYERS],
    PlayerText: g_cbCloseTD         [MAX_PLAYERS],
    PlayerText: g_cbPageTD          [MAX_PLAYERS][3],
    PlayerText: g_cbColorTD         [MAX_PLAYERS][MAX_CBROWSER_PAGESIZE],
    g_cbTitleString                 [MAX_CBROWSER_ID][MAX_CBROWSER_TITLE],
    g_cbID                          [MAX_PLAYERS] = {INVALID_CBROWSER_ID, ...}
;

enum
{
    CBROWSER_RESPONSE_CLOSE,
    CBROWSER_RESPONSE_PAGE_BACK,
    CBROWSER_RESPONSE_PAGE_NEXT,
    CBROWSER_RESPONSE_COLOR
}

forward OnCBrowserShown(playerid, browserid, page);
forward OnCBrowserResponse(playerid, browserid, response, color);

#include "mapedit/cbrowser/macros.pwn"
#include "mapedit/cbrowser/functions.pwn"
#include "mapedit/cbrowser/callbacks.pwn"
