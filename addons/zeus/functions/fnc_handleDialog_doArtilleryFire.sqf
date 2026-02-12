#include "script_component.hpp"
/* File: fnc_handleDialog_doArtilleryFire.sqf
 * Author(s): riksuFIN
 * Description: Lets Zeus select location for artillery strike and then calls it
 *
 * Called from: createDialog_doArtilleryFire (Zeus module)
 * Local to:	Client (Zeus)
 * Parameter(s):
 * 0:	Params from dialog
 * 1:	Object
 * 2:	
 * 3:	
 * 4:	
 *
 Returns: Nothing
 *
 * Example:	
 *	[] call fileName
*/

#define COLOR_IN_RANGE [0, 0.9, 0, 1]
#define COLOR_OUT_OF_RANGE [0.9, 0, 0, 1]


params ["_paramsDialog", "_object"];
_paramsDialog params ["_magazine", "_numberOfRounds", "_refillAmmo", "_startDelay"];

if (RAA_zeus_debug) then {
	systemChat format ["[RAA_zeus] %1", _this];
	RAA_debug = _this;
};






if (_refillAmmo) then {
	_object setVehicleAmmo 1;
};


private _modifierFunction = {
	params ["_vehicle", "_position", "_params", "_visuals"];
	_params params ["_magazine"];
	
	//if (ASLtoAGL _position inRangeOfArtillery [_vehicles, _magazine]) then {
	private _eta = _vehicle getArtilleryETA [ASLtoAGL _position, _magazine];
	if (_eta > 0) then {
		_visuals set [0, format ["ETA: %1 s", floor _eta]];
		_visuals set [3, COLOR_IN_RANGE];
	} else {
		_visuals set [0, "OUT OF RANGE"];
		_visuals set [3, COLOR_OUT_OF_RANGE];
	};
};





[
	_object, 
	{
		/*
		if (RAA_zeus_debug) then {
			systemChat format ["[RAA_zeus] %1", _this];
			RAA_debug = _this;
		};
		*/
		params ["_successful", "_vehicle", "_position", "_params"];
		_params params ["_magazine", "_numberOfRounds", "_startDelay"];
		if (_successful) then {
			
			private _eta = _vehicle getArtilleryETA [ASLtoAGL _position, _magazine];
			
			if (_eta > 0) then {
				
				[	{
						params ["_vehicle", "_position", "_magazine", "_numberOfRounds"];
						
					//	[zen_common_doArtilleryFire, [_vehicle, ASLtoAGL _position, _magazine, _numberOfRounds], _vehicle] call CBA_fnc_targetEvent;
						_vehicle doArtilleryFire [ASLtoAGL _position, _magazine, _numberOfRounds];
						if (RAA_zeus_debug) then {systemChat format ["[RAA_zeus] %1 firing %2 rounds of type %3", _vehicle, _numberOfRounds, _magazine];};
					}, [
						_vehicle, _position, _magazine, _numberOfRounds
					],
					_startDelay
				] call CBA_fnc_waitAndExecute;
				
				
				
			} else {
				["Target out of range!"] call zen_common_fnc_showMessage;
			};
		};
	},
	[_magazine, _numberOfRounds, _startDelay],
	"Target location",
	nil,
	nil,
	nil,
	_modifierFunction
] call zen_common_fnc_selectPosition











