#include "script_component.hpp"
/* File: fnc_damageableItems_doDamage.sqf
 * Author(s): riksuFIN
 * Description: Handle damaging items when taking hit
 *
 * Called from: fnc_damageableItems_onHit
 * Local to:	Client
 * Parameter(s):
 * 0:	Effected unit <OBJECT, default player>
 * 1:	
 * 2:	
 * 3:	
 * 4:	
 *
 Returns: 
 *
 * Example:	
 *	[player] call RAA_misc_fnc_damageableItems_doDamage
*/

params [["_unit", player]];


// First we collect all of our candidates in one array to pick one from
// Only certain inventory items, defined by type, are damageable, so we have to filter this
private _candidateItems = [];

private _cfgWeaponsBase = configFile >> "CfgWeapons";

// Get items on belt if feature is enabled
private _beltItems = [];
if !(isNil "RAA_beltSlot_fnc_beltSlot_doMoveToBelt") then {
	_beltItems = [_unit] call EFUNC(beltSlot,beltSlot_getItems);
};


// Include radios and consumeables
private _enabled_ACRE = (["acre_main"] call ace_common_fnc_isModLoaded);
private _enabled_TFAR = (["TFAR_core"] call ace_common_fnc_isModLoaded);
private _enabled_ACEX = (["acex_field_rations"] call ace_common_fnc_isModLoaded);
{

	// Handle radios and consumeables
	switch true do {
		case (_enabled_ACRE && {_x call acre_api_fnc_isRadio}) : {if (GVAR(damageableItems_filter_radios)) then {_candidateItems pushBack _x}};
		case (_enabled_TFAR && {_x call TFAR_fnc_isRadio}) : {if (GVAR(damageableItems_filter_radios)) then {_candidateItems pushBack _x}};
		case (_enabled_ACEX && {getNumber (_cfgWeaponsBase >> _x >> "acex_field_rations_thirstQuenched") > 0}) : {if (GVAR(damageableItems_filter_consum)) then {_candidateItems pushBack _x}};
		default {_candidateItems pushBack _x};
	};

/*		DELETE THIS
	// Radios
	private _exit = false;
	if (_enabled_ACRE) then {
		if (_x call acre_api_fnc_isRadio) then {
			_exit = true;
			_candidateItems pushBack _x;
		};
	};
	if (_enabled_TFAR) then {
		if (_x call TFAR_fnc_isRadio) then {
			_exit = true;
			_candidateItems pushBack _x;
		};
	};
	if (_exit) exitWith {};

	// Drinkables
	if (getNumber (_cfgWeaponsBase >> _x >> "acex_field_rations_thirstQuenched")) > 0) exitWith {
		if (GVAR(damageableItems_filter_consum)) then {
			_candidateItems pushBack _x;
		};
	};

	// All other items are automatically pushed to candidate list as well. This would include things like bandages, repair kits and other misc items.
	_candidateItems pushBack _x;
*/	
} forEach ((_unit call ace_common_fnc_uniqueItems) + _beltItems);

// And magazines. This also includes grenades
if (GVAR(damageableItems_filter_mags)) then {
	
	_candidateItems append (magazinesAmmoFull _unit);
};

if (GVAR(debug)) then {RAA_debug1 = _candidateItems};		// DELETE THIS

// Do lottery for great winner
private _winnerItem = selectRandom _candidateItems;

if (GVAR(debug)) then {systemChat format ["[RAA_misc] Item to damage: %1", _winnerItem];};



