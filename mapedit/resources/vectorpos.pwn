stock VectorToPos(playerid, &Float:x, &Float:y, &Float:z, Float:scale)
{
    new
        Float: p[3],
        Float: v[3]
    ;

    GetPlayerCameraPos            ( playerid, p[0], p[1], p[2] );
    GetPlayerCameraFrontVector    ( playerid, v[0], v[1], v[2] );

    x = p[0] + (v[0] * scale);
    y = p[1] + (v[1] * scale);
    z = p[2] + (v[2] * scale);
}
