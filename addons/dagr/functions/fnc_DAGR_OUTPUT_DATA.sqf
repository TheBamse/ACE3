/*
 * Author: Rosuto
 * DAGR data output loop
 *
 * Arguments:
 * Nothing
 *
 * Return Value:
 * Nothing
 *
 * Example:
 *
 * Public: No
 */
#include "script_component.hpp"

135471 cutRsc ["DAGR_DISPLAY", "plain down"];

#define __display (uiNameSpace getVariable "DAGR_DISPLAY")

#define __gridControl (__display displayCtrl 266851)
#define __speedControl (__display displayCtrl 266852)
#define __elevationControl (__display displayCtrl 266853)
#define __headingControl (__display displayCtrl 266854)
#define __timeControl (__display displayCtrl 266855)
#define __background (__display displayCtrl 266856)

__background ctrlSetText QUOTE(PATHTOF(UI\dagr_gps.paa));

[{
    private ["_pos", "_xgrid", "_ygrid", "_xcoord", "_ycoord", "_speed", "_dagrHeading", "_dagrGrid", "_dagrElevation", "_dagrSpeed", "_dagrTime", "_elevation"];
    
    // Abort Condition
    if !(DAGR_RUN && [ACE_player, "ACE_DAGR"] call EFUNC(common,hasItem)) exitWith {
        135471 cutText ["", "PLAIN"];
        [_this select 1] call CBA_fnc_removePerFrameHandler;
    };
    
    // GRID
    _pos = getPosASL ACE_player;

    _xGrid = toArray Str(round(_pos select 0));
    while {count _xGrid < 5} do {
        _xGrid = [48] + _xGrid;
    };
    _xGrid resize 4;
    _xGrid = toString _xGrid;
    _xGrid = parseNumber _xGrid;
    
    _yGrid = toArray Str(round(_pos select 1));
    while {count _yGrid < 5} do {
        _yGrid = [48] + _yGrid;
    };
    _yGrid resize 4;
    _yGrid = toString _yGrid;
    _yGrid = parseNumber _yGrid;

    // Incase grids go neg due to 99-00 boundry
    if (_xgrid < 0) then {_xgrid = _xgrid + 9999;};
    if (_ygrid < 0) then {_ygrid = _ygrid + 9999;};

    _xCoord = switch true do {
        case (_xGrid >= 1000): { "" + Str(_xGrid) };
        case (_xGrid >= 100): { "0" + Str(_xGrid) };
        case (_xGrid >= 10): { "00" + Str(_xGrid) };
        default             { "000" + Str(_xGrid) };
    };

    _yCoord = switch true do {
        case (_yGrid >= 1000): { "" + Str(_yGrid) };
        case (_yGrid >= 100): { "0" + Str(_yGrid) };
        case (_yGrid >= 10): { "00" + Str(_yGrid) };
        default             { "000" + Str(_yGrid) };
    };
    
    _dagrGrid = _xcoord + " " + _ycoord;
    
    // SPEED
    _speed = speed (vehicle ACE_player);
    _speed = floor (_speed * 10) / 10;
    _speed = abs(_speed);
    _dagrspeed = str _speed + "kph";

    // Elevation
    _elevation = getPosASL ACE_player;
    _elevation = floor ((_elevation select 2) + EGVAR(weather,altitude));
    _dagrElevation = str _elevation + "m";

    // Heading
    _dagrHeading = if (!DAGR_DIRECTION) then {
        floor (DEG_TO_MIL(direction (vehicle ACE_player)))
    } else {
        floor (direction (vehicle ACE_player))
    };

    // Time
    _dagrTime = [daytime, "HH:MM"] call bis_fnc_timeToString;

    // Output
    __gridControl ctrlSetText format ["%1", _dagrGrid];
    __speedControl ctrlSetText format ["%1", _dagrSpeed];
    __elevationControl ctrlSetText format ["%1", _dagrElevation];
    __headingControl ctrlSetText (if (!DAGR_DIRECTION) then { format ["%1", _dagrHeading] } else { format ["%1 �", _dagrHeading] });
    __timeControl ctrlSetText format ["%1", _dagrTime];
    
}, DAGR_UPDATE_INTERVAL, []] call CBA_fnc_addPerFrameHandler;
