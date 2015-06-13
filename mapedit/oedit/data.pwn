/******************************************************************************/

#define OE_MOVESPEED_SLOW_MULTIPLIER   (0.001)
#define OE_MOVESPEED_SLOW_LIMIT        (0.2)
#define OE_MOVESPEED_MULTIPLIER        (0.01)
#define OE_MOVESPEED_LIMIT             (2.0)
#define OE_ROTATESPEED_SLOW_MULTIPLIER (0.01)
#define OE_ROTATESPEED_SLOW_LIMIT      (1.0)
#define OE_ROTATESPEED_MULTIPLIER      (0.1)
#define OE_ROTATESPEED_LIMIT           (5.0)

/******************************************************************************/

enum
{
    OFFSET_MODE_NONE,
    OFFSET_MODE_X,
    OFFSET_MODE_Y,
    OFFSET_MODE_Z,
    OFFSET_MODE_RX,
    OFFSET_MODE_RY,
    OFFSET_MODE_RZ
}

new
    bool: g_pOffsetEditToggled    [MAX_PLAYERS char],
    g_pOffsetEditMode             [MAX_PLAYERS char],
    g_pOffsetEditTimer            [MAX_PLAYERS],
    Float: g_pOffsetEditSpeed     [MAX_PLAYERS]
;

/******************************************************************************/

forward OnPlayerOffsetEditUpdate(playerid);

/******************************************************************************/

#include "mapedit/oedit/functions.pwn"
#include "mapedit/oedit/callbacks.pwn"

/******************************************************************************/
