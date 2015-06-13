#define MAX_VEHICLE_MODEL_NAME 18

new const g_VehicleModels[212][MAX_VEHICLE_MODEL_NAME char] =
{
    !"Landstalker", !"Bravura", !"Buffalo", !"Linerunner", !"Pereniel", !"Sentinel",
    !"Dumper", !"Firetruck", !"Trashmaster", !"Stretch", !"Manana", !"Infernus",
    !"Voodoo", !"Pony", !"Mule", !"Cheetah", !"Ambulance", !"Leviathan", !"Moonbeam",
    !"Esperanto", !"Taxi", !"Washington", !"Bobcat", !"Mr Whoopee", !"BF Injection",
    !"Hunter", !"Premier", !"Enforcer", !"Securicar", !"Banshee", !"Predator", !"Bus",
    !"Rhino", !"Barracks", !"Hotknife", !"Trailer", !"Previon", !"Coach", !"Cabbie",
    !"Stallion", !"Rumpo", !"RC Bandit", !"Romero", !"Packer", !"Monster", !"Admiral",
    !"Squalo", !"Seasparrow", !"Pizzaboy", !"Tram", !"Trailer", !"Turismo", !"Speeder",
    !"Reefer", !"Tropic", !"Flatbed", !"Yankee", !"Caddy", !"Solair",
    !"Berkley's RC Van", !"Skimmer", !"PCJ-600", !"Faggio", !"Freeway", !"RC Baron",
    !"RC Raider", !"Glendale", !"Oceanic", !"Sanchez", !"Sparrow", !"Patriot", !"Quad",
    !"Coastguard", !"Dinghy", !"Hermes", !"Sabre", !"Rustler", !"ZR3 50", !"Walton",
    !"Regina", !"Comet", !"BMX", !"Burrito", !"Camper", !"Marquis", !"Baggage",
    !"Dozer", !"Maverick", !"News Chopper", !"Rancher", !"FBI Rancher", !"Virgo",
    !"Greenwood", !"Jetmax", !"Hotring", !"Sandking", !"Blista Compact",
    !"Police Maverick", !"Boxville", !"Benson", !"Mesa", !"RC Goblin",
    !"Hotring Racer A", !"Hotring Racer B", !"Bloodring Banger", !"Rancher",
    !"Super GT", !"Elegant", !"Journey", !"Bike", !"Mountain Bike", !"Beagle",
    !"Cropdust", !"Stunt", !"Tanker", !"RoadTrain", !"Nebula", !"Majestic",
    !"Buccaneer", !"Shamal", !"Hydra", !"FCR-900", !"NRG-500", !"HPV1000",
    !"Cement Truck", !"Tow Truck", !"Fortune", !"Cadrona", !"FBI Truck",
    !"Willard", !"Forklift", !"Tractor", !"Combine", !"Feltzer", !"Remington",
    !"Slamvan", !"Blade", !"Freight", !"Streak", !"Vortex", !"Vincent", !"Bullet",
    !"Clover", !"Sadler", !"Firetruck", !"Hustler", !"Intruder", !"Primo", !"Cargobob",
    !"Tampa", !"Sunrise", !"Merit", !"Utility", !"Nevada", !"Yosemite", !"Windsor",
    !"Monster A", !"Monster B", !"Uranus", !"Jester", !"Sultan", !"Stratum", !"Elegy",
    !"Raindance", !"RC Tiger", !"Flash", !"Tahoma", !"Savanna", !"Bandito", !"Freight",
    !"Trailer", !"Kart", !"Mower", !"Duneride", !"Sweeper", !"Broadway", !"Tornado",
    !"AT-400", !"DFT-30", !"Huntley", !"Stafford", !"BF-400", !"Newsvan", !"Tug",
    !"Trailer A", !"Emperor", !"Wayfarer", !"Euros", !"Hotdog", !"Club", !"Trailer B",
    !"Trailer C", !"Andromada", !"Dodo", !"RC Cam", !"Launch", !"Police Car (LSPD)",
    !"Police Car (SFPD)", !"Police Car (LVPD)", !"Police Ranger", !"Picador",
    !"S.W.A.T. Van", !"Alpha", !"Phoenix", !"Glendale", !"Sadler",
    !"Luggage Trailer A", !"Luggage Trailer B", !"Stair Trailer", !"Boxville",
    !"Farm Plow", !"Utility Trailer"
};

stock GetVehicleModelName(modelid)
{
    new modelname[MAX_VEHICLE_MODEL_NAME];
    switch(modelid)
    {
        case 400..611:
            strunpack(modelname, g_VehicleModels[modelid - 400]);
        default:
            strunpack(modelname, !"Unknown Model");
    }
    return modelname;

}
