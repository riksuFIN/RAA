class CfgVehicles {
	class Man;
	class CAManBase: Man {
		class ACE_SelfActions {
		//	class ACE_Equipment {
			class RAA_beltSlot {
					displayName = "Belt Slots";
					condition = QUOTE(GVAR(enabled) && GVAR(enabled_interactMenu));
					statement = "";
				//	showDisabled = 0;
				//	exceptions[] = {"isNotInside", "isNotSwimming", "isNotSitting"};
					exceptions[] = {};
					icon = QPATHTOF(pics\icon_belt.paa);
				
				class RAA_beltSlot_moveToBelt {
					displayName = "Move item to belt";
					condition = QUOTE(call FUNC(beltSlot_canMoveToBelt));
				//    exceptions[] = {};
					statement = "";
				//	icon = QPATHTOF(pics\icon_cutting_tree);
					insertChildren = QUOTE(call FUNC(beltSlot_getChildrens));
				};
				
				class RAA_belSlot_item1 {
					displayName = "ERROR";
					condition = QUOTE(_player getVariable [ARR_2(QQGVAR(data),[])] param [ARR_2(0,[])] isNotEqualTo []);
				//    exceptions[] = {};
					statement = QUOTE(0 call FUNC(beltSlot_doMoveFrombelt));
					icon = "";
					modifierFunction = QUOTE([ARR_5(_this select 3,0,_player,""%1.."",true)] call FUNC(beltSlot_actionModifier));
					//modifierFunction = QUOTE([ARR_2(_this,0)] call FUNC(beltSlot_actionModifier));
				
					class RAA_beltSlot_moveFromBelt {
						displayName = "Move to inventory";
						condition = QUOTE(0 call FUNC(beltSlot_canMoveFrombelt));
					//    exceptions[] = {};
						statement = QUOTE(0 call FUNC(beltSlot_doMoveFrombelt));
						icon = "";
					};

					class RAA_beltSlot_moveToHead {
						displayName = "Move to head";
						condition = QUOTE(GVAR(enabled_headgearAction) && {_player getVariable [ARR_2(QQGVAR(data),[])] param [ARR_2(0,[])] param [ARR_2(6,0)] isEqualTo 605});
						statement = QUOTE([ARR_3(0,_player,3)] call FUNC(beltSlot_doMoveFrombelt));
						icon = "";
					};

					class RAA_beltSlot_dropToGround {
						displayName = "Drop to ground";
						condition = QUOTE(true);
						statement = QUOTE([ARR_3(0,ACE_player,9)] call FUNC(beltSlot_doMoveFrombelt));
						icon = "";
					};
				};
				
				class RAA_belSlot_item2 {
					displayName = "ERROR";
					condition = QUOTE(_player getVariable [ARR_2(QQGVAR(data),[])] param [ARR_2(1,[])] isNotEqualTo []);
				//    exceptions[] = {};
					statement = QUOTE(1 call FUNC(beltSlot_doMoveFrombelt));
					icon = "";
					modifierFunction = QUOTE([ARR_5(_this select 3,1,_player,""%1.."",true)] call FUNC(beltSlot_actionModifier));
				

					class RAA_beltSlot_moveFromBelt {
						displayName = "Move to inventory";
						condition = QUOTE(1 call FUNC(beltSlot_canMoveFrombelt));
						exceptions[] = {};
						statement = QUOTE(1 call FUNC(beltSlot_doMoveFrombelt));
						icon = "";
					};

					class RAA_beltSlot_moveToHead {
						displayName = "Move to head";
						condition = QUOTE(GVAR(enabled_headgearAction) && {_player getVariable [ARR_2(QQGVAR(data),[])] param [ARR_2(1,[])] param [ARR_2(6,0)] isEqualTo 605});
						statement = QUOTE([ARR_3(1,_player,3)] call FUNC(beltSlot_doMoveFrombelt));
						icon = "";
					};

					class RAA_beltSlot_dropToGround {
						displayName = "Drop to ground";
						condition = QUOTE(true);
					//    exceptions[] = {};
						statement = QUOTE([ARR_3(1,ACE_player,9)] call FUNC(beltSlot_doMoveFrombelt));
						icon = "";
					};
				};
			};
				
//			};
			
			class ace_field_rations {
				class RAA_misc_drinkFromBeltItem {
					displayName = "Drink from item on belt";
					condition = "true";
				//	exceptions[] = {};
					exceptions[] = {"notOnMap", "isNotInside"};
					statement = "";
					showDisabled =0;
					icon = QPATHTOF(pics\icon_belt.paa);
					insertChildren = QUOTE(call FUNC(beltSlot_getDrinkableChildrens));
				};
				
			};
			
			class ACE_Explosives {
				class RAA_beltSlot_placeExplosive {
					displayName = "Place (From Belt)";
					condition = "true";
					statement = "";
					exceptions[] = {};
					icon = QPATHTOF(pics\icon_belt.paa);
					insertChildren = QUOTE(ACE_player call FUNC(placeExplosive_getChildren));
				};
			};
		};

		class ACE_Actions {
			class RAA_beltSlot_slot1 {
					displayName = "Grab N/A";
					condition = QUOTE(GVAR(enabled) && {_target getVariable [ARR_2(QQGVAR(data),[])] param [ARR_2(0,[])] isNotEqualTo []});
					statement = QUOTE([ARR_3(0,_target,_player)] call FUNC(takeFromBelt));
					//icon = QPATHTOF();
					modifierFunction = QUOTE([ARR_5(_this select 3,0,_target,""Grab %1"",false)] call FUNC(beltSlot_actionModifier));
					position = QUOTE([ARR_3(_target,'leftupleg',-0.10)] call DFUNC(getGrabPosition));
					distance = 2;
			};
			class RAA_beltSlot_slot2 {
					displayName = "Grab N/A";
					condition = QUOTE(GVAR(enabled) && {_target getVariable [ARR_2(QQGVAR(data),[])] param [ARR_2(1,[])] isNotEqualTo []});
					statement = QUOTE([ARR_3(1,_target,_player)] call FUNC(takeFromBelt));
					//icon = QPATHTOF();
					modifierFunction = QUOTE([ARR_5(_this select 3,1,_target,""Grab %1"",false)] call FUNC(beltSlot_actionModifier));
					position = QUOTE([ARR_3(_target,'rightupleg',0.10)] call DFUNC(getGrabPosition));
					distance = 2;
			};
		};


	};

};
