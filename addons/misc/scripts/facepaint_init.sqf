/* File: facepaint_init.sqf
 * Author(s): riksuFIN
 * Description: Inits variable for facepaint script
 *
 * Called from: XEH_postInit.sqf
 * Local to: Client
 * Parameter(s):
 0:		
 1: 	
 2: 	
 3: 
 4:
 *
 Returns:
 *
 * Example:	[] execVM "RAA_misc\scripts\facepaint_init.sqf"
 */
params [["_player", ACE_player]];


private _allFaces = [
	"PersianHead_A3_04_a",
	"PersianHead_A3_04_l",
	"PersianHead_A3_04_sa",
	"GreekHead_A3_10_a",
	"GreekHead_A3_10_l",
	"GreekHead_A3_10_sa",
	"WhiteHead_22_a",
	"WhiteHead_22_l",
	"WhiteHead_22_sa",

	"CamoHead_White_01_F",
	"CamoHead_White_02_F",
	"CamoHead_White_03_F",
	"CamoHead_White_04_F",
	"CamoHead_White_05_F",
	"CamoHead_White_06_F",
	"CamoHead_White_07_F",
	"CamoHead_White_08_F",
	"CamoHead_White_09_F",
	"CamoHead_White_10_F",
	"CamoHead_White_11_F",
	"CamoHead_White_12_F",
	"CamoHead_White_13_F",
	"CamoHead_White_14_F",
	"CamoHead_White_15_F",
	"CamoHead_White_16_F",
	"CamoHead_White_17_F",
	"CamoHead_White_18_F",
	"CamoHead_White_19_F",
	"CamoHead_White_20_F",
	"CamoHead_White_21_F",
	"CamoHead_African_01_F",
	"CamoHead_African_02_F",
	"CamoHead_African_03_F",
	"CamoHead_Greek_01_F",
	"CamoHead_Greek_02_F",
	"CamoHead_Greek_03_F",
	"CamoHead_Greek_04_F",
	"CamoHead_Greek_05_F",
	"CamoHead_Greek_06_F",
	"CamoHead_Greek_07_F",
	"CamoHead_Greek_08_F",
	"CamoHead_Greek_09_F",
	"CamoHead_Asian_01_F",
	"CamoHead_Asian_02_F",
	"CamoHead_Asian_03_F",
	"CamoHead_Persian_01_F",
	"CamoHead_Persian_02_F",
	"CamoHead_Persian_03_F"
];


	// List of faces from which camouflaged face is randomly selected from
private _camoFaces = [
	"PersianHead_A3_04_a",
	"PersianHead_A3_04_l",
	"PersianHead_A3_04_sa",
	"GreekHead_A3_10_a",
	"GreekHead_A3_10_l",
	"GreekHead_A3_10_sa",
	"WhiteHead_22_a",
	"WhiteHead_22_l",
	"WhiteHead_22_sa",

	"CamoHead_White_01_F",
	"CamoHead_White_02_F",
	"CamoHead_White_03_F",
	"CamoHead_White_04_F",
	"CamoHead_White_05_F",
	"CamoHead_White_06_F",
	"CamoHead_White_07_F",
	"CamoHead_White_08_F",
	"CamoHead_White_09_F",
	"CamoHead_White_10_F",
	"CamoHead_White_11_F",
	"CamoHead_White_12_F",
	"CamoHead_White_13_F",
	"CamoHead_White_14_F",
	"CamoHead_White_15_F",
	"CamoHead_White_16_F",
	"CamoHead_White_17_F",
	"CamoHead_White_18_F",
	"CamoHead_White_19_F",
	"CamoHead_White_20_F",
	"CamoHead_White_21_F",
	"CamoHead_Greek_01_F",
	"CamoHead_Greek_02_F",
	"CamoHead_Greek_03_F",
	"CamoHead_Greek_04_F",
	"CamoHead_Greek_05_F",
	"CamoHead_Greek_06_F",
	"CamoHead_Greek_07_F",
	"CamoHead_Greek_08_F",
	"CamoHead_Greek_09_F"
];



if ((face _player) in _allFaces) then {	// Account for player already having painted face applied in profile
	_player setVariable ["RAA_misc_facepaint_faces", ["Kerry", face _player], [true, false] select isPlayer _player];
//	player setVariable ["RAA_misc_facepaintApplied", true];
} else {
	_player setVariable ["RAA_misc_facepaint_faces", [face _player, selectRandom _camoFaces], [true, false] select isPlayer _player];
//	player setVariable ["RAA_misc_facepaintApplied", false];
};