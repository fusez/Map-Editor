/******************************************************************************/

public OnFilterScriptInit()
{
     g_tbIconTD[TOOLBAR_VEHICLE][TOOLBAR_ICON] =
     TextDrawCreate            (598.0, 396.0, "_");
     TextDrawBackgroundColor   (g_tbIconTD[TOOLBAR_VEHICLE][TOOLBAR_ICON], 50);
     TextDrawFont              (g_tbIconTD[TOOLBAR_VEHICLE][TOOLBAR_ICON], 5);
     TextDrawLetterSize        (g_tbIconTD[TOOLBAR_VEHICLE][TOOLBAR_ICON], 0.699999, 5.0);
     TextDrawColor             (g_tbIconTD[TOOLBAR_VEHICLE][TOOLBAR_ICON], -1);
     TextDrawSetProportional   (g_tbIconTD[TOOLBAR_VEHICLE][TOOLBAR_ICON], 1);
     TextDrawUseBox            (g_tbIconTD[TOOLBAR_VEHICLE][TOOLBAR_ICON], 1);
     TextDrawBoxColor          (g_tbIconTD[TOOLBAR_VEHICLE][TOOLBAR_ICON], 0);
     TextDrawTextSize          (g_tbIconTD[TOOLBAR_VEHICLE][TOOLBAR_ICON], 40.0, 50.0);
     TextDrawSetPreviewModel   (g_tbIconTD[TOOLBAR_VEHICLE][TOOLBAR_ICON], 557);
     TextDrawSetPreviewRot     (g_tbIconTD[TOOLBAR_VEHICLE][TOOLBAR_ICON], 340.0, 0.0, 320.0, 0.8);
     TextDrawSetSelectable     (g_tbIconTD[TOOLBAR_VEHICLE][TOOLBAR_ICON], 1);
     TextDrawShowForAll        (g_tbIconTD[TOOLBAR_VEHICLE][TOOLBAR_ICON]);

     g_tbIconTD[TOOLBAR_VEHICLE][TOOLBAR_TEXT] =
     TextDrawCreate            (600.0, 435.0, "Vehicle");
     TextDrawBackgroundColor   (g_tbIconTD[TOOLBAR_VEHICLE][TOOLBAR_TEXT], 255);
     TextDrawFont              (g_tbIconTD[TOOLBAR_VEHICLE][TOOLBAR_TEXT], 1);
     TextDrawLetterSize        (g_tbIconTD[TOOLBAR_VEHICLE][TOOLBAR_TEXT], 0.199999, 1.0);
     TextDrawColor             (g_tbIconTD[TOOLBAR_VEHICLE][TOOLBAR_TEXT], -1);
     TextDrawSetOutline        (g_tbIconTD[TOOLBAR_VEHICLE][TOOLBAR_TEXT], 1);
     TextDrawSetProportional   (g_tbIconTD[TOOLBAR_VEHICLE][TOOLBAR_TEXT], 1);
     TextDrawShowForAll        (g_tbIconTD[TOOLBAR_VEHICLE][TOOLBAR_TEXT]);


     g_tbIconTD[TOOLBAR_OBJECT][TOOLBAR_ICON] =
     TextDrawCreate            (557.0, 396.0, "_");
     TextDrawBackgroundColor   (g_tbIconTD[TOOLBAR_OBJECT][TOOLBAR_ICON], 50);
     TextDrawFont              (g_tbIconTD[TOOLBAR_OBJECT][TOOLBAR_ICON], 5);
     TextDrawLetterSize        (g_tbIconTD[TOOLBAR_OBJECT][TOOLBAR_ICON], 0.699999, 5.0);
     TextDrawColor             (g_tbIconTD[TOOLBAR_OBJECT][TOOLBAR_ICON], -1);
     TextDrawSetProportional   (g_tbIconTD[TOOLBAR_OBJECT][TOOLBAR_ICON], 1);
     TextDrawUseBox            (g_tbIconTD[TOOLBAR_OBJECT][TOOLBAR_ICON], 1);
     TextDrawBoxColor          (g_tbIconTD[TOOLBAR_OBJECT][TOOLBAR_ICON], 0);
     TextDrawTextSize          (g_tbIconTD[TOOLBAR_OBJECT][TOOLBAR_ICON], 40.0, 50.0);
     TextDrawSetPreviewModel   (g_tbIconTD[TOOLBAR_OBJECT][TOOLBAR_ICON], 1220);
     TextDrawSetPreviewRot     (g_tbIconTD[TOOLBAR_OBJECT][TOOLBAR_ICON], 335.0, 0.0, 45.0, 1.0);
     TextDrawSetSelectable     (g_tbIconTD[TOOLBAR_OBJECT][TOOLBAR_ICON], 1);
     TextDrawShowForAll        (g_tbIconTD[TOOLBAR_OBJECT][TOOLBAR_ICON]);

     g_tbIconTD[TOOLBAR_OBJECT][TOOLBAR_TEXT] =
     TextDrawCreate            (559.0, 435.0, "Object");
     TextDrawBackgroundColor   (g_tbIconTD[TOOLBAR_OBJECT][TOOLBAR_TEXT], 255);
     TextDrawFont              (g_tbIconTD[TOOLBAR_OBJECT][TOOLBAR_TEXT], 1);
     TextDrawLetterSize        (g_tbIconTD[TOOLBAR_OBJECT][TOOLBAR_TEXT], 0.199999, 1.0);
     TextDrawColor             (g_tbIconTD[TOOLBAR_OBJECT][TOOLBAR_TEXT], -1);
     TextDrawSetOutline        (g_tbIconTD[TOOLBAR_OBJECT][TOOLBAR_TEXT], 1);
     TextDrawSetProportional   (g_tbIconTD[TOOLBAR_OBJECT][TOOLBAR_TEXT], 1);
     TextDrawShowForAll        (g_tbIconTD[TOOLBAR_OBJECT][TOOLBAR_TEXT]);


     g_tbIconTD[TOOLBAR_PICKUP][TOOLBAR_ICON] =
     TextDrawCreate            (516.0, 396.0, "_");
     TextDrawBackgroundColor   (g_tbIconTD[TOOLBAR_PICKUP][TOOLBAR_ICON], 50);
     TextDrawFont              (g_tbIconTD[TOOLBAR_PICKUP][TOOLBAR_ICON], 5);
     TextDrawLetterSize        (g_tbIconTD[TOOLBAR_PICKUP][TOOLBAR_ICON], 0.699999, 5.0);
     TextDrawColor             (g_tbIconTD[TOOLBAR_PICKUP][TOOLBAR_ICON], -1);
     TextDrawSetProportional   (g_tbIconTD[TOOLBAR_PICKUP][TOOLBAR_ICON], 1);
     TextDrawUseBox            (g_tbIconTD[TOOLBAR_PICKUP][TOOLBAR_ICON], 1);
     TextDrawBoxColor          (g_tbIconTD[TOOLBAR_PICKUP][TOOLBAR_ICON], 0);
     TextDrawTextSize          (g_tbIconTD[TOOLBAR_PICKUP][TOOLBAR_ICON], 40.0, 50.0);
     TextDrawSetPreviewModel   (g_tbIconTD[TOOLBAR_PICKUP][TOOLBAR_ICON], 1240);
     TextDrawSetPreviewRot     (g_tbIconTD[TOOLBAR_PICKUP][TOOLBAR_ICON], 330.0, 0.0, 325.0, 1.0);
     TextDrawSetSelectable     (g_tbIconTD[TOOLBAR_PICKUP][TOOLBAR_ICON], 1);
     TextDrawShowForAll        (g_tbIconTD[TOOLBAR_PICKUP][TOOLBAR_ICON]);

     g_tbIconTD[TOOLBAR_PICKUP][TOOLBAR_TEXT] =
     TextDrawCreate            (518.0, 435.0, "Pickup");
     TextDrawBackgroundColor   (g_tbIconTD[TOOLBAR_PICKUP][TOOLBAR_TEXT], 255);
     TextDrawFont              (g_tbIconTD[TOOLBAR_PICKUP][TOOLBAR_TEXT], 1);
     TextDrawLetterSize        (g_tbIconTD[TOOLBAR_PICKUP][TOOLBAR_TEXT], 0.199999, 1.0);
     TextDrawColor             (g_tbIconTD[TOOLBAR_PICKUP][TOOLBAR_TEXT], -1);
     TextDrawSetOutline        (g_tbIconTD[TOOLBAR_PICKUP][TOOLBAR_TEXT], 1);
     TextDrawSetProportional   (g_tbIconTD[TOOLBAR_PICKUP][TOOLBAR_TEXT], 1);
     TextDrawShowForAll        (g_tbIconTD[TOOLBAR_PICKUP][TOOLBAR_TEXT]);


     g_tbIconTD[TOOLBAR_ATTACH][TOOLBAR_ICON] =
     TextDrawCreate            (475.0, 396.0, "_");
     TextDrawBackgroundColor   (g_tbIconTD[TOOLBAR_ATTACH][TOOLBAR_ICON], 50);
     TextDrawFont              (g_tbIconTD[TOOLBAR_ATTACH][TOOLBAR_ICON], 5);
     TextDrawLetterSize        (g_tbIconTD[TOOLBAR_ATTACH][TOOLBAR_ICON], 0.699999, 5.0);
     TextDrawColor             (g_tbIconTD[TOOLBAR_ATTACH][TOOLBAR_ICON], -1);
     TextDrawSetProportional   (g_tbIconTD[TOOLBAR_ATTACH][TOOLBAR_ICON], 1);
     TextDrawUseBox            (g_tbIconTD[TOOLBAR_ATTACH][TOOLBAR_ICON], 1);
     TextDrawBoxColor          (g_tbIconTD[TOOLBAR_ATTACH][TOOLBAR_ICON], 0);
     TextDrawTextSize          (g_tbIconTD[TOOLBAR_ATTACH][TOOLBAR_ICON], 40.0, 50.0);
     TextDrawSetPreviewModel   (g_tbIconTD[TOOLBAR_ATTACH][TOOLBAR_ICON], 18978);
     TextDrawSetPreviewRot     (g_tbIconTD[TOOLBAR_ATTACH][TOOLBAR_ICON], 0.0, 0.0, 50.0, 0.7);
     TextDrawSetSelectable     (g_tbIconTD[TOOLBAR_ATTACH][TOOLBAR_ICON], 1);
     TextDrawShowForAll        (g_tbIconTD[TOOLBAR_ATTACH][TOOLBAR_ICON]);

     g_tbIconTD[TOOLBAR_ATTACH][TOOLBAR_TEXT] =
     TextDrawCreate            (477.0, 435.0, "Attached");
     TextDrawBackgroundColor   (g_tbIconTD[TOOLBAR_ATTACH][TOOLBAR_TEXT], 255);
     TextDrawFont              (g_tbIconTD[TOOLBAR_ATTACH][TOOLBAR_TEXT], 1);
     TextDrawLetterSize        (g_tbIconTD[TOOLBAR_ATTACH][TOOLBAR_TEXT], 0.199999, 1.0);
     TextDrawColor             (g_tbIconTD[TOOLBAR_ATTACH][TOOLBAR_TEXT], -1);
     TextDrawSetOutline        (g_tbIconTD[TOOLBAR_ATTACH][TOOLBAR_TEXT], 1);
     TextDrawSetProportional   (g_tbIconTD[TOOLBAR_ATTACH][TOOLBAR_TEXT], 1);
     TextDrawShowForAll        (g_tbIconTD[TOOLBAR_ATTACH][TOOLBAR_TEXT]);


     g_tbIconTD[TOOLBAR_SAVE][TOOLBAR_ICON] =
     TextDrawCreate            (434.0, 396.0, "_");
     TextDrawBackgroundColor   (g_tbIconTD[TOOLBAR_SAVE][TOOLBAR_ICON], 50);
     TextDrawFont              (g_tbIconTD[TOOLBAR_SAVE][TOOLBAR_ICON], 5);
     TextDrawLetterSize        (g_tbIconTD[TOOLBAR_SAVE][TOOLBAR_ICON], 0.699999, 5.0);
     TextDrawColor             (g_tbIconTD[TOOLBAR_SAVE][TOOLBAR_ICON], -1);
     TextDrawSetProportional   (g_tbIconTD[TOOLBAR_SAVE][TOOLBAR_ICON], 1);
     TextDrawUseBox            (g_tbIconTD[TOOLBAR_SAVE][TOOLBAR_ICON], 1);
     TextDrawBoxColor          (g_tbIconTD[TOOLBAR_SAVE][TOOLBAR_ICON], 0);
     TextDrawTextSize          (g_tbIconTD[TOOLBAR_SAVE][TOOLBAR_ICON], 40.0, 50.0);
     TextDrawSetPreviewModel   (g_tbIconTD[TOOLBAR_SAVE][TOOLBAR_ICON], 1277);
     TextDrawSetPreviewRot     (g_tbIconTD[TOOLBAR_SAVE][TOOLBAR_ICON], 330.0, 0.0, 330.0, 0.80);
     TextDrawSetSelectable     (g_tbIconTD[TOOLBAR_SAVE][TOOLBAR_ICON], 1);
     TextDrawShowForAll        (g_tbIconTD[TOOLBAR_SAVE][TOOLBAR_ICON]);

     g_tbIconTD[TOOLBAR_SAVE][TOOLBAR_TEXT] =
     TextDrawCreate            (436.0, 435.0, "Save");
     TextDrawBackgroundColor   (g_tbIconTD[TOOLBAR_SAVE][TOOLBAR_TEXT], 255);
     TextDrawFont              (g_tbIconTD[TOOLBAR_SAVE][TOOLBAR_TEXT], 1);
     TextDrawLetterSize        (g_tbIconTD[TOOLBAR_SAVE][TOOLBAR_TEXT], 0.199999, 1.0);
     TextDrawColor             (g_tbIconTD[TOOLBAR_SAVE][TOOLBAR_TEXT], -1);
     TextDrawSetOutline        (g_tbIconTD[TOOLBAR_SAVE][TOOLBAR_TEXT], 1);
     TextDrawSetProportional   (g_tbIconTD[TOOLBAR_SAVE][TOOLBAR_TEXT], 1);
     TextDrawShowForAll        (g_tbIconTD[TOOLBAR_SAVE][TOOLBAR_TEXT]);


     g_tbIconTD[TOOLBAR_OPEN][TOOLBAR_ICON] =
     TextDrawCreate            (393.0, 396.0, "_");
     TextDrawBackgroundColor   (g_tbIconTD[TOOLBAR_OPEN][TOOLBAR_ICON], 50);
     TextDrawFont              (g_tbIconTD[TOOLBAR_OPEN][TOOLBAR_ICON], 5);
     TextDrawLetterSize        (g_tbIconTD[TOOLBAR_OPEN][TOOLBAR_ICON], 0.699999, 5.0);
     TextDrawColor             (g_tbIconTD[TOOLBAR_OPEN][TOOLBAR_ICON], -1);
     TextDrawSetProportional   (g_tbIconTD[TOOLBAR_OPEN][TOOLBAR_ICON], 1);
     TextDrawUseBox            (g_tbIconTD[TOOLBAR_OPEN][TOOLBAR_ICON], 1);
     TextDrawBoxColor          (g_tbIconTD[TOOLBAR_OPEN][TOOLBAR_ICON], 0);
     TextDrawTextSize          (g_tbIconTD[TOOLBAR_OPEN][TOOLBAR_ICON], 40.0, 50.0);
     TextDrawSetPreviewModel   (g_tbIconTD[TOOLBAR_OPEN][TOOLBAR_ICON], 1210);
     TextDrawSetPreviewRot     (g_tbIconTD[TOOLBAR_OPEN][TOOLBAR_ICON], 330.0, 0.0, 340.0, 0.8);
     TextDrawSetSelectable     (g_tbIconTD[TOOLBAR_OPEN][TOOLBAR_ICON], 1);
     TextDrawShowForAll        (g_tbIconTD[TOOLBAR_OPEN][TOOLBAR_ICON]);

     g_tbIconTD[TOOLBAR_OPEN][TOOLBAR_TEXT] =
     TextDrawCreate            (395.0, 435.0, "Open");
     TextDrawBackgroundColor   (g_tbIconTD[TOOLBAR_OPEN][TOOLBAR_TEXT], 255);
     TextDrawFont              (g_tbIconTD[TOOLBAR_OPEN][TOOLBAR_TEXT], 1);
     TextDrawLetterSize        (g_tbIconTD[TOOLBAR_OPEN][TOOLBAR_TEXT], 0.199999, 1.0);
     TextDrawColor             (g_tbIconTD[TOOLBAR_OPEN][TOOLBAR_TEXT], -1);
     TextDrawSetOutline        (g_tbIconTD[TOOLBAR_OPEN][TOOLBAR_TEXT], 1);
     TextDrawSetProportional   (g_tbIconTD[TOOLBAR_OPEN][TOOLBAR_TEXT], 1);
     TextDrawShowForAll        (g_tbIconTD[TOOLBAR_OPEN][TOOLBAR_TEXT]);


     g_tbIconTD[TOOLBAR_NEW][TOOLBAR_ICON] =
     TextDrawCreate            (352.0, 396.0, "_");
     TextDrawBackgroundColor   (g_tbIconTD[TOOLBAR_NEW][TOOLBAR_ICON], 50);
     TextDrawFont              (g_tbIconTD[TOOLBAR_NEW][TOOLBAR_ICON], 5);
     TextDrawLetterSize        (g_tbIconTD[TOOLBAR_NEW][TOOLBAR_ICON], 0.699999, 5.0);
     TextDrawColor             (g_tbIconTD[TOOLBAR_NEW][TOOLBAR_ICON], -1);
     TextDrawSetProportional   (g_tbIconTD[TOOLBAR_NEW][TOOLBAR_ICON], 1);
     TextDrawUseBox            (g_tbIconTD[TOOLBAR_NEW][TOOLBAR_ICON], 1);
     TextDrawBoxColor          (g_tbIconTD[TOOLBAR_NEW][TOOLBAR_ICON], 0);
     TextDrawTextSize          (g_tbIconTD[TOOLBAR_NEW][TOOLBAR_ICON], 40.0, 50.0);
     TextDrawSetPreviewModel   (g_tbIconTD[TOOLBAR_NEW][TOOLBAR_ICON], 3111);
     TextDrawSetPreviewRot     (g_tbIconTD[TOOLBAR_NEW][TOOLBAR_ICON], 90.0, 330.0, 180.0, 0.9);
     TextDrawSetSelectable     (g_tbIconTD[TOOLBAR_NEW][TOOLBAR_ICON], 1);
     TextDrawShowForAll        (g_tbIconTD[TOOLBAR_NEW][TOOLBAR_ICON]);

     g_tbIconTD[TOOLBAR_NEW][TOOLBAR_TEXT] =
     TextDrawCreate            (354.0, 435.0, "New");
     TextDrawBackgroundColor   (g_tbIconTD[TOOLBAR_NEW][TOOLBAR_TEXT], 255);
     TextDrawFont              (g_tbIconTD[TOOLBAR_NEW][TOOLBAR_TEXT], 1);
     TextDrawLetterSize        (g_tbIconTD[TOOLBAR_NEW][TOOLBAR_TEXT], 0.199999, 1.0);
     TextDrawColor             (g_tbIconTD[TOOLBAR_NEW][TOOLBAR_TEXT], -1);
     TextDrawSetOutline        (g_tbIconTD[TOOLBAR_NEW][TOOLBAR_TEXT], 1);
     TextDrawSetProportional   (g_tbIconTD[TOOLBAR_NEW][TOOLBAR_TEXT], 1);
     TextDrawShowForAll        (g_tbIconTD[TOOLBAR_NEW][TOOLBAR_TEXT]);


     g_tbIconTD[TOOLBAR_CAM][TOOLBAR_ICON] =
     TextDrawCreate            (311.0, 396.0, "_");
     TextDrawBackgroundColor   (g_tbIconTD[TOOLBAR_CAM][TOOLBAR_ICON], 50);
     TextDrawFont              (g_tbIconTD[TOOLBAR_CAM][TOOLBAR_ICON], 5);
     TextDrawLetterSize        (g_tbIconTD[TOOLBAR_CAM][TOOLBAR_ICON], 0.699999, 5.0);
     TextDrawColor             (g_tbIconTD[TOOLBAR_CAM][TOOLBAR_ICON], -1);
     TextDrawSetProportional   (g_tbIconTD[TOOLBAR_CAM][TOOLBAR_ICON], 1);
     TextDrawUseBox            (g_tbIconTD[TOOLBAR_CAM][TOOLBAR_ICON], 1);
     TextDrawBoxColor          (g_tbIconTD[TOOLBAR_CAM][TOOLBAR_ICON], 0);
     TextDrawTextSize          (g_tbIconTD[TOOLBAR_CAM][TOOLBAR_ICON], 40.0, 50.0);
     TextDrawSetPreviewModel   (g_tbIconTD[TOOLBAR_CAM][TOOLBAR_ICON], 367);
     TextDrawSetPreviewRot     (g_tbIconTD[TOOLBAR_CAM][TOOLBAR_ICON], 340.0, 0.0, 50.0, 0.8);
     TextDrawSetSelectable     (g_tbIconTD[TOOLBAR_CAM][TOOLBAR_ICON], 1);
     TextDrawShowForAll        (g_tbIconTD[TOOLBAR_CAM][TOOLBAR_ICON]);

     g_tbIconTD[TOOLBAR_CAM][TOOLBAR_TEXT] =
     TextDrawCreate            (313.0, 435.0, "Camera");
     TextDrawBackgroundColor   (g_tbIconTD[TOOLBAR_CAM][TOOLBAR_TEXT], 255);
     TextDrawFont              (g_tbIconTD[TOOLBAR_CAM][TOOLBAR_TEXT], 1);
     TextDrawLetterSize        (g_tbIconTD[TOOLBAR_CAM][TOOLBAR_TEXT], 0.199999, 1.0);
     TextDrawColor             (g_tbIconTD[TOOLBAR_CAM][TOOLBAR_TEXT], -1);
     TextDrawSetOutline        (g_tbIconTD[TOOLBAR_CAM][TOOLBAR_TEXT], 1);
     TextDrawSetProportional   (g_tbIconTD[TOOLBAR_CAM][TOOLBAR_TEXT], 1);
     TextDrawShowForAll        (g_tbIconTD[TOOLBAR_CAM][TOOLBAR_TEXT]);


     g_tbIconTD[TOOLBAR_INFO][TOOLBAR_ICON] =
     TextDrawCreate            (270, 396.0, "_");
     TextDrawBackgroundColor   (g_tbIconTD[TOOLBAR_INFO][TOOLBAR_ICON], 50);
     TextDrawFont              (g_tbIconTD[TOOLBAR_INFO][TOOLBAR_ICON], 5);
     TextDrawLetterSize        (g_tbIconTD[TOOLBAR_INFO][TOOLBAR_ICON], 0.699999, 5.0);
     TextDrawColor             (g_tbIconTD[TOOLBAR_INFO][TOOLBAR_ICON], -1);
     TextDrawSetProportional   (g_tbIconTD[TOOLBAR_INFO][TOOLBAR_ICON], 1);
     TextDrawUseBox            (g_tbIconTD[TOOLBAR_INFO][TOOLBAR_ICON], 1);
     TextDrawBoxColor          (g_tbIconTD[TOOLBAR_INFO][TOOLBAR_ICON], 0);
     TextDrawTextSize          (g_tbIconTD[TOOLBAR_INFO][TOOLBAR_ICON], 40.0, 50.0);
     TextDrawSetPreviewModel   (g_tbIconTD[TOOLBAR_INFO][TOOLBAR_ICON], 1239);
     TextDrawSetPreviewRot     (g_tbIconTD[TOOLBAR_INFO][TOOLBAR_ICON], 0.0, 0.0, 180.0, 1.0);
     TextDrawSetSelectable     (g_tbIconTD[TOOLBAR_INFO][TOOLBAR_ICON], 1);
     TextDrawShowForAll        (g_tbIconTD[TOOLBAR_INFO][TOOLBAR_ICON]);

     g_tbIconTD[TOOLBAR_INFO][TOOLBAR_TEXT] =
     TextDrawCreate            (272, 435.0, "Info");
     TextDrawBackgroundColor   (g_tbIconTD[TOOLBAR_INFO][TOOLBAR_TEXT], 255);
     TextDrawFont              (g_tbIconTD[TOOLBAR_INFO][TOOLBAR_TEXT], 1);
     TextDrawLetterSize        (g_tbIconTD[TOOLBAR_INFO][TOOLBAR_TEXT], 0.199999, 1.0);
     TextDrawColor             (g_tbIconTD[TOOLBAR_INFO][TOOLBAR_TEXT], -1);
     TextDrawSetOutline        (g_tbIconTD[TOOLBAR_INFO][TOOLBAR_TEXT], 1);
     TextDrawSetProportional   (g_tbIconTD[TOOLBAR_INFO][TOOLBAR_TEXT], 1);
     TextDrawShowForAll        (g_tbIconTD[TOOLBAR_INFO][TOOLBAR_TEXT]);

     #if defined tb_OnFilterScriptInit
          tb_OnFilterScriptInit();
     #endif
}
#if defined _ALS_OnFilterScriptInit
     #undef OnFilterScriptInit
