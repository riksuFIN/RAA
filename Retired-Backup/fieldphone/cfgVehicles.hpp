class cfgVehicles {
	
	class Land_IPPhone_01_olive_F;
	class RAA_fieldphone: Land_IPPhone_01_olive_F {
		
		displayName = "Field Telephone (Olive)";
		
		// Carrying
		ace_dragging_canCarry = 1;  // Can be carried (0-no, 1-yes)
		ace_dragging_carryPosition[] = {0, 1.2, 0};  // Offset of the model from the body while dragging (same as attachTo) (default: [0, 1, 1])
		ace_dragging_carryDirection = 0;  // Model direction while dragging (same as setDir after attachTo) (default: 0)
		
		// Cargo
		ace_cargo_size = 0.5;  // Cargo space the object takes
		ace_cargo_canLoad = 1;  // Enables the object to be loaded (1-yes, 0-no)
		ace_cargo_noRename = 0;  // Blocks renaming object (1-blocked, 0-allowed)
		ace_cargo_blockUnloadCarry = 0; // Blocks object from being automatically picked up by player on unload
		
		class AcreRacks {
			class Rack_1 {
				displayName = "Telephone Cable";      // Name displayed in the interaction menu
				shortName = "CABLE";                   // Short name displayed on the HUD. Maximum of 5 characters
				componentName = "ACRE_VRC110";        // Able to mount a PRC152.	ACRE_VRC111 for ACRE_PRC148
				allowedPositions[] = {"external"}; // Who can configure the radio and open the radio GUI. Same wildcards as the intercom. It also allows transmitting/receiving
				disabledPositions[] = {};             // Who cannot access the radio (default: {})
				defaultComponents[] = {};             // Use this to attach simple components like Antennas, they will first attempt to fill empty connectors but will overide existing connectors. Not yet fully implemented. (default: {})
				mountedRadio = "ACRE_PRC152";                    // Predefined mounted radio (default: "", meaning none)
				isRadioRemovable = 0;                 // Radio can be removed (default: 0)
				intercom[] = {};                      // Radio not wired to any intercom. All units in intercom can receive/send transmittions (ACE3 interaction menu) but they cannot manipulate the radio (GUI interface) (default: {})
			};
		};
	
		// Init vehicle rack
		class EventHandlers {
		//	init = QUOTE(_this call FUNC(phone_init));
			init = QUOTE(ARR_3({_this select 0 call FUNC(phone_init)}, [_this], 5) call CBA_fnc_waitAndExecute);
			deleted = QUOTE(if (ARR_1(_this select 0) call acre_api_fnc_areVehicleRacksInitialized) then {ARR_2(_this select 0, 99) call FUNC(connectCable)});
		};
		
		// Add ACE actions
		class ACE_Actions {
			class ACE_MainActions {
				displayName = "Interactions";
				selection = "";
				distance = 3;
				condition = "true";
				
				class ACRE_sys_rack_racks {
					displayName = "";
					selection = "";
					distance = 3;
					condition = QUOTE(GVAR(debug));
				};
				
				
			//	class GVAR(use) {
				class RAA_stuff_use {
					displayName = "Pick up earpiece";
					condition = "(_target getVariable ARR_2(QQGVAR(connected), -1) >= 0) && !(_target getVariable ARR_2(QQGVAR(mountedRadioID), QUOTE(NULL)) in ACRE_ACCESSIBLE_RACK_RADIOS)";

//					condition = QUOTE((_target getVariable ARR_2(QQGVAR(connected), -1) >= 0) && !(_target getVariable ARR_2(QQGVAR(mountedRadioID), QUOTE(NULL)) in ACRE_ACCESSIBLE_RACK_RADIOS));
					exceptions[] = {};
					statement = QUOTE(ARR_2(_target, true) call FUNC(use));
				//	modifierFunction = "";
				//	icon = "\z\dance.paa";
					distance = 3;
				};
				class GVAR(stop_using) {
					displayName = "Return earpiece";
					condition = "(_target getVariable ARR_2(QQGVAR(connected), -1) >= 0) && _target getVariable ARR_2(QQGVAR(mountedRadioID), ""NULL"") in ACRE_ACCESSIBLE_RACK_RADIOS";
					exceptions[] = {};
					statement = QUOTE(ARR_2(_target, false) call FUNC(use));
				//	modifierFunction = "";
				//	icon = "\z\dance.paa";
					distance = 3;
				};
				
				
				
				
				
				
				class GVAR(ring_start) {
					displayName = "Start ringing";
					condition = QUOTE(!(_target getVariable ARR_2(QQGVAR(ringing), false)) && _target getVariable ARR_2(QQGVAR(connected), -1)  >= 0);
					exceptions[] = {};
					statement = QUOTE(ARR_2(_target, true) call FUNC(doRing));
				//	modifierFunction = "";
				//	icon = "\z\dance.paa";
					distance = 3;
				};
				class GVAR(ring_stop) {
					displayName = "Stop ringing";
					condition = QUOTE(_target getVariable ARR_2(QQGVAR(ringing), false));
				//	condition = QUOTE(alive _target && !(_target getVariable [QQGVAR(radioPower), false]));
					exceptions[] = {};
					statement = QUOTE(ARR_2(_target, false) call FUNC(doRing));
				//	modifierFunction = "";
				//	icon = "\z\dance.paa";
					distance = 3;
				};
				
				class GVAR(connect_normal) {
					displayName = "Start deploying cable";
					condition = QUOTE(!(GVAR(simpleConnect)) && _target getVariable ARR_2(QQGVAR(connected), -1) < 0);
					statement = QUOTE(ARR_2(_target, -1) call FUNC(connectCable));
				//	modifierFunction = "";
				//	icon = "\z\dance.paa";
					distance = 3;
				};
				class GVAR(connect_simple) {
					displayName = "Connect cable to..";
					condition = QUOTE(GVAR(simpleConnect) && _target getVariable ARR_2(QQGVAR(connected), -1) < 0);
				//	statement = QUOTE(ARR_2(_target, -1) call FUNC(connectCable));
					statement = "";
				//	modifierFunction = "";
				//	icon = "\z\dance.paa";
					distance = 3;
					insertChildren = QUOTE(call FUNC(connect_insertChildren));
				};
				
				
				class GVAR(connectCableToThis) {
					displayName = "Connect cable to this";
					condition = QUOTE((_player getVariable ARR_2(QQGVAR(deployingCable), -1)) >= 0);
					exceptions[] = {};
					statement = QUOTE(ARR_2(_target, _player getVariable QQGVAR(deployingCable)) call FUNC(connectCable));
				//	modifierFunction = "";
				//	icon = "\z\dance.paa";
					distance = 3;
				};
				
				
				class GVAR(settings_menu) {
					displayName = "Settings";
					condition = "true";
					exceptions[] = {};
					statement = "";
				//	modifierFunction = "";
				//	icon = "\z\dance.paa";
					distance = 3;
					
					class GVAR(setting_muteOff) {
						displayName = "Unmute ringing sound";
						condition = QUOTE((_target getVariable ARR_2(QQGVAR(muted), false)));
						exceptions[] = {};
						statement = QUOTE(_target setVariable ARR_3(QQGVAR(muted), false, true));
					//	modifierFunction = "";
					//	icon = "\z\dance.paa";
					};
					class GVAR(setting_muteOn) {
						displayName = "Mute ringing sound";
						condition = QUOTE(!(_target getVariable ARR_2(QQGVAR(muted), false)));
						exceptions[] = {};
						statement = QUOTE(_target setVariable ARR_3(QQGVAR(muted), true, true));
					//	modifierFunction = "";
					//	icon = "\z\dance.paa";
					};
					
					class GVAR(setting_speakerOff) {
						displayName = "Switch loudspeaker Off";
						condition = QUOTE((_target getVariable ARR_2(QQGVAR(speaker), GVAR(speaker_default))));
						exceptions[] = {};
						statement = QUOTE(ARR_2(_target, false) call FUNC(setting_speaker));
					//	modifierFunction = "";
					//	icon = "\z\dance.paa";
					};
					class GVAR(setting_speakerOn) {
						displayName = "Switch loudspeaker On";
						condition = QUOTE(!(_target getVariable ARR_2(QQGVAR(speaker), GVAR(speaker_default))));
						exceptions[] = {};
						statement = QUOTE(ARR_2(_target, true) call FUNC(setting_speaker));
					//	modifierFunction = "";
					//	icon = "\z\dance.paa";
					};
					
					
				};	// End of settings menu
				
				class GVAR(disconnect) {
					displayName = "Disconnect cable";
					condition = QUOTE(_target getVariable ARR_2(QQGVAR(connected), -1)  >= 0);
					statement = "";
					modifierFunction = QUOTE(_this call FUNC(actionModifier));
				//	icon = "\z\dance.paa";
					distance = 3;
					
					class GVAR(disconnect_confirm) {
						displayName = "Confirm disconnect cable";
						condition = "true";
						statement = QUOTE(ARR_2(_target, 99) call FUNC(connectCable));
					//	modifierFunction = "";
					//	icon = "\z\dance.paa";
						distance = 3;
					};
				};
				
				class GVAR(pickup) {
					displayName = "Pack Up";
					condition = QUOTE(_target getVariable ARR_2(QQGVAR(connected), -1)  < 0);
				//	statement = QUOTE(if (player canAdd 'RAA_fieldphone_item') then {player addItem 'RAA_fieldphone_item'; deleteVehicle (_this select 0)};);
					statement = QUOTE(ARR_3(_target, 'RAA_fieldphone_item', _player) call EFUNC(common,pickUpItem));
				//	modifierFunction = QUOTE(_this call FUNC(actionModifier));
				//	icon = "\z\dance.paa";
					distance = 3;
				};
				
				
			};
		};
	};
	
	class Man;
	class CAManBase: Man {
		class ACE_SelfActions {
			class GVAR(stopDeployingCable) {
				displayName = "Cancel cable deployment";
				condition = QUOTE((_player getVariable ARR_2(QQGVAR(deployingCable), -1)) >= 0);
				//    exceptions[] = {};
			//	statement = "ARR_1(player) call RAA_animation_createAnimList";
				statement = QUOTE(player setVariable ARR_2(QQGVAR(deployingCable), nil););
			};
			
			
			class ACE_Equipment {
				class GVAR(deploy) {
					displayName = "Deploy Field Telephone";
					condition = "'RAA_fieldphone_item' in items _player";
				//    exceptions[] = {};
					statement = QUOTE(ARR_3('RAA_fieldphone_item', 'RAA_fieldphone', player) call EFUNC(common,deployItem));
				//	icon = QPATHTOF(pics\icon_aed_action);
				};
			};
		};
	};
	
	
	
	
	
	
	
	
	
	class Sound;
	class RAA_sound_phone_ringing: Sound {
		scope = 2;
		sound =  QGVAR(phone_ringing_sfx);
		displayName = "[RAA] Phone ringing";
	};
	
	
	
	
	
	/*
	class Land_MedicalTent_01_base_F;
	class RAA_testCube: Land_MedicalTent_01_base_F {
		author = "riksuFIN";
		displayName = "TESTIKUUTIO";
	//	hiddenSelectionsTextures[] = {"\r\misc\addons\RAA_static\pics\camo_net_snow.paa"};
		model = QPATHTOF(data\testCube_2m.p3d);
		scope = 2;
		scopeCurator = 2;
		
	};
	*/
	
	
	
	
	
	
};