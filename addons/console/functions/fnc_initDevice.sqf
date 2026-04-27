#include "../script_component.hpp"
/* File: fnc_initDevice.sqf
 * Author(s): riksuFIN
 * Description: Use to initialize console on existing device. This turns object into useable device.
 *
 * Called from: fnc_handleCommand
 * Local to:	Global. Should be executed on every machine
 * Parameter(s):
 * 0:	Object to use <OBJECT>
 * 1:   Add basic filesystem structure <BOOL, default true>
 *
 Returns: 	Success
 *
 * Example:	
 *	[] call RAA_console_fnc_fnc_init_device
*/
params [["_object", objNull], ["_addBasicFileSystem", true], ["_usbSlots", 2]];

if (isNull _object) exitWith {false};

/*
--- FILESYSTEM's FORMATTING:
- Filesystem is flat hashmap.
- Each entry is a folder (directory)
- Key is each entry is path to that folder, including folder name, as a string
- Value is multi-level array:
[
	[METADATA], 
	[
		"FILEORFOLDER1",
		"FILEORFOLDER2,
		"etc etc"
	]
]

Metadata is as array as follows:
0: PASSWORD		<BOOL or STRING>	If false or nil folder is unlocked. If true only sudo can access. Providing password as string locks folder to that password OR sudo only.

--- FILES FORMATTING (hashmap where files are stored, not their actual contents)
- Key is full path to file, including filename and possible extension
- Value is array as follows:
[[METADATA], "FILE CONTENT AS STRING (CAN INCLUDE FORMATTING FOR TEXT)"]

Metadata is array as follows:
0: PASSWORD		<BOOL or STRING>	If false or nil folder is unlocked. If true only sudo can access. Providing password as string locks folder to that password OR sudo only.
*/


// In multiplayer values are only initalized on server and sent to clients on request
if (isServer) then {
	private _files = createHashMap;
	_object setVariable [QGVAR(consoleFeed), []];			// This is array all existing text on console will be saved to.
	_object setVariable [QGVAR(history), []];				// All inputted commands are saved in this array
	_object setVariable [QGVAR(historyIndex), 0];			// Pressing arrow keys while typing returns last used command(s). This index saves which one is currently selected.
	_object setVariable [QGVAR(files), _files];		// All files inside fileSystem array are saved inside this hashMap. Key is path to file as STRING, value is content as STRING. Can be executable code.
	_object setVariable [QGVAR(currentPath), "/home"];		// Currently opened path (string)
	_object setVariable [QGVAR(sudo), "password"];			// Sudo password. Master password for this computer
	_object setVariable [QGVAR(passwordChallenge), false];	// If password challenge is currently running
	_object setVariable [QGVAR(sudo_enabled), false];		// Sudo was successfully ran once, no need to run it again
	

	private _fileSystem = [["/", [[false], ["home", "mnt"]]], ["/mnt", [[false],[]]]];
	if (_addBasicFileSystem) then {
		_fileSystem pushBack ["/home", [[false], ["Desktop", "Documents", "Downloads", "Music", "Pictures", "Videos"]]];
		_fileSystem pushBack ["/home/Desktop", [["testPassword"], ["stuff.txt"]]];
		_fileSystem pushBack ["/home/Documents", [[false], ["secret.txt", "openFile.txt"]]];
		_fileSystem pushBack ["/home/Downloads", [[false],[]]];
		_fileSystem pushBack ["/home/Music", [[false],[]]];
		_fileSystem pushBack ["/home/Pictures", [[false],[]]];
		_fileSystem pushBack ["/home/Videos", [[false],[]]];

		_files set ["/home/Desktop/stuff.txt", [[false], "Welp! You found my very secret file, congrats!</br>Bet you won't find my ever more secret file elsewhere!"]];
		_files set ["/home/Documents/secret.txt", [["password"], "Oh no! How did you find this file, you brat!</br>Ok, you won!"]];
		_files set ["/home/Documents/openFile.txt", [[false], "Oh no! How did you find this file, you brat!</br>Ok, you won!"]];

	} else {
		_fileSystem pushBack [["/home", [[false],[]]]];
	};
	_object setVariable [QGVAR(fileSystem), createHashMapFromArray _fileSystem];          // This array makes up file paths for navigating.
};

// These variables should be present on every machine
_object setVariable [QGVAR(reserved), -1];				// Network ID of client currently using this device. Restricts so only one client can use this at time.


// Kick server and HC out
if !(hasInterface) exitWith {};

// Add ACE interaction
private _action = [QGVAR(main), "Open Console", "", {[_target] call FUNC(loadInterface)}, {true}, {}, [], [0, 0, 0], 2] call ace_interact_menu_fnc_createAction;
[_object, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

if (_usbSlots > 0) then {
	_action = [QGVAR(usb), "USB Slots", "", {}, {true}, {}, []] call ace_interact_menu_fnc_createAction;
	[_object, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

	for "_i" from 0 to (_usbSlots - 1) do {
		private _id = format ["usb_%1", _i];
		_action = [_id, format ["USB slot %1", _i + 1], "", {}, {true}, {}, [], [0, 0, 0], 2] call ace_interact_menu_fnc_createAction;
		[_object, 0, ["ACE_MainActions", QGVAR(usb)], _action] call ace_interact_menu_fnc_addActionToObject;

		_action = ["insert", "Insert..", "", {systemChat "Not implemented"}, {true}, {}, []] call ace_interact_menu_fnc_createAction;		// TODO: Add child actions for inserting items from inventory to this (USB sticks)
		[_object, 0, ["ACE_MainActions", QGVAR(usb), _id], _action] call ace_interact_menu_fnc_addActionToObject;

		_action = ["remove", "Remove", "", {systemChat "Not implemented"}, {true}, {}, []] call ace_interact_menu_fnc_createAction;			// TODO: Update "remove" text with name of USB stick
		[_object, 0, ["ACE_MainActions", QGVAR(usb), _id], _action] call ace_interact_menu_fnc_addActionToObject;
	};
};


/*	ace_interact_menu_fnc_createAction
 * Arguments:
 * 0: Action name <STRING>
 * 1: Name of the action shown in the menu <STRING>
 * 2: Icon file path or Array of icon file path and hex color ("" for default icon) <STRING or ARRAY>
 * 3: Statement <CODE>
 * 4: Condition <CODE>
 * 5: Insert children code <CODE> (default: {})
 * 6: Action parameters <ANY> (default: [])
 * 7: Position (Position array, Position code or Selection Name) <ARRAY or CODE or STRING> (default: {[0, 0, 0]})
 * 8: Distance <NUMBER> (default: 2)
 * 9: Other parameters [showDisabled,enableInside,canCollapse,runOnHover,doNotCheckLOS] <ARRAY> (default: all false)
 * 10: Modifier function <CODE> (default: {})
 */
/*	ace_interact_menu_fnc_addActionToObject
 * Arguments:
 * 0: Object the action should be assigned to <OBJECT>
 * 1: Type of action, 0 for actions, 1 for self-actions <NUMBER>
 * 2: Parent path of the new action <ARRAY> (Example: `["ACE_SelfActions", "ACE_Equipment"]`)
 * 3: Action <ARRAY>
 */



true
