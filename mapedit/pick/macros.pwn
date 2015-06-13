#define IsValidPickup(%0)  (%0 >= 0 && %0 < MAX_PICKUPS && g_IsPickupValid{%0})
#define GetPickupModel(%0) (g_PickupModel[%0])

