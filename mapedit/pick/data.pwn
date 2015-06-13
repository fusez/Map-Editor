#define INVALID_PICKUP_ID -1

new
    bool: g_IsPickupValid    [MAX_PICKUPS char],
    g_PickupModel            [MAX_PICKUPS],
    Float: g_PickupPos       [MAX_PICKUPS][3],

    g_pEditPickup            [MAX_PLAYERS] = {INVALID_PICKUP_ID, ...},
    g_pEditPickupObject      [MAX_PLAYERS] = {INVALID_OBJECT_ID, ...},

    g_PickupSelectBrowser,
    g_pSelectPickupChoice    [MAX_PLAYERS] = {INVALID_PICKUP_ID, ...},
    g_pSelectPickupPage      [MAX_PLAYERS],
    g_pSelectPickupSearch    [MAX_PLAYERS][MAX_MBROWSER_SEARCH],
    g_pSelectPickupResult    [MAX_PLAYERS][MAX_MBROWSER_PAGESIZE],

    g_PickupCreateBrowser,
    g_pCreatePickupChoice    [MAX_PLAYERS] = {-1, ...},
    g_pCreatePickupPage      [MAX_PLAYERS],
    g_pCreatePickupSearch    [MAX_PLAYERS][MAX_MBROWSER_SEARCH],
    g_pCreatePickupResult    [MAX_PLAYERS][MAX_MBROWSER_PAGESIZE],

    g_PickupMainDialog,
    g_PickupEditDialog,
    g_PickupXDialog,
    g_PickupYDialog,
    g_PickupZDialog
;

#include "mapedit/pick/hooks.pwn"
#include "mapedit/pick/macros.pwn"
#include "mapedit/pick/functions.pwn"
#include "mapedit/pick/callbacks.pwn"
