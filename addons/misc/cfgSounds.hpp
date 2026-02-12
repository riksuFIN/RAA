class CfgSounds
{
	sounds[] = {};
	class RAA_misc_chainsaw {
		name = "Chainsaw";
		sound[] = { QPATHTOF(sounds\chainsaw.ogg), 2, 1, 1000 }; // filename, volume, pitch, distance (optional)
		titles[] = {};
	};
	class RAA_misc_axe {
		name = "Cutting tree with axe";
		sound[] = { QPATHTOF(sounds\axe_cutting_tree.ogg), 2, 1, 400 }; // filename, volume, pitch, distance (optional)
		titles[] = {};
	};
	class RAA_misc_axe_long {
		name = "Cutting tree with axe (long version)";
	//	sound[] = { "\r\misc\addons\RAA_misc\sounds\axe_cutting_tree_long.ogg", 2, 1, 400 }; // filename, volume, pitch, distance (optional)
		sound[] = { QPATHTOF(sounds\axe_cutting_tree_long.ogg), 2, 1, 400 }; // filename, volume, pitch, distance (optional)
		titles[] = {};
	};
	
	class RAA_misc_dialog_holyShit {
		name = "[Dialog] Holy shit";
	//	sound[] = { "\r\misc\addons\RAA_misc\sounds\axe_cutting_tree_long.ogg", 2, 1, 400 }; // filename, volume, pitch, distance (optional)
		sound[] = { QPATHTOF(sounds\holy.ogg), 3, 1, 30 }; // filename, volume, pitch, distance (optional)
		titles[] = {};
	};
	class RAA_misc_dialog_noShoot {
		name = "[Dialog] No shoot";
	//	sound[] = { "\r\misc\addons\RAA_misc\sounds\axe_cutting_tree_long.ogg", 2, 1, 400 }; // filename, volume, pitch, distance (optional)
		sound[] = { QPATHTOF(sounds\noShoot.ogg), 3, 1, 30 }; // filename, volume, pitch, distance (optional)
		titles[] = {};
	};
	
	class RAA_misc_dialog_nooo {
		name = "[Dialog] Nooooo";
	//	sound[] = { "\r\misc\addons\RAA_misc\sounds\axe_cutting_tree_long.ogg", 2, 1, 400 }; // filename, volume, pitch, distance (optional)
		sound[] = { QPATHTOF(sounds\noooo.ogg), 3, 1, 30 }; // filename, volume, pitch, distance (optional)
		titles[] = {};
	};
	
	class RAA_misc_dialog_perkele {
		name = "[Dialog] Perkele";
	//	sound[] = { "\r\misc\addons\RAA_misc\sounds\axe_cutting_tree_long.ogg", 2, 1, 400 }; // filename, volume, pitch, distance (optional)
		sound[] = { QPATHTOF(sounds\perkele.ogg), 4, 1, 30 }; // filename, volume, pitch, distance (optional)
		titles[] = {};
	};
	
	class RAA_misc_radio_static {
		name = "[Effect] Radio Static";
	//	sound[] = { "\r\misc\addons\RAA_misc\sounds\axe_cutting_tree_long.ogg", 2, 1, 400 }; // filename, volume, pitch, distance (optional)
		sound[] = { QPATHTOF(sounds\radio_static.ogg), 1, 1, 30 }; // filename, volume, pitch, distance (optional)
		titles[] = {};
	};
	
	// Whistling
	class RAA_misc_whistling_1 {
		name = "[Whistle] Call";
		sound[] = { QPATHTOF(sounds\whistle_1.ogg), 4, 1, 150 }; // filename, volume, pitch, distance (optional)
		titles[] = {};
	};
	class RAA_misc_whistling_2 {
		name = "[Whistle] Admire";
		sound[] = { QPATHTOF(sounds\whistle_2.ogg), 4, 1, 150 }; // filename, volume, pitch, distance (optional)
		titles[] = {};
	};
	class RAA_misc_whistling_3 {
		name = "[Whistle] Varying 1";
		sound[] = { QPATHTOF(sounds\whistle_3.ogg), 4, 1, 150 }; // filename, volume, pitch, distance (optional)
		titles[] = {};
	};
	class RAA_misc_whistling_4 {
		name = "[Whistle] Varying 2";
		sound[] = { QPATHTOF(sounds\whistle_4.ogg), 4, 1, 150 }; // filename, volume, pitch, distance (optional)
		titles[] = {};
	};
	class RAA_misc_whistling_5 {
		name = "[Whistle] Long";
		sound[] = { QPATHTOF(sounds\whistle_5.ogg), 4, 1, 150 }; // filename, volume, pitch, distance (optional)
		titles[] = {};
	};
	class RAA_misc_whistling_6 {
		name = "[Whistle] Very long";
		sound[] = { QPATHTOF(sounds\whistle_6.ogg), 4, 1, 150 }; // filename, volume, pitch, distance (optional)
		titles[] = {};
	};
	
	
	
	
	
	
	
	
};


