new
    g_VehicleColor                  [MAX_VEHICLES][2],
    g_VehiclePaintjob               [MAX_VEHICLES char] = {3, ...},
    g_VehicleComponent              [MAX_VEHICLES][14],

    bool: g_VehicleTuningTeleported [MAX_VEHICLES char],
    Float: g_VehicleTuningPosition  [MAX_VEHICLES][4],

    g_pEditVehicle                  [MAX_PLAYERS] = {INVALID_VEHICLE_ID, ...},
    g_pEditVehicleObject            [MAX_PLAYERS] = {INVALID_OBJECT_ID, ...},
    g_pVehicleColor                 [MAX_PLAYERS][2],

    g_VehicleSelectBrowser,
    g_pSelectVehicleChoice          [MAX_PLAYERS],
    g_pSelectVehiclePage            [MAX_PLAYERS],
    g_pSelectVehicleSearch          [MAX_PLAYERS][MAX_MBROWSER_SEARCH],
    g_pSelectVehicleResult          [MAX_PLAYERS][MAX_MBROWSER_PAGESIZE],

    g_VehicleCreateBrowser,
    g_pCreateVehicleChoice          [MAX_PLAYERS],
    g_pCreateVehiclePage            [MAX_PLAYERS],
    g_pCreateVehicleSearch          [MAX_PLAYERS][MAX_MBROWSER_SEARCH],
    g_pCreateVehicleResult          [MAX_PLAYERS][MAX_MBROWSER_PAGESIZE],

    g_VehicleColorBrowser           [2],
    g_pColorVehiclePage             [MAX_PLAYERS][2],

    g_VehicleMainDialog,
    g_VehicleEditDialog,
    g_VehicleXDialog,
    g_VehicleYDialog,
    g_VehicleZDialog,
    g_VehicleRDialog
;

#include "mapedit/veh/macros.pwn"
#include "mapedit/veh/hooks.pwn"
#include "mapedit/veh/functions.pwn"
#include "mapedit/veh/callbacks.pwn"
