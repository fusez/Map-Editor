#define MAX_ATTACHED_INDEX 10
#define MAX_ATTACHED_BONE  19

new
    bool: g_pIsAttached         [MAX_PLAYERS][MAX_ATTACHED_INDEX],
    g_pAttachedModel            [MAX_PLAYERS][MAX_ATTACHED_INDEX],
    g_pAttachedBone             [MAX_PLAYERS][MAX_ATTACHED_INDEX],
    Float: g_pAttachedOffset    [MAX_PLAYERS][MAX_ATTACHED_INDEX][3],
    Float: g_pAttachedRot       [MAX_PLAYERS][MAX_ATTACHED_INDEX][3],
    Float: g_pAttachedScale     [MAX_PLAYERS][MAX_ATTACHED_INDEX][3],
    g_pAttachedColor            [MAX_PLAYERS][MAX_ATTACHED_INDEX][2],

    g_pEditAttachIndex          [MAX_PLAYERS char],

    g_AttachIndexDialog,
    g_AttachEditDialog,
    g_AttachBoneDialog,
    g_AttachXDialog,
    g_AttachYDialog,
    g_AttachZDialog,
    g_AttachRXDialog,
    g_AttachRYDialog,
    g_AttachRZDialog,
    g_AttachSXDialog,
    g_AttachSYDialog,
    g_AttachSZDialog,

    g_AttachModelBrowser,
    g_pAttachModelChoice        [MAX_PLAYERS] = {-1, ...},
    g_pAttachModelPage          [MAX_PLAYERS],
    g_pAttachModelSearch        [MAX_PLAYERS][MAX_MBROWSER_SEARCH],
    g_pAttachModelResult        [MAX_PLAYERS][MAX_MBROWSER_PAGESIZE],

    g_AttachColorBrowser        [2],
    g_pAttachColorPage          [MAX_PLAYERS][2]
;

#include "mapedit/attach/macros.pwn"
#include "mapedit/attach/hooks.pwn"
#include "mapedit/attach/functions.pwn"
#include "mapedit/attach/callbacks.pwn"
