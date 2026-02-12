#include "script_component.hpp"
#include "..\defines.hpp"
/* File: fnc_arsenal_description.sqf
 * Author(s): riksuFIN
 * Description: Adds currently selected item's description from config to text box in ACE Arsenal
 *
 * Called from: EH
 * Local to:	Client
 * Parameter(s):
 * 0:	
 * 1:	
 * 2:	
 *
 Returns: Nothing
 *
 * Example:	
 *	[] call RAA_ACEA_fnc_arsenal_description
*/
params [["_display", displayNull], "", "", ["_itemCfg", ""]];
private _ctrl = _display displayCtrl 5097;

// Hide box if no item selected
if (_itemCfg isEqualTo "") exitWith {
	_ctrl ctrlshow false;
	_ctrl ctrlcommit 0.3;
};

private _ctrl = _display displayCtrl 5097;
private _text = getText (_itemCfg >> "descriptionShort");

if (_text isEqualTo "") then {
	_ctrl ctrlshow false;
	_ctrl ctrlcommit 0.3;
} else {
	_ctrl ctrlshow true;
	_ctrl ctrlSetStructuredText parseText format ["<t color='#b2b2b2'><t align='center'>Item Description<br/><t align='left'><t color='#FFFFFF'>%1", _text];
//	_ctrl ctrlSetStructuredText parseText format ["<t color='#5A595A'><t align='center'>Item Description<br/><t align='left'><t color='#FFFFFF'>%1", _text];
//	_ctrl ctrlSetStructuredText parseText _text;
	
	// Expand text box if necessary
	private _h = ctrlTextHeight _ctrl;
	_ctrl ctrlSetPositionH _h;
	_ctrl ctrlcommit 0;
	
	[COMPNAME, GVAR(debug), "INFO", format ["Description box H: %1, minH %2", _h, ARSENALDESC_DEF_H]] call EFUNC(common,debugNew);
	//QUOTE(30 * GRID_H);
};



