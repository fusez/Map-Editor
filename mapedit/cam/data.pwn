new
    bool: g_IsPlayerCamActivated    [MAX_PLAYERS char],
    g_PlayerCamDirection            [MAX_PLAYERS char],
    g_PlayerCamObject               [MAX_PLAYERS],
    Float: g_PlayerCamAcceleration  [MAX_PLAYERS]
;

enum
{
    CAM_MODE_STOP,
    CAM_MODE_FORWARD,
    CAM_MODE_BACKWARD,
    CAM_MODE_LEFT,
    CAM_MODE_RIGHT,
    CAM_MODE_FORWARD_LEFT,
    CAM_MODE_FORWARD_RIGHT,
    CAM_MODE_BACKWARD_LEFT,
    CAM_MODE_BACKWARD_RIGHT
}

#include "mapedit/cam/functions.pwn"
#include "mapedit/cam/callbacks.pwn"
