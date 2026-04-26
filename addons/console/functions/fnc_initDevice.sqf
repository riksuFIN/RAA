#include "../script_component.hpp"
/* File: fnc_initDevice.sqf
 * Author(s): riksuFIN
 * Description: Use to initialize console on existing device. This turns object into useable device.
 *
 * Called from: fnc_handleCommand
 * Local to:	Client
 * Parameter(s):
 * 0:	Object to use <OBJECT>
 * 1:   Add basic filesystem structure <BOOL, default true>
 *
 Returns: 
 *
 * Example:	
 *	[] call RAA_console_fnc_fnc_init_device
*/
params [["_object", objNull], ["_addBasicFileSystem", true]];

if (isNull _object) exitWith {};

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

private _files = createHashMap;

_object setVariable [QGVAR(consoleFeed), []];			// This is array all existing text on console will be saved to.
_object setVariable [QGVAR(history), []];				// All inputted commands are saved in this array
_object setVariable [QGVAR(historyIndex), 0];			// Pressing arrow keys while typing returns last used command(s). This index saves which one is currently selected.
_object setVariable [QGVAR(files), _files];		// All files inside fileSystem array are saved inside this hashMap. Key is path to file as STRING, value is content as STRING. Can be executable code.
_object setVariable [QGVAR(currentPath), "/home"];		// Currently opened path (string)
_object setVariable [QGVAR(sudo), "password"];			// Sudo password. Master password for this computer
_object setVariable [QGVAR(passwordChallenge), false];	// If password challenge is currently running
_object setVariable [QGVAR(sudo_enabled), false];		// Sudo was successfully ran once, no need to run it again
_object setVariable [QGVAR(reserved), -1];				// Network ID of client currently using this device. Restricts so only one client can use this at time.

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


