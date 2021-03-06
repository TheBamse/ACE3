// by commy2

["ACE3 Equipment", QGVAR(AzimuthKey), localize LSTRING(AzimuthKey),
{
    // Conditions: canInteract
    if !([ACE_player, objNull, ["isNotInside"]] call EFUNC(common,canInteractWith)) exitWith {false};
    // Conditions: specific
    if !(currentWeapon ACE_player == "ACE_Vector" && {cameraView == "GUNNER"}) exitWith {false};

    // prevent holding down
    if (GETGVAR(isDownStateKey1,false)) exitWith {false};
    GVAR(isDownStateKey1) = true;

    // Statement
    ["azimuth"] call FUNC(onKeyDown);
    false
},
{
    // prevent holding down
    GVAR(isDownStateKey1) = false;

    // Conditions: canInteract
    if !([ACE_player, objNull, ["isNotInside"]] call EFUNC(common,canInteractWith)) exitWith {false};

    // Statement
    ["azimuth"] call FUNC(onKeyUp);
    false
},
[15, [false, false, false]], false, 0] call CBA_fnc_addKeybind; //Tab Key


["ACE3 Equipment", QGVAR(DistanceKey), localize LSTRING(DistanceKey),
{
    // Conditions: canInteract
    if !([ACE_player, objNull, ["isNotInside"]] call EFUNC(common,canInteractWith)) exitWith {false};
    // Conditions: specific
    if !(currentWeapon ACE_player == "ACE_Vector" && {cameraView == "GUNNER"}) exitWith {false};

    // prevent holding down
    if (GETGVAR(isDownStateKey2,false)) exitWith {false};
    GVAR(isDownStateKey2) = true;

    // Statement
    ["distance"] call FUNC(onKeyDown);
    false
},
{
    // prevent holding down
    GVAR(isDownStateKey2) = false;

    // Conditions: canInteract
    if !([ACE_player, objNull, ["isNotInside"]] call EFUNC(common,canInteractWith)) exitWith {false};

    // Statement
    ["distance"] call FUNC(onKeyUp);
    false
},
[19, [false, false, false]], false] call CBA_fnc_addKeybind; //R Key
