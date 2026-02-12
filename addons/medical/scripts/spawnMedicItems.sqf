/* File: spawnMedicitems.sqf
 * Author(s): riksuFIN
 * Description: This script is used once per game to spawn new medical items to _player medics
 					This is used to make sure new required items are available even in old missions
 *
 * Called from: 
 * Local to: 
 * Parameter(s):
 0:	
 1:	
 2:	
 3:	
 4:	
 *
 Returns:
 *
 * Example:	[] call fileName
*/
params [["_player", player]];


private _zafw_present = (!isNil "zafw_endinprogress");


if (RAA_ACEA_addItemToMedic_defib > 0) then {
	if (isNil "zafw_medical_loadout_defib") then {
		// Make sure _player does not already have either item
		if (!("RAA_AED" in items _player) && !("RAA_defibrillator" in items _player)) then {
			if (RAA_ACEA_debug) then {systemChat "[RAA_ACEA] Adding defib or AED to medic _player";};
			private _itemToAdd = "RAA_defibrillator";
			switch (RAA_ACEA_addItemToMedic_defib) do {
				case (1): {
					_itemToAdd = "RAA_defibrillator";
				};
				case (2): {
					_itemToAdd = "RAA_AED";
				};
			};
			
			// Use ZAFW function if possible, otherwise revert to vanilla methods
			if (_zafw_present) then {
				[_itemToAdd, 1, true, true, true] call zafw_fnc_spawnitem;
			} else {
				_player addItem _itemToAdd;
			};
		};
	};
};



if (RAA_ACEA_addItemToMedic_naloxone > 0) then {
	if !("RAA_naloxone" in items _player) then {
		
		if (RAA_ACEA_debug) then {systemChat format ["[RAA_ACEA] Adding Naloxone x%1", RAA_ACEA_addItemToMedic_naloxone];};
		
		// Use ZAFW to spawn items if possible
		if (_zafw_present) then {
			["RAA_naloxone", RAA_ACEA_addItemToMedic_naloxone, true, true, true] call zafw_fnc_spawnitem;
		} else {
			for "_x" from 1 to RAA_ACEA_addItemToMedic_naloxone do {
				_player addItem "RAA_naloxone";
			};
		};
	};
};