class CfgSFX {
	class RAA_misc_axe_sfx {
		name = "Cutting tree with axe";
						// Path,	Volume, Pitch, maxDistance, Propability, minDelay, midDelay, maxDelay
	//	sound1[] = {"\r\misc\addons\RAA_misc\sounds\axe_01.ogg", 3, 1.0, 400, 0.1, 1, 2, 6};
		sound1[] = {QPATHTOF(sounds\axe_01.ogg), 3, 1.0, 400, 0.1, 1, 2, 6};
		sound2[] = {QPATHTOF(sounds\axe_02.ogg), 3, 1.0, 400, 0.1, 1, 2, 6};
		sound3[] = {QPATHTOF(sounds\axe_03.ogg), 3, 1.0, 400, 0.1, 1, 2, 6};
		sound4[] = {QPATHTOF(sounds\axe_04.ogg), 3, 1.0, 400, 0.1, 1, 2, 6};
		sound5[] = {QPATHTOF(sounds\axe_05.ogg), 3, 1.0, 400, 0.1, 1, 2, 6};
		sound6[] = {QPATHTOF(sounds\axe_06.ogg), 3, 1.0, 400, 0.1, 1, 2, 6};
		sound7[] = {QPATHTOF(sounds\axe_07.ogg), 3, 1.0, 400, 0.1, 1, 2, 6};
		sound8[] = {QPATHTOF(sounds\axe_08.ogg), 3, 1.0, 400, 0.05, 2, 3, 6};
		sound9[] = {QPATHTOF(sounds\axe_09.ogg), 3, 1.0, 400, 0.1, 1, 2, 6};
		sounds[] = {"sound1", "sound2", "sound3", "sound4", "sound5", "sound6", "sound7", "sound8", "sound9"};
		empty[] = {"", 0, 0, 0, 0, 0, 0, 0};
	};
	class RAA_misc_chainsaw_sfx {
		name = "Cutting tree with chainsaw";
		sound1[] = {QPATHTOF(sounds\chainsaw_02.ogg), 4, 1.0, 1300, 1, 1, 3, 10};
		sounds[] = {"sound1"};
		empty[] = {"", 0, 0, 0, 0, 0, 0, 0};
	};
	
	#ifdef NOT_WORKSHOP
	class RAA_misc_radio_vdvSong_sfx {
		name = "VDV Song (Radio Version)";
		sound1[] = {QPATHTOF(sounds\VDV_radioVersion.ogg), 4, 1.0, 75, 1, 1, 3, 10};
		sounds[] = {"sound1"};
		empty[] = {"", 0, 0, 0, 0, 0, 0, 0};
	};
	#endif
	
	class RAA_misc_music_chill_sfx {
		name = "[Music] Chill";
		sound1[] = {QPATHTOF(sounds\music_chill_02.ogg), 1, 1.0, 75, 1, 1, 3, 8};
		sound2[] = {QPATHTOF(sounds\music_chill_03.ogg), 1, 1.0, 75, 1, 1, 3, 8};
		sounds[] = {"sound1", "sound2"};
		empty[] = {"", 0, 0, 0, 0, 0, 0, 0};
	};
	
	class RAA_misc_music_epic_sfx {
		name = "[Music] Epic";
		sound1[] = {QPATHTOF(sounds\music_epic_01.ogg), 1, 1.0, 75, 1, 1, 3, 8};
		sound2[] = {QPATHTOF(sounds\music_epic_02.ogg), 1, 1.0, 75, 1, 1, 3, 8};
		sound3[] = {QPATHTOF(sounds\music_epic_03.ogg), 1, 1.0, 75, 1, 1, 3, 8};
		sounds[] = {"sound1", "sound2", "sound3"};
		empty[] = {"", 0, 0, 0, 0, 0, 0, 0};
	};
	
	class RAA_misc_music_rock_sfx {
		name = "[Music] Rock";
		sound1[] = {QPATHTOF(sounds\music_rock_01.ogg), 1, 1.0, 75, 1, 1, 3, 8};
		sound2[] = {QPATHTOF(sounds\music_rock_02.ogg), 1, 1.0, 75, 1, 1, 3, 8};
		sounds[] = {"sound1", "sound2"};
		empty[] = {"", 0, 0, 0, 0, 0, 0, 0};
	};
	
	
	
	
	
	
};



