class CfgVehicles {
	class Man;
	class CAManBase: Man {
		class ACE_SelfActions {
			
			class ACE_Equipment {
				class ace_overheating_UnJam {
					condition = QUOTE(!RAA_misc_hideACEUnjamming && ace_overheating_enabled && {QUOTE_1(_player) call ACE_overheating_fnc_canUnjam});
				};
				
				class RAA_camoFace_paint {
					displayName = "Apply face camouflage paint";
					condition = QUOTE([_player] call FUNC(facepaint_canApply));
				//    exceptions[] = {};
					statement = QUOTE(ARR_3(_player, 'ace_field_rations_drinkFromSourceHigh', 1) call ace_common_fnc_doAnimation; ARR_5(11, [_player], {_this select 0 call RAA_misc_fnc_facepaint}, {}, 'Applying Face Paint') call ace_common_fnc_progressBar);
				//	icon = QPATHTOF(pics\facepaint_icon);
					icon = QPATHTOF(pics\facepaint_icon.paa);
				};
				class RAA_camoFace_remove {
					displayName = "Wash away face camouflage paint";
					condition = "(face _player) isEqualTo (_player getVariable ['RAA_misc_facepaint_faces', []] param [1, ''])";
				//    exceptions[] = {};
					statement = QUOTE(ARR_3(_player, 'ace_field_rations_drinkFromSourceHigh', 1) call ace_common_fnc_doAnimation; ARR_5(11, [_player], {_this select 0 call RAA_misc_fnc_facepaint}, {}, 'Washing off Face Paint') call ace_common_fnc_progressBar);
					icon = QPATHTOF(pics\facepaint_icon.paa);
				};
				
				
				class RAA_chopDownTree {
					displayName = "Chop down a tree";
				//	condition = "[player, false] call FUNC(canChopDownTree)";
					condition = QUOTE(ARR_2(player, false) call FUNC(canChopDownTree));
				//    exceptions[] = {};
				//	statement = "[player, false] call FUNC(DoChopDownTree)";
					statement = QUOTE(ARR_2(player, false) call FUNC(action_chopDownTree));
					icon = QPATHTOF(pics\icon_cutting_tree.paa);
				};
				
				class RAA_delimbTree {
					displayName = "delimb a tree";
				//	condition = "[player, true] call FUNC(canChopDownTree)";
					condition = QUOTE(ARR_2(player, true) call FUNC(canChopDownTree));
				//    exceptions[] = {};
				//	statement = "[player, true] call FUNC(DoChopDownTree)";
					statement = QUOTE(ARR_2(player, true) call FUNC(action_chopDownTree));
					icon = QPATHTOF(pics\icon_cutting_tree.paa);
				};
				
				// Whistle
				class RAA_whistling {
					displayName = "Whistling";
					condition = QGVAR(whistling_enabled);
				//    exceptions[] = {};
					statement = "";
					icon = QPATHTOF(pics\icon_musical_note.paa);
					
					class RAA_whistling_1 {
						displayName = "Attention";
						condition = "true";
						statement = QUOTE(ARR_3(_player, 'RAA_misc_whistling_1', 150) call EFUNC(common,3dSound));
					};
					class RAA_whistling_2 {
						displayName = "Admire";
						condition = "true";
						statement = QUOTE(ARR_3(_player, 'RAA_misc_whistling_2', 150) call EFUNC(common,3dSound));
					};
					class RAA_whistling_3 {
						displayName = "Bird";
						condition = "true";
						statement = QUOTE(ARR_3(_player, selectRandom ARR_2('RAA_misc_whistling_3', 'RAA_misc_whistling_4'), 150) call EFUNC(common,3dSound));
					};
					class RAA_whistling_4 {
						displayName = "Short";
						condition = "true";
						statement = QUOTE(ARR_3(_player, 'RAA_misc_whistling_5', 150) call EFUNC(common,3dSound));
					};
					class RAA_whistling_5 {
						displayName = "Long";
						condition = "true";
						statement = QUOTE(ARR_3(_player, 'RAA_misc_whistling_6', 150) call EFUNC(common,3dSound));
					};
				};
			};
		};
	};
	
	
	
	
	// Shift action to drink/ fill bottles from ammo box
	class ReammoBox_F;
	class B_supplyCrate_F: ReammoBox_F {
		acex_field_rations_offset[] = {0, 0, 0.3};
	};
	
	
	// Motti flag
	class Flag_US_F;
	class RAA_Flag_Motti: Flag_US_F {
		author = "riksuFIN";
		scope = 2;
		scopeCurator = 2;
		displayName = "Flag (Motti)";
	//	model = "\a3\Structures_F\Mil\Flags\Mast_F.p3d";
	//	icon = "iconObject_circle";
		
