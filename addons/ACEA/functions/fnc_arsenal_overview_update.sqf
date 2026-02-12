#include "script_component.hpp"
#include "..\defines.hpp"
/* File: fnc_arsenal_overview_update.sqf
 * Author(s): riksuFIN
 * Description: Updates Overview list in Arsenal display
 *
 * Called from: Loadout changed EH while arsenal is open
 * Local to:	Client
 * Parameter(s):	NONE
 *
 Returns: NOTHING
 *
*/

_this Spawn {
	
	disableSerialization;
//	waitUntil { !isNull findDisplay 1127001 };


//	(_this select 0) params [["_display", GETUVAR(arsenalOverView_display,displayNull), [displayNull]]];
	private _display = GETUVAR(arsenalOverView_display,displayNull);
	
	
	
	//if (RAA_ACEA_debug) then {systemChat format ["[RAA_ACEA] %1", _this];};
	
	//_display = findDisplay 1127001;
	private _ctrl = _display displayCtrl 5687;
	if (_display isEqualTo displayNull) exitWith {
		if (RAA_ACEA_debug) then {systemChat "[RAA_ACEA] Null display!";};
	};
	
	
	if (RAA_ACEA_debug) then {
		systemChat format ["[RAA_ACEA] Ctrl %1 display %2", _ctrl, _display];
	//	RAA_ACEA_debugFeed = _this;
	};
	
	// Clear list so that we can re-fill it
	lbClear _ctrl;
	
	// Get sorted list of items in player's inventory
	private _inventory = call FUNC(arsenal_overview_getInventoryItems);
	
	// Loop through array
	private _end = (count _inventory) - 1;
	private _classname = "";
	private _itemName = "";
	private _itemCount = 0;
	private _picture = "";
	private _isSpacer = false;
	private _cfgWeapons = configFile >> "cfgWeapons";
	private _cfgMagazines = configFile >> "CfgMagazines";
	for "_x" from 0 to _end step 2 do {
		
		_classname = _inventory param [_x, "NO ITEM"];
		_itemCount = _inventory param [_x + 1, "ERROR: "];
		
		if ((_classname select [0, 2]) isEqualTo "  ") then {
			
			_isSpacer = true;
			_itemName = " ";
		} else {
			_isSpacer = false;
			// Find pretty name and picture for item
			_picture = getText (_cfgWeapons >> _classname >> "picture");
			_itemName = getText (_cfgWeapons >> _classname >> "displayName");
			if (_itemName isEqualTo "") then {
				_picture = getText (_cfgMagazines >> _classname >> "picture");
				_itemName = getText (_cfgMagazines >> _classname >> "displayName");
			};
		};
	//	picture = "\hlc_wp_MP5\tex\ui\gear_mp510_x_ca";
		
		// Format item texts
		private _displayName = "";
		if (_itemCount <= 1) then {
			
			// CBA setting to let player show x1 's in list
			if (GVAR(arsenal_overview_disableZeros)) then {
				
				// x1 's are disabled, always hide them
				_displayName = format ["    %1",_itemName];
			} else {
				
				// If x1 's are shown we still dont want to show those on spacer rows, so we need to identify them
				if (_isSpacer) then {
					_displayName = "  ";
				} else {
					_displayName = format ["%1x %2",_itemCount, _itemName];
				};
			};
			
		} else {
			
			// Item's count is greater than 1, always show count
			_displayName = format ["%1x %2",_itemCount, _itemName];
		};
		
		private _index = _ctrl lbAdd _displayName;
		if !(_isSpacer) then {
			_ctrl lbSetPicture [_index, _picture];
		};
		
	//	_ctrl lbSetData [_index, _className];
	//	_ctrl lbSetPictureRight [_index, _picture];
	//	_ctrl lbSetTextRight [_index, _itemName];
	//	_ctrl lbSetTooltip [_index, _classname];
		
		
	};
};

