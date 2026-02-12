#include "script_component.hpp"
/* File: fnc_babel_handleDialog_configureSide.sqf
 * Author(s): riksuFIN
 * Description: Handles setting spoken languages for each side, as defined in Zeus module
 *
 * Called from: Zeus module "Babel: Configure Sides"
 * Local to:	Global (remoteExecuted from module)
 * Parameter(s):
 * 0:	Data containing spoken language ID's for each side

 *
 Returns: 
 *
 * Example:		(should not be manually called)
 *	[] call RAA_zeus_fnc_babel_handleDialog_configureSide
*/
if !(hasInterface) exitWith {};
	
params ["_languages_west", "_languages_east", "_languages_ind", "_languages_civ"];


switch (side player) do {
	case (west): {
		if (count _languages_west > 0) then {
			_languages_west call acre_api_fnc_babelSetSpokenLanguages;
		};
	};
	case (east): {
		if (count _languages_east > 0) then {
			_languages_east call acre_api_fnc_babelSetSpokenLanguages;
		};
	};
	case (independent): {
		if (count _languages_ind > 0) then {
			_languages_ind call acre_api_fnc_babelSetSpokenLanguages;
		};
	};
	case (civilian): {
		if (count _languages_civ > 0) then {
			_languages_civ call acre_api_fnc_babelSetSpokenLanguages;
		};
	};
};



if (GVAR(debug)) then {systemChat format ["[RAA_zeus] Babel: SpokenLanguages are: %1", ACRE_SPOKEN_LANGUAGES];};