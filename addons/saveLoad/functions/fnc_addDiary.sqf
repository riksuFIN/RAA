#include "script_component.hpp"
/* File: fnc_addDiary.sqf
 * Author(s): riksuFIN
 * Description: Gathers together facts about saveLoad system settings and puts them visible on map.
 					Calling this function while diary already exists will update it.
 *
 * Called from: 
 * Local to:	Caller
 * Parameter(s):
 * 0:	
 * 1:	
 * 2:	
 * 3:	
 * 4:	
 *
 Returns: 
 *
 * Example:	
 *	[] call RAA_saveLoad_fnc_addDiary
*/

if (isNil QGVAR(diarySubject)) then {
	GVAR(diarySubject) = player createDiarySubject [QGVAR(diary),"SaveLoad"];
};


private _moduleSave = entities QGVAR(module_save_main) param [0, objNull];
private _moduleLoad = entities QGVAR(module_load_main) param [0, objNull];


private _recordSave = "";
private _recordLoad = "";


/*
// ================== SAVING ==========================
if (isNull _moduleSave) then {
	_recordSave = "Saving system is <font color='#FF00FF'>disabled</font> on this mission.";
} else {
	_recordSave = _recordSave + "Automatic saving on mission end is " + (["<font color='#FF00FF'>Disabled</font> ", "<font color='#00CC00'>Enabled"] select (_moduleSave getVariable [QGVAR(saveTrigger), 1] in [true, 1]));
	_recordSave = _recordSave + "There are  <font color='#0000FF'>" + str (count entities QGVAR(module_save_additionalSearchLocation) + 1) + "</font> saving area(s)<br/><br/>";
	_recordSave = _recordSave + "Saving of player's personal loadouts is " + (["<font color='#E60000'>disabled</font> <br/><br/>", "<font color='#00CC00'>enabled.</font><br/><br/>", "<font color='#00CC00'>enabled withing saving area(s)</font>.<br/><br/>"] select (_moduleSave getVariable [QGVAR(loadouts), true] in [true, 1]));

	if (_moduleSave getVariable QGVAR(deleteDeadsLoadout) in [true, 1]) then {
		_recordSave = _recordSave + "Loadout of any player currently dead or in spectator during saving <font color='#E60000'>will not</font> be saved and previously saved loadout will be deleted.<br/><br/>";
	};
	if (_moduleSave getVariable QGVAR(saveVehicles) in [true, 1]) then {
		_recordSave = _recordSave + "Vehicles located within any of saving areas will be saved";
		_recordSave = _recordSave + ([". Ammo levels of those vehicles <font color='#ff0000'>will not</font> be saved, but fuel will.<br/><br/>", ", including their ammo and fuel levels.<br/><br/>"] select (_moduleSave getVariable [QGVAR(saveVehicles_ammo), false]));
		_recordSave = _recordSave + "Skins of vehicles " + (["<font color='#ff0000'>will not</font> be saved and will be reset to default or randomized on load. <br/><br/>", "will be saved exactly how they are now.<br/><br/>"] select (_moduleSave getVariable [QGVAR(saveVehicles_textures), false] in [true, 1]));
	} else {
			_recordSave = _recordSave + "Vehicles will <font color='#ff0000'>never</font> be saved.<br/><br/>";
	};

	_recordSave = _recordSave + (["Loose equipment from crates and vehicles will not be saved. <br/><br/>", "Loose equipment located inside ammo crates, vehicle inventories and on ground within any of saving areas will be fully saved.<br/><br/>"] select (_moduleSave getVariable [QGVAR(ammoCrates), true] in [true, 1]));
};

// ================== LOADING ==========================
if (isNull _moduleLoad) then {
	_recordLoad = "Loading saved data is <font color='#ff0000'>disabled</font> on this mission.";
} else {
	_recordLoad = _recordLoad + "Invidual player loadouts will " + (["<font color='#ff0000'>not</font> be loaded from save.<br/><br/>", "be loaded on mission start.<br/><br/>"] select (_moduleLoad getVariable [QGVAR(loadouts), true] in [true, 1]));
	
	if (_moduleLoad getVariable [QGVAR(fieldRations), true] in [true, 1] && ["ace_field_rations"] call ace_common_fnc_isModLoaded) then {
	_recordLoad = _recordLoad + "Player's hunger and thirst will also be loaded.<br/><br/>";
	};

	_recordLoad = _recordLoad + "Players will start from " + (["base.<br/><br/>", "where they were last time.<br/><br/>"] select (_moduleLoad getVariable [QGVAR(playerpos), true] in [true, 1]));

	if (_moduleLoad getVariable QGVAR(loadVehicles) in [true, 1]) then {
		_recordLoad = _recordLoad + "Vehicles will be loaded from save, ";
		_recordLoad = _recordLoad + (["but their <font color='#ff0000'>fuel levels will not.</font> <br/>", "including their fuel levels.<br/>"] select (_moduleLoad getVariable [QGVAR(vehicles_fuel), false] in [true, 1]));
		_recordLoad = _recordLoad + "Their ammo levels " + (["are reset to full.<br/>", "are exactly how they were<br/>"] select (_moduleLoad getVariable [QGVAR(vehicles_ammo), false] in [true, 1]));
		_recordLoad = _recordLoad + "Their damage " + (["was repaird off-screen. All vehicles are like brand-new now.<br/><br/>", "is how it was.<br/><br/>"] select (_moduleLoad getVariable [QGVAR(vehicles_damage), false] in [true, 1]));
	} else {
		_recordLoad = _recordLoad + "Vehicles will <font color='#ff0000'>not</font> be loaded from save.";
	};
		_recordLoad = _recordLoad + "Loose equipment from vehicle inventories, boxes and ground " + (["is <font color='#ff0000'>not</font> loaded. Lost in the void.<br/>", "is loaded and neatly organized into set of crates at spawn location.<br/>"] select (_moduleLoad getVariable [QGVAR(equipment), false] in [true, 1]));
};
*/





