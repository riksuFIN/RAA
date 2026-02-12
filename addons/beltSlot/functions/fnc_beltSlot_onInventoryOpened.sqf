#include "script_component.hpp"
#include "..\defines.hpp"
/* File: fnc_beltSlot_onInventoryOpened.sqf
 * Author(s): riksuFIN
 * Description: Updates icons of items on belt when inventory is opened
 *
 * Called from: Extended EH // config.cpp
 * Local to:	Client
 * Parameter(s): NONE
 *
 Returns: NOTHING
 *
 * Example:	[] call RAA_misc_fnc_beltSlot_onInventoryOpened
*/


[] Spawn {
	disableSerialization;
	
	waitUntil { !isNull findDisplay 602 };
	
	private _display = findDisplay 602;		// Inventory display
	
	// If entire system is enabled via CBA settings update inventory icons, otherwise just delete them
	if (GVAR(enabled)) then {
		private _beltSlots = ACE_player getVariable [QGVAR(data), []];
		
		// Add beltSlots
		for "_i" from 0 to BELTSLOT_NUMBEROFSLOTS do {
			private _ctrl = _display displayCtrl ([IDC_RAA_BELTSLOT_SLOT1, IDC_RAA_BELTSLOT_SLOT2] select _i);
			private _image = (_beltSlots param [_i, []]) param [1, ""];
			private _text = (_beltSlots param [_i, []]) param [2, ""];
			
			
			lbClear _ctrl;
			
			
			if (_image isNotEqualTo "") then {
				private _index = _ctrl lbAdd _text;
				_ctrl lbSetPicture [_index, _image];
			};
		};
	} else {
		{
		private _ctrl = _display displayCtrl _x;
		_ctrl ctrlshow false;
		_ctrl ctrlcommit 0;
		} forEach [IDC_RAA_BELTSLOT_SLOT1, IDC_RAA_BELTSLOT_SLOT2, IDC_RAA_BELTSLOT_BACKGROUND1, IDC_RAA_BELTSLOT_BACKGROUND2];
		
	};
	
	//[COMPNAME, GVAR(debug), "INFO", format ["%1", GVAR(enabled)]] call EFUNC(common,debugNew);
	
};