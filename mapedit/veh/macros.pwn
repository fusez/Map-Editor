#define GetVehicleColor(%0,%1,%2) (%1 = g_VehicleColor[%0 - 1][0], %2 = g_VehicleColor[%0 - 1][1])
#define GetVehiclePaintjob(%0)    (g_VehiclePaintjob{%0 - 1})