		class EventHandlers {
		//	init = "(_this select 0) setFlagTexture 'PATHTOEF(RAA_common,pics\Motti_Flag.paa)'";
			init = "(_this select 0) setFlagTexture '\r\RAA\addons\common\pics\Motti_Flag.paa'";	// TODO Figure correct macro for this
		};
	};
	
	
	// Unfinished IED
	class Item_Base_F;
	class RAA_unfinished_ied_item: Item_Base_F {
		scope = 2;
		scopeCurator = 2;
		displayName = "Unfinished IED";
		author = "riksuFIN";
		vehicleClass = "Items";
		editorPreview = QPATHTOF(data\unfin_ied_render.paa);		// TODO: replace this with proper pic
//		model = "\r\misc\addons\RAA_ACEX_Additions\data\can_base.p3d";
		class TransportItems {
			class xx_RAA_unfinished_ied {
				name = "RAA_unfinished_ied";
				count = 1;
			};
		};
	};
	
	
	class RAA_facepaint_item: Item_Base_F {
		scope = 2;
		scopeCurator = 2;
		displayName = "Camouflage Face Paint";
		author = "riksuFIN";
		vehicleClass = "Items";
		editorPreview = QPATHTOF(data\camoFacePaintStick_render.paa);		// TODO: replace this with proper pic
//		model = "\r\misc\addons\RAA_ACEX_Additions\data\can_base.p3d";
		class TransportItems {
			class xx_RAA_facepaint {
				name = "RAA_facepaint";
				count = 1;
			};
		};
	};
	
	/*
	class RAA_mottinaatti_item: Item_Base_F {
		scope = 2;
		scopeCurator = 2;
		displayName = "Mottinaatti";
		author = "riksuFIN";
		vehicleClass = "Items";
		editorPreview = QPATHTOF(data\camoFacePaintStick_render.paa);		// TODO: replace this with proper pic
//		model = "\r\misc\addons\RAA_ACEX_Additions\data\can_base.p3d";
		class TransportItems {
			class xx_RAA_facepaint {
				name = "RAA_mottinaatti";
				count = 1;
			};
		};
	};
	*/
	
	
	// Create sound object for sound SFX defined in cfgSounds.hpp
	class Sound;
	class RAA_sound_axe_01: Sound {
		scope = 2;
		sound = "RAA_misc_axe_sfx";
		displayName = "[RAA] Chopping tree with Axe";
	};
	class RAA_sound_chainsaw_01: Sound {
		scope = 2;
		sound = "RAA_misc_chainsaw_sfx";
		displayName = "[RAA] Chainsaw";
	};
	#ifdef NOT_WORKSHOP
	class RAA_sound_radio_vdvSong: Sound {
		scope = 2;
		sound = "RAA_misc_radio_vdvSong_sfx";
		displayName = "[RAA] VDV Song (Radio Version)";
	};
	#endif
	class RAA_sound_radio_chill: Sound {
		scope = 2;
		sound = "RAA_misc_music_chill_sfx";
		displayName = "[RAA] Music: Chill";
	};
	class RAA_sound_radio_epic: Sound {
		scope = 2;
		sound = "RAA_misc_music_epic_sfx";
		displayName = "[RAA] Music: Epic";
	};
	class RAA_sound_radio_rock: Sound {
		scope = 2;
		sound = "RAA_misc_music_rock_sfx";
		displayName = "[RAA] Music: Rock";
	};
	
	
	
	
	
	
	
	/*
	// Tree trunk for tree chopping
	class CUP_Akat02S;
	class CUP_kmen_1_buk: CUP_Akat02S {
		
		// Dragging
		ace_dragging_canDrag = 1;  // Can be dragged (0-no, 1-yes)
		ace_dragging_dragPosition[] = {0, 1.5, 0};  // Offset of the model from the body while dragging (same as attachTo) (default: [0, 1.5, 0])
		ace_dragging_dragDirection = 0;  // Model direction while dragging (same as setDir after attachTo) (default: 0)
		
	};
	*/
	
	
	
	class Items_base_F;
	class Land_FMradio_F: Items_base_F {
		
		ace_dragging_canCarry = 1;  // Can be carried (0-no, 1-yes)
		ace_dragging_carryPosition[] = {0, 1.2, 0};  // Offset of the model from the body while dragging (same as attachTo) (default: [0, 1, 1])
		ace_dragging_carryDirection = 0;  // Model direction while dragging (same as setDir after attachTo) (default: 0)
		ace_cargo_size = 1;	// Can load in vehicles. Why? Why not?
		
		class ACE_Actions {
			class ACE_MainActions {
				displayName = "Interactions";
				selection = "";
				distance = 2;
				condition = "true";
				
				class GVAR(radio_off) {
					displayName = "Turn radio on";
					condition = "alive _target && !(_target getVariable [QQGVAR(radioPower), false])";
					exceptions[] = {};
				//	statement = "[_this, 1] call FUNC(handleRadioAction)";
					statement = "[_this, 1] remoteExec [QQFUNC(handleRadioAction), 2]";
				//	modifierFunction = "";
				//	icon = "\z\dance.paa";
					distance = 3;
				};
				
				class GVAR(radio_on) {
					displayName = "Turn radio off";
					condition = "alive _target && (_target getVariable [QQGVAR(radioPower), false])";
					exceptions[] = {};
				//	statement = "[_this, 0] call FUNC(handleRadioAction)";
					statement = "[_this, 0] remoteExec [QQFUNC(handleRadioAction), 2]";
				//	modifierFunction = "";
				//	icon = "\z\dance.paa";
					distance = 3;
					
					class GVAR(radio_change_station) {
						displayName = "Switch Station";
						condition = "true";
						exceptions[] = {};
					//	statement = "[_this, 2] call FUNC(handleRadioAction));
						statement = "[_this, 2] remoteExec [QQFUNC(handleRadioAction), 2]";
					//	modifierFunction = "";
					//	icon = "\z\dance.paa";
						distance = 3;
					};
					
				};
			};
		};
	};
	
	
	
	
	
	
};

