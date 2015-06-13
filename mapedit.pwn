/******************************************************************************/

native IsValidVehicle(vehicleid);
#include <a_samp>
#include <strlib>
#include <sscanf2>

/******************************************************************************/

#pragma dynamic 12000

/******************************************************************************/

#include "mapedit/resources/objmodels.pwn" // object model names
#include "mapedit/resources/textures.pwn" // object textures
#include "mapedit/resources/fonts.pwn" // fonts for objects
#include "mapedit/resources/textsizes.pwn" // textsizes for objects
#include "mapedit/resources/alignments.pwn" // text alignments for objects
#include "mapedit/resources/vehcolors.pwn" // colors for objects & vehicles
#include "mapedit/resources/vehmodels.pwn" // vehicle model names
#include "mapedit/resources/components.pwn" // compatible vehicle components
#include "mapedit/resources/tuningshops.pwn" // vehicle tuningshops for teleport
#include "mapedit/resources/filename.pwn" // function for checking invalid filenames
#include "mapedit/resources/vectorpos.pwn" // function for transforming vector to position (for spawning stuff)

#include "mapedit/color.pwn" // color defines & macros
#include "mapedit/dialog/data.pwn" // dialog stuff
#include "mapedit/tmoney.pwn" // money for tuning
#include "mapedit/mmode/data.pwn" // mousemode
#include "mapedit/toolbar/data.pwn" // toolbar
#include "mapedit/mbrowser/data.pwn" // model browser
#include "mapedit/cbrowser/data.pwn" // color browser
#include "mapedit/obj/data.pwn" // objects
#include "mapedit/veh/data.pwn" // vehicles
#include "mapedit/pick/data.pwn" // pickups
#include "mapedit/attach/data.pwn" // player attachables
#include "mapedit/cam/data.pwn" // camera mode
#include "mapedit/oedit/data.pwn" // offset editor
#include "mapedit/new/data.pwn" // new map
#include "mapedit/mparse/data.pwn" // map parser
#include "mapedit/open/data.pwn" // open map
#include "mapedit/save/data.pwn" // save map
#include "mapedit/info/data.pwn" // ingame information

/******************************************************************************/

public OnFilterScriptInit()
    print("\nFusez's Map Editor loaded successfully!\n");

/******************************************************************************/