//  Handle each different type of item
private _replacerItem = "";
private _cfgMagazinesBase = configFile >> "CfgMagazines";
switch (true) do {
	// ----- MAGAZINES -----------
	case (_winnerItem isEqualType []): {		// Magazines in lottery array are in form of array
//	case (getNumber (_cfgMagazinesBase >> _winnerItem >> "count") > 0): {
//	case (_winnerItem call BIS_fnc_itemType isEqualTo "Magazine"): {
		
		private _magClassname = _winnerItem select 0;
		private _ammoCountFull = _winnerItem select 1;
		
		// Add 50 % chance for mag being completely destroyed
		private _ammoCount = 0;
		if (random 100 > 50) then {
			_ammoCount = round (random [0, _ammoCountFull*0.3, _ammoCountFull*0.8]);
		};
		
		[_unit, _magClassname, ["", _magClassname] select (_ammoCount > 1), _ammoCount, _ammoCountFull] call FUNC(damageableItems_deleteItem);
		
		// Tell player that something happend to their gear
		if (_unit isEqualTo ace_player) then {
			private _prettyName = getText (_cfgMagazinesBase >> _magClassname >> "displayName");
			if (_ammoCount > 1) then {
				[parseText format ["You felt something on your chest.<br/><br/>You inspect your gear and see that <t color='#ff0000'>%1</t> is damaged by bullet. You manage to save <t color='#ff0000'>%2</t> cartridges, rest are too damaged.", _prettyName, _ammoCount], false, 20, 3] call ace_common_fnc_displayText;
			} else {
				[parseText format ["You felt something on your chest.<br/><br/>You inspect your gear and see that <t color='#ff0000'>%1</t> took a good hit, being badly damaged and unuseable. You throw it away.", _prettyName], false, 18, 3] call ace_common_fnc_displayText;
			};
		};
	};
	
	
	case (getNumber (_cfgWeaponsBase >> _winnerItem >> "acex_field_rations_thirstQuenched") > 0): {
		// ----- DRINKABLES -----------
		switch (_winnerItem) do {
			case ("ACE_Canteen");
			case ("ACE_Canteen_Half"): {
				_replacerItem = "RAA_canteen_broken";
			};
			case ("ACE_WaterBottle");
			case ("ACE_WaterBottle_Half");
			case ("RAA_sodaBottle");
			case ("RAA_sodaBottle_mixed");
			case ("RAA_sodaBottle_mixed_half");
			case ("RAA_sodaBottle_half"): {
				_replacerItem = "RAA_waterBottle_broken";
			};
			case ("ACE_Can_Spirit");
			case ("ACE_Can_Franta");
			case ("ACE_Can_RedGull"): {
				_replacerItem = "RAA_can_broken";
			};
			
			default {
				_replacerItem = "RAA_waterBottle_broken";
			};
		};
		
		[_unit, _winnerItem, _replacerItem] call FUNC(damageableItems_deleteItem);
		
		// Tell player that something happend to their gear
		if (_unit isEqualTo ace_player) then {
			private _prettyName = getText (_cfgWeaponsBase >> _winnerItem >> "displayName");
			[parseText format ["You feel weirdly wet. <br/><br/>You look down and see that <t color='#ff0000'>%1</t> has taken a hit and is draining empty", _prettyName], false, 15, 5] call ace_common_fnc_displayText;
		};
	};
	
	
	// ----- RADIOS -----------
	case ([_winnerItem] call acre_api_fnc_isRadio): {
		switch ([_winnerItem] call acre_api_fnc_getBaseRadio) do {
			case ("ACRE_PRC152"): {_replacerItem = "RAA_PRC152_broken"};
			case ("ACRE_PRC77"): {_replacerItem = "RAA_PPRC77_broken"};
			case ("ACRE_PRC117F"): {_replacerItem = "RAA_PRC117F_broken"};
			case ("ACRE_PRC148"): {_replacerItem = "RAA_PRC148_broken"};
			case ("ACRE_PRC343"): {_replacerItem = "RAA_PRC343_broken"};
			case ("ACRE_SEM52SL"): {_replacerItem = "RAA_SEM52SL_broken"};
			case ("ACRE_SEM70"): {_replacerItem = "RAA_SEM70_broken"};
			case ("ACRE_BF888S"): {_replacerItem = "RAA_BF888S_broken"};
			
			default {
				_replacerItem = "RAA_PRC148_broken";
			};
		};
		
		
		[_unit, _winnerItem, _replacerItem] call FUNC(damageableItems_deleteItem);
		
		// Tell player that something happend to their gear
		if (_unit isEqualTo ace_player) then {
			private _prettyName = getText (_cfgWeaponsBase >> _winnerItem >> "displayName");
			[parseText format ["You felt a hit on your vest.<br/><br/> You see your <t color='#ff0000'>%1</t> has a clean hole through it.<br/><br/>Great for cooling, not good for functionality.", _prettyName], false, 15, 5] call ace_common_fnc_displayText;
		};
	};
	
	
		// ----- OTHER -----------
	default {
		[_unit, _winnerItem] call FUNC(damageableItems_deleteItem);
		
		// Tell player that something happend to their gear
		if (_unit isEqualTo ace_player) then {
			private _prettyName = getText (_cfgWeaponsBase >> _winnerItem >> "displayName");
				[parseText format ["You felt something on your chest.<br/><br/>You inspect your gear and see that <t color='#ff0000'>%1</t> took a hit, being badly damaged and unuseable. You throw it away.", _prettyName], false, 18, 3] call ace_common_fnc_displayText;
		};
	};
	
};