#else
     #define _ALS_OnFilterScriptInit
#endif
#define OnFilterScriptInit tb_OnFilterScriptInit
#if defined tb_OnFilterScriptInit
     forward tb_OnFilterScriptInit();
#endif

/******************************************************************************/

public OnFilterScriptExit()
{
     for(new a; a < MAX_TOOLBAR_RESPONSES; a ++)
     {
          for(new b; b < 2; b ++)
               TextDrawDestroy(g_tbIconTD[a][b]);
     }

     #if defined tb_OnFilterScriptExit
          tb_OnFilterScriptExit();
     #endif
}
#if defined _ALS_OnFilterScriptExit
     #undef OnFilterScriptExit
#else
     #define _ALS_OnFilterScriptExit
#endif
#define OnFilterScriptExit tb_OnFilterScriptExit
#if defined tb_OnFilterScriptExit
     forward tb_OnFilterScriptExit();
#endif

/******************************************************************************/

public OnPlayerConnect(playerid)
{
     for(new a; a < MAX_TOOLBAR_RESPONSES; a ++)
     {
          for(new b; b < 2; b ++)
               TextDrawShowForPlayer(playerid, g_tbIconTD[a][b]);
     }

     #if defined tb_OnPlayerConnect
          tb_OnPlayerConnect(playerid);
     #endif
}
#if defined _ALS_OnPlayerConnect
     #undef OnPlayerConnect
#else
     #define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect tb_OnPlayerConnect
#if defined tb_OnPlayerConnect
     forward tb_OnPlayerConnect(playerid);
#endif

/******************************************************************************/

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
     for(new i; i < MAX_TOOLBAR_RESPONSES; i ++)
     {
          if(clickedid == g_tbIconTD[i][TOOLBAR_ICON])
          {
               PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
               CallLocalFunction("OnToolbarResponse", "ii", playerid, i);
               return 1;
          }
     }

     #if defined tb_OnPlayerClickTextDraw
          return tb_OnPlayerClickTextDraw(playerid, Text:clickedid);
     #else
         return 0;
     #endif
}
#if defined _ALS_OnPlayerClickTextDraw
     #undef OnPlayerClickTextDraw
#else
     #define _ALS_OnPlayerClickTextDraw
#endif
#define OnPlayerClickTextDraw tb_OnPlayerClickTextDraw
#if defined tb_OnPlayerClickTextDraw
     forward tb_OnPlayerClickTextDraw(playerid, Text:clickedid);
#endif

/******************************************************************************/
