#include "../script_component.hpp"
#include "../defines.hpp"
/* File: fnc_onKeyUp.sqf
 * Author(s): riksuFIN
 * Description: Handles keyboard inside console's text input
 *
 * Called from: UI EH "onKeyUp"
 * Local to:	Client
 * Parameter(s):
 * 0:	
 *
 Returns: 
 *
 * Example:	
 *	[] call RAA_console_fnc_addLine
*/

params ["_control", "_key", "_shift", "_ctrl", "_alt"];

if !(_key in [DIK_RETURN, DIK_NUMPADENTER, DIK_UP, DIK_DOWN]) exitWith {};

disableSerialization;

switch (_key) do {
	case DIK_RETURN;
	case DIK_NUMPADENTER: {
		// Get text from text box
		private _inputText = ctrlText _control;

		// Check if password challenge is currrently running
		private _password = GVAR(currentConsoleObject) getVariable [QGVAR(passwordChallenge), false];
		if (_password isNotEqualTo false) then {

			// Password challenge is currently running
			if (_inputText isEqualTo _password || _inputText isEqualTo (GVAR(currentConsoleObject) getVariable [QGVAR(sudo), false])) then {
				["Password accepted", nil, false] call FUNC(addLine);
				_control ctrlSetText "";
				GVAR(currentConsoleObject) setVariable [QGVAR(passwordChallenge), false];

				// Password was correct, execute code user was trying to execute when they hit password challenge
				private _commandToExec = GVAR(currentConsoleObject) getVariable [QGVAR(passwordChallenge_commandToExec), ""];
				if (_commandToExec isNotEqualTo "") then {
					[_commandToExec] call FUNC(handleCommand);
				};
				[COMPNAME, GVAR(debug), "NOTE", format ["Password correct and executing: %1", _commandToExec]] call EFUNC(common,debugNew);

				GVAR(currentConsoleObject) setVariable [QGVAR(passwordChallenge_commandToExec), nil];

			} else {
				if (_inputText isEqualTo 'cancel') then {
					GVAR(currentConsoleObject) setVariable [QGVAR(passwordChallenge), false];
					GVAR(currentConsoleObject) setVariable [QGVAR(passwordChallenge_commandToExec), nil];
					_control ctrlSetText "";
				} else {
					["Password incorrect. Try again or type 'cancel'", nil, false] call FUNC(addLine);
				};

			};

		} else {
			// Password challenge is NOT running
			// Write this to console log and empty out writeable box
			[_inputText, nil, true] call FUNC(addLine);
			_control ctrlSetText "";

			// Save this so it can be recalled by user
			private _history = GVAR(currentConsoleObject) getVariable [QGVAR(history), []];

			// Do not save duplicates in a row
			if (_history param [count _history - 1, ""] isNotEqualTo _inputText) then {
				_history pushBack _inputText;
				GVAR(currentConsoleObject) setVariable [QGVAR(history), _history];
			};
			GVAR(currentConsoleObject) setVariable [QGVAR(historyIndex), 0];

			// Now send this command to be handled rest of way
			[_inputText] call FUNC(handleCommand);
		};
	};

	// UP arrow. Recalls history of inputted commands
	case DIK_UP: {
		private _history = GVAR(currentConsoleObject) getVariable [QGVAR(history), []];
		private _index = GVAR(currentConsoleObject) getVariable [QGVAR(historyIndex), 0];
		private _recallIndex = (_index - 1 max -1);
		GVAR(currentConsoleObject) setVariable [QGVAR(historyIndex), _recallIndex];
		private _recallValue = _history select _recallIndex max (count _history * -1);
		_control ctrlSetText _recallValue;
		[COMPNAME, GVAR(debug), "NOTE", format ["History index: %1/%2", _recallIndex, count _history]] call EFUNC(common,debugNew);
	};

	// DOWN arrow. Scrolls history of inputted commands
	case DIK_DOWN: {
		private _history = GVAR(currentConsoleObject) getVariable [QGVAR(history), []];
		private _index = GVAR(currentConsoleObject) getVariable [QGVAR(historyIndex), 0];
		private _recallIndex = (_index + 1 min -1);
		GVAR(currentConsoleObject) setVariable [QGVAR(historyIndex), _recallIndex];
		private _recallValue = _history select _recallIndex max (count _history * -1);
		_control ctrlSetText _recallValue;
		[COMPNAME, GVAR(debug), "NOTE", format ["History index: %1/%2", _recallIndex, count _history]] call EFUNC(common,debugNew);
	};

};

