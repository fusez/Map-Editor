#define OBJECT_MOVESPEED    100.0
#define MAX_OBJECT_INDEX    16
#define MAX_OBJECT_TEXT     50
#define MAX_OBJECT_FONT     30

enum
{
    OBJECT_TYPE_TEXTURE,
    OBJECT_TYPE_TEXT
}

new
    g_ObjectAttachToObject          [MAX_OBJECTS] = {INVALID_OBJECT_ID, ...},
    g_ObjectAttachToVehicle         [MAX_OBJECTS] = {INVALID_VEHICLE_ID, ...},
    Float: g_ObjectAttachOffset     [MAX_OBJECTS][6],
    g_pSelectedAttachObject         [MAX_PLAYERS] = {INVALID_OBJECT_ID, ...},

    Float: g_ObjectSavePos          [MAX_OBJECTS][3],
    Float: g_ObjectSaveRot          [MAX_OBJECTS][3],
    Float: g_pObjectSavePos         [MAX_PLAYERS][MAX_OBJECTS][3],
    Float: g_pObjectSaveRot         [MAX_PLAYERS][MAX_OBJECTS][3],

    g_pEditObject                   [MAX_PLAYERS],
    g_pEditObjectIndex              [MAX_PLAYERS char],

    g_ObjectTextureID               [MAX_OBJECTS][MAX_OBJECT_INDEX],
    g_ObjectTextureColor            [MAX_OBJECTS][MAX_OBJECT_INDEX],

    bool: g_IsObjectText            [MAX_OBJECTS][MAX_OBJECT_INDEX],
    g_ObjectText                    [MAX_OBJECTS][MAX_OBJECT_INDEX][MAX_OBJECT_TEXT],
    g_ObjectMaterialSize            [MAX_OBJECTS][MAX_OBJECT_INDEX],
    g_ObjectFont                    [MAX_OBJECTS][MAX_OBJECT_INDEX][MAX_OBJECT_FONT],
    g_ObjectFontSize                [MAX_OBJECTS][MAX_OBJECT_INDEX],
    bool: g_IsObjectTextBold        [MAX_OBJECTS][MAX_OBJECT_INDEX],
    g_ObjectTextColor               [MAX_OBJECTS][MAX_OBJECT_INDEX],
    g_ObjectTextBackColor           [MAX_OBJECTS][MAX_OBJECT_INDEX],
    g_ObjectTextAlignment           [MAX_OBJECTS][MAX_OBJECT_INDEX],

    g_ObjectSelectBrowser,
    g_pSelectObjectChoice           [MAX_PLAYERS] = {INVALID_OBJECT_ID, ...},
    g_pSelectObjectPage             [MAX_PLAYERS],
    g_pSelectObjectSearch           [MAX_PLAYERS][MAX_MBROWSER_SEARCH],
    g_pSelectObjectResult           [MAX_PLAYERS][MAX_MBROWSER_PAGESIZE],

    g_ObjectCreateBrowser,
    g_pCreateObjectChoice           [MAX_PLAYERS] = {-1, ...},
    g_pCreateObjectPage             [MAX_PLAYERS],
    g_pCreateObjectSearch           [MAX_PLAYERS][MAX_MBROWSER_SEARCH],
    g_pCreateObjectResult           [MAX_PLAYERS][MAX_MBROWSER_PAGESIZE],

    g_ObjectMaterialBrowser,
    g_pTextureObjectPage            [MAX_PLAYERS],
    g_pTextureObjectSearch          [MAX_PLAYERS][MAX_MBROWSER_SEARCH],
    g_pTextureObjectResult          [MAX_PLAYERS][MAX_MBROWSER_PAGESIZE],

    g_ObjectTextureColorBrowser,
    g_pObjectTextureColorPage       [MAX_PLAYERS char],

    g_ObjectFontColorBrowser,
    g_pObjectFontColorPage          [MAX_PLAYERS char],

    g_ObjectBackColorBrowser,
    g_pObjectBackColorPage          [MAX_PLAYERS char],

    g_ObjectMainDialog,
    g_ObjectEditDialog,
    g_ObjectIndexDialog,
    g_ObjectXDialog,
    g_ObjectYDialog,
    g_ObjectZDialog,
    g_ObjectRXDialog,
    g_ObjectRYDialog,
    g_ObjectRZDialog,
    g_ObjectTextStringDialog,
    g_ObjectTextMaterialSizeDialog,
    g_ObjectTextFontDialog,
    g_ObjectTextFontSizeDialog,
    g_ObjectTextAlignmentDialog
;


#include "mapedit/obj/macros.pwn"
#include "mapedit/obj/hooks.pwn"
#include "mapedit/obj/dialog.pwn"
#include "mapedit/obj/attach.pwn"
#include "mapedit/obj/functions.pwn"
#include "mapedit/obj/callbacks.pwn"
