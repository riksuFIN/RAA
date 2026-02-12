#include "script_component.hpp"
/* File: fnc_createDialog_selectSide.sqf
 * Author(s): riksuFIN
 * Description: description
 *
 * Called from: 
 * Local to: 
 * Parameter(s):
 0:	Function to call once "OK" is pressed on dialog	<STRING>
 1:	Pass through params	<ANYTHING>
 		
		Function called is passed following params:
		0: Selected side ID (0= east, 1= west, 2= ind, 3= civ)
		1: Pass through params <ARRAY, default false>
		2: Show number of players in each side <BOOL, default false>
 *
 Returns:
 *		Nothing
 * Example:	["RAA_fnc_someCoolFunction"] call RAA_firesA_fnc_createDialog_selectSide
*/

params ["_functionToCall", ["_passThroughParams", []], ["_showPlayers", false]];



private _textEast = "East";
private _textWest = "West";
private _textInd = "Independent";
private _textCiv = "Civilian";

if (_showPlayers) then {
/*
	private _playersEast = east countSide allPlayers;
	private _playersWest = west countSide allPlayers;
	private _playersInd = independent countSide allPlayers;
	private _playersCiv = civilian countSide allPlayers;
	*/
	private _playersEast = playersNumber east;
	private _playersWest = playersNumber west;
	private _playersInd = playersNumber independent;
	private _playersCiv = playersNumber civilian;
	
	_textEast = format ["East (%1 players)", _playersEast];
	_textWest = format ["West (%1 players)", _playersWest];
	_textInd = format ["Independent (%1 players)", _playersInd];
	_textCiv = format ["Civilian (%1 players)", _playersCiv];
	
};



["Select side to edit",
	[ // CONTENT
		["LIST",
		"Which side's artillery to edit?",
			[
				[0,1,2,3],
				[
					[_textEast,"","\A3\3den\Data\Displays\Display3DEN\PanelRight\side_east_ca.paa"],
					[_textWest,"","\A3\3den\Data\Displays\Display3DEN\PanelRight\side_west_ca.paa"],
					[_textInd,"","\A3\3den\Data\Displays\Display3DEN\PanelRight\side_guer_ca.paa"],
					[_textCiv,"", "\A3\3den\Data\Displays\Display3DEN\PanelRight\side_civ_ca.paa"]
				],
				0,
				4
				
			]
		]
		
		
	], { // ON CONFIRM CODE
		(_this select 1) params ["_functionToCall", "_passThroughParams"];
		[_this select 0 select 0, _passThroughParams] call _functionToCall;
		
		if (RAA_firesA_debug) then {systemChat format ["[RAA_firesA] selectSide called code with side %1", _this select 0 select 0]; RAA_firesA_debugFeed = _this;};
		
	},{	// On cancel code
	},[	// Arguments
	_functionToCall,
	_passThroughParams
	]
] call zen_dialog_fnc_create;
