#include "script_component.hpp"
/* File: fnc_damageableItems_headgear.sqf
 * Author(s): riksuFIN
 * Description: Knocks off helmets when they take damage
 *
 * Called from: fnc_damageableItems_onHit
 * Local to:	Client
 * Parameter(s):
 * 0:	Unit who was affected <OBJECT, default player>
 * 1:	Show text message. 0 to disable <NUMBER, default 0>
 Returns: Nothing
 *
 * Example:	
 *	[] call RAA_misc_fnc_damageableItems_headgear
*/
params [["_unit", player], ["_giveMessage", 0]];

private _headgear = headgear _unit;
if (_headgear isEqualTo "") exitWith {
	if (RAA_misc_debug) then {systemChat format ["[RAA_misc] %1 has no headgear, aborted", _unit];};
};


// 0,0026 ms
if (getNumber (configFile >> "CfgWeapons" >> _headgear >> "ItemInfo" >> "HitpointsProtectionInfo" >> "Head" >> "armor") <= 0) exitWith {
	if (RAA_misc_debug) then {systemChat format ["[RAA_misc] %1's headgear has no armor, aborted", _unit];};
};



// Handle dropping helmet to ground OR vehicle's inventory if player's inside
private _weaponHolder = objNull;
if (vehicle _unit isEqualTo _unit) then {
	// Player is on foot, drop headgear to ground
	// Drop headgear to ground to nearest weaponHolder
	_weaponHolder = nearestObject [_unit, "WeaponHolder"];
	
	if (isNull _weaponHolder || {_unit distance _weaponHolder > 2}) then {
		 _weaponHolder = createVehicle ["GroundWeaponHolder", [0,0,0], [], 0, "NONE"];
		 _weaponHolder setPosASL getPosASL _unit;
	};
	
} else {
	// Player's inside vehicle, drop helmet inside it
	_weaponHolder = vehicle _unit;
};


// Drop headgear
_weaponHolder addItemCargoGlobal [_headgear, 1];
removeHeadgear _unit;

// Drop NVG since it's mounted to helmet
private _hmd = hmd _unit;
if (_hmd isNotEqualTo "") then {
	_weaponHolder addItemCargoGlobal [_hmd, 1];
	_unit unassignItem (_hmd);
	_unit removeItem _hmd;
};

if (RAA_misc_debug) then {systemChat format ["[RAA_misc] Headgear %1 and HMD %2 dropped", _headgear, _hmd];};

/*
// Do animation
if (primaryWeapon _unit isNotEqualTo "" && random 100 > 50 && vehicle _unit isEqualTo _unit) then {
	[_unit, "Acts_Ambient_Rifle_Drop", 2] call ace_common_fnc_doAnimation;
};
*/

// Now let player know that they lost their headgear
if (_giveMessage > 0) then {
	private _msg = "";
	if (vehicle _unit isEqualTo _unit) then {
		// Player is on foot.
		_msg = selectRandom [
			"Your <t color='#ff0000'>helmet</t> fell to ground.",
			"You felt a hit on your head and your <t color='#ff0000'>helmet</t> was knocked off to ground!",
			"Your <t color='#ff0000'>helmet</t> was poorly strapped and fell to ground.",
			"Your head feels weirdly light, as if you didn't have a <t color='#ff0000'>helmet</t> anymore. It propably dropped on your feet."
		];
	} else {
		// Player is inside vehicle and helmet was dropped in vehicle's inventory
		_msg = selectRandom [
			"Your <t color='#ff0000'>helmet</t> fell to floor of vehicle.",
			"You got hit and your <t color='#ff0000'>helmet</t> shaked loose. It is now at floor of your vehicle.",
			"Your <t color='#ff0000'>helmet</t> was knocked off and is now rolling on vehicle's floor.."
		];
	};
	
//	[parseText "Your <t color='#ff0000'>weapon</t> was hit, causing a jam.", false, 20, 3] call ace_common_fnc_displayText;
	[parseText _msg, false, 20, 3] call ace_common_fnc_displayText;
};


