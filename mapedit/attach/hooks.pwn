/******************************************************************************/

stock a_RemovePlayerAttachedObject(playerid, index)
{
    new success = RemovePlayerAttachedObject(playerid, index);
    if(success)
    {
        g_pIsAttached            [playerid][index] = false;

        g_pAttachedModel        [playerid][index] = 0;

        g_pAttachedBone            [playerid][index] = 0;

        for(new i; i < 3; i ++)
            g_pAttachedOffset    [playerid][index][i] = 0.0;

        for(new i; i < 3; i ++)
            g_pAttachedRot        [playerid][index][i] = 0.0;

        for(new i; i < 3; i ++)
            g_pAttachedScale    [playerid][index][i] = 1.0;

        for(new i; i < 2; i ++)
            g_pAttachedColor    [playerid][index][i] = 0xFFFFFFFF;

        new    cbrowserid = GetPlayerCBrowser(playerid),
            dialogid = GetPlayerDialog(playerid);

        if(GetPlayerMBrowser(playerid) == g_AttachModelBrowser)
            HideMBrowser(playerid);

        if(
            cbrowserid == g_AttachColorBrowser[0] ||
            cbrowserid == g_AttachColorBrowser[1]
        ){
            HideCBrowser(playerid);
        }

        if(dialogid == g_AttachIndexDialog)
            ShowPlayerAttachDialog(playerid, dialogid);
        else if(
            dialogid == g_AttachEditDialog ||
            dialogid == g_AttachBoneDialog ||
            dialogid == g_AttachXDialog ||
            dialogid == g_AttachYDialog ||
            dialogid == g_AttachZDialog ||
            dialogid == g_AttachRXDialog ||
            dialogid == g_AttachRYDialog ||
            dialogid == g_AttachRZDialog ||
            dialogid == g_AttachSXDialog ||
            dialogid == g_AttachSYDialog ||
            dialogid == g_AttachSZDialog
        ){
            HidePlayerDialog(playerid);
        }
    }
    return success;
}
#if defined _ALS_RemovePlayerAttachedObject
    #undef RemovePlayerAttachedObject
#else
    #define _ALS_RemovePlayerAttachedObject
#endif
#define RemovePlayerAttachedObject a_RemovePlayerAttachedObject

/******************************************************************************/

stock a_SetPlayerAttachedObject(playerid, index, modelid, bone, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ, materialcolor1, materialcolor2)
{
    new
         success = SetPlayerAttachedObject(
         playerid,
         index,
         modelid,
         bone,
         fOffsetX,
         fOffsetY,
         fOffsetZ,
         fRotX,
         fRotY,
         fRotZ,
         fScaleX,
         fScaleY,
         fScaleZ,
         materialcolor1,
         materialcolor2
    );

    if(success)
    {
        g_pIsAttached       [playerid][index] = true;

        g_pAttachedModel    [playerid][index] = modelid;

        g_pAttachedBone     [playerid][index] = bone;

        g_pAttachedOffset   [playerid][index][0] = fOffsetX;
        g_pAttachedOffset   [playerid][index][1] = fOffsetY;
        g_pAttachedOffset   [playerid][index][2] = fOffsetZ;

        g_pAttachedRot      [playerid][index][0] = fRotX;
        g_pAttachedRot      [playerid][index][1] = fRotY;
        g_pAttachedRot      [playerid][index][2] = fRotZ;

        g_pAttachedScale    [playerid][index][0] = fScaleX;
        g_pAttachedScale    [playerid][index][1] = fScaleY;
        g_pAttachedScale    [playerid][index][2] = fScaleZ;

        g_pAttachedColor    [playerid][index][0] = materialcolor1;
        g_pAttachedColor    [playerid][index][1] = materialcolor2;

        new dialogid = GetPlayerDialog(playerid);
        if(dialogid == g_AttachIndexDialog)
            ShowPlayerAttachDialog(playerid, dialogid);
    }
    return success;
}
#if defined _ALS_SetPlayerAttachedObject
    #undef SetPlayerAttachedObject
#else
    #define _ALS_SetPlayerAttachedObject
#endif
#define SetPlayerAttachedObject a_SetPlayerAttachedObject

/******************************************************************************/

stock a_IsPlayerAttachedObject(playerid, index)
{
    if(index < 0 || index >= MAX_ATTACHED_INDEX)
        return 0;

    return (g_pIsAttached[playerid][index]) ? 1 : 0;
}
#if defined _ALS_IsPlayerAttachedObject
    #undef IsPlayerAttachedObjectSlotUsed
#else
    #define _ALS_IsPlayerAttachedObject
#endif
#define IsPlayerAttachedObjectSlotUsed a_IsPlayerAttachedObject

/******************************************************************************/