// ================== SAVING ==========================
if (isNull _moduleSave) then {
	_recordSave = "Saving system is disabled on this mission.";
} else {
	_recordSave = _recordSave + "Saving system is setup to " + (["save with manual activation ", "save automatically on mission end"] select (_moduleSave getVariable [QGVAR(saveTrigger), 1] in [true, 1]));
	_recordSave = _recordSave + "with  " + str (count entities QGVAR(module_save_additionalSearchLocation) + 1) + " saving area(s)<br/><br/>";
	_recordSave = _recordSave + "Player's personal loadouts will " + (["<font color='#ff0000'>not</font> be saved <br/>", "always be fully saved.<br/><br/>", "be fully saved if player is within saving area.<br/><br/>"] select (_moduleSave getVariable [QGVAR(loadouts), true] in [true, 1]));

	if (_moduleSave getVariable QGVAR(deleteDeadsLoadout) in [true, 1]) then {
		_recordSave = _recordSave + "Loadout of any player currently dead or in spectator during saving <font color='#ff0000'>will not</font> be saved and previously saved loadout will be deleted.<br/><br/>";
	};
	if (_moduleSave getVariable QGVAR(saveVehicles) in [true, 1]) then {
		_recordSave = _recordSave + "Vehicles located within any of saving areas will be saved";
		_recordSave = _recordSave + ([". Ammo levels of those vehicles <font color='#ff0000'>will not</font> be saved, but fuel will.<br/><br/>", ", including their ammo and fuel levels.<br/><br/>"] select (_moduleSave getVariable [QGVAR(saveVehicles_ammo), false]));
		_recordSave = _recordSave + "Skins of vehicles " + (["<font color='#ff0000'>will not</font> be saved and will be reset to default or randomized on load. <br/><br/>", "will be saved exactly how they are now.<br/><br/>"] select (_moduleSave getVariable [QGVAR(saveVehicles_textures), false] in [true, 1]));
	} else {
			_recordSave = _recordSave + "Vehicles will <font color='#ff0000'>never</font> be saved.<br/><br/>";
	};

	_recordSave = _recordSave + (["Loose equipment from crates and vehicles will not be saved. <br/><br/>", "Loose equipment located inside ammo crates, vehicle inventories and on ground within any of saving areas will be fully saved.<br/><br/>"] select (_moduleSave getVariable [QGVAR(ammoCrates), true] in [true, 1]));
};

