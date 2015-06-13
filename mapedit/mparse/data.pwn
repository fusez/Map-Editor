#define MAX_MPARSE_PREFIX \
    (30 + 1)

enum
{
    MPARSE_PREFIX_OBJECT,
    MPARSE_PREFIX_VEHICLE,
    MPARSE_PREFIX_PICKUP
}

enum MPARSE_PREFIX_DATA
{
    MPARSE_PREFIX_NAME[MAX_MPARSE_PREFIX char],
    MPARSE_PREFIX_ID
}

new
    g_ObjectVariables[MAX_OBJECTS][MPARSE_PREFIX_DATA],
    g_ObjectsAdded,

    g_VehicleVariables[MAX_VEHICLES][MPARSE_PREFIX_DATA],
    g_VehiclesAdded,

    g_PickupVariables[MAX_PICKUPS][MPARSE_PREFIX_DATA],
    g_PickupsAdded
;

#include "mapedit/mparse/functions.pwn"
