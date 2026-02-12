#include "script_component.hpp"
/* File: fnc_onZeusInterfaceOpen.sqf
 * Author(s): riksuFIN
 * Description: Shows side relations hint when Zeus interface is opened
 *	
 * Called from: EH
 * Local to: Client
 * Parameter(s):
 NONE
 *
 Returns:	NOTHING
 *
 * Example:	call RAA_zeus_fnc_onZeusInterfaceOpen
*/


private _img = "";

if ([west, east] call BIS_fnc_sideIsFriendly) then {
	_img = "F";
} else {
	_img = "H";
};

if ([east, resistance] call BIS_fnc_sideIsFriendly) then {
	_img = _img + "F";
} else {
	_img = _img + "H";
};

if ([resistance, west] call BIS_fnc_sideIsFriendly) then {
	_img = _img + "F";
} else {
	_img = _img + "H";
};

// Assemple full path
//_img = "\r\misc\addons\RAA_zeus\pics\sideRelations\" + _img + ".paa";
_img = QPATHTOF(pics\sideRelations\) + _img + ".paa";
//_img = ["\r\misc\addons\RAA_zeus\pics\sideRelations\", _img, ".paa"] joinString "";	

if (RAA_zeus_debug) then {systemChat format ["[RAA_zeus] SideRelations: %1", _img];};

/*
[
	_img,
	[100, 100, 50, 50]	//position: Boolean or Array (optional, default [0, 0, 1, 1]) 
		// tileSize: Number or Array (optional, default 10 ([10,10]) 
		// duration: Number - (optional, default 5) duration in seconds
		// fadeInOutTime: Number or Array - (optional, default 0) duration of the fade effect in seconds 
		// tileTransparency: Number - (optional, default 0.3) transparency or alpha value of the tiles. 0 means invisible and 1 fully visible
] spawn BIS_fnc_textTiles;
*/

[ 
    '<img align=''left'' size=''2.5'' shadow=''0'' image='+(str(_img))+' />', 
    safeZoneX + (safeZoneW * 0.2), 
    safeZoneY + 0.1, 
    15,	// Duration
    1,	// FadeIn time
    0,	// Movement up/ down
    "RscDisplayCurator"	// Zeus interface rsc layer (?)		// Changed from 21 to 312
] spawn bis_fnc_dynamicText;

//titleText ["<t color='#ff0000' size='5'>RED ALERT!</t><br/>***********", "PLAIN", -1, true, true];




//<img image='\a3\Data_f\Flags\flag_Altis_co.paa'/>