// ================== LOADING ==========================
if (isNull _moduleLoad) then {
	_recordLoad = "Loading saved data is <font color='#ff0000'>disabled</font> on this mission.";
} else {
	_recordLoad = _recordLoad + "Invidual player loadouts will " + (["<font color='#ff0000'>not</font> be loaded from save.<br/><br/>", "be loaded on mission start.<br/><br/>"] select (_moduleLoad getVariable [QGVAR(loadouts), true] in [true, 1]));
	
	if (_moduleLoad getVariable [QGVAR(fieldRations), true] in [true, 1] && ["ace_field_rations"] call ace_common_fnc_isModLoaded) then {
	_recordLoad = _recordLoad + "Player's hunger and thirst will also be loaded.<br/><br/>";
	};

	_recordLoad = _recordLoad + "Players will start from " + (["base.<br/><br/>", "where they were last time.<br/><br/>"] select (_moduleLoad getVariable [QGVAR(playerpos), true] in [true, 1]));

	if (_moduleLoad getVariable QGVAR(loadVehicles) in [true, 1]) then {
		_recordLoad = _recordLoad + "Vehicles will be loaded from save, ";
		_recordLoad = _recordLoad + (["but their <font color='#ff0000'>fuel levels will not.</font> <br/>", "including their fuel levels.<br/>"] select (_moduleLoad getVariable [QGVAR(vehicles_fuel), false] in [true, 1]));
		_recordLoad = _recordLoad + "Their ammo levels " + (["are reset to full.<br/>", "are exactly how they were<br/>"] select (_moduleLoad getVariable [QGVAR(vehicles_ammo), false] in [true, 1]));
		_recordLoad = _recordLoad + "Their damage " + (["was repaird off-screen. All vehicles are like brand-new now.<br/><br/>", "is how it was.<br/><br/>"] select (_moduleLoad getVariable [QGVAR(vehicles_damage), false] in [true, 1]));
	} else {
		_recordLoad = _recordLoad + "Vehicles will <font color='#ff0000'>not</font> be loaded from save.";
	};
		_recordLoad = _recordLoad + "Loose equipment from vehicle inventories, boxes and ground " + (["is <font color='#ff0000'>not</font> loaded. Lost in the void.<br/>", "is loaded and neatly organized into set of crates at spawn location.<br/>"] select (_moduleLoad getVariable [QGVAR(equipment), false] in [true, 1]));
};

// ================== General info ==========================
private _info = "This mission is equipped with SaveLoad system designed to help mission maker save vehicles, equipment and player's personal loadouts and load them to another mission later on.<br/>
<br/>
This system is part of <execute expression='copyToClipboard ""https://steamcommunity.com/sharedfiles/filedetails/?id=3008701827""; systemChat ""Link copied to clipboard""'>Riksu's Arma Additions</execute> mod.<br/>
Documentation for using this feature can be found in <execute expression='copyToClipboard ""https://trello.com/c/SDeGULGu""; systemChat ""Link copied to clipboard""'>Trello.</execute>";


player createDiaryRecord [QGVAR(diary), ["Load", _recordLoad]];
player createDiaryRecord [QGVAR(diary), ["Save", _recordSave]];
player createDiaryRecord [QGVAR(diary), ["Info", _info]];