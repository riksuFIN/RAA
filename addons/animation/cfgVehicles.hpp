class CfgVehicles {
	class Man;
	class CAManBase: Man {
		class ACE_SelfActions {
			class RAA_animationsSelfMenu {
				displayName = "Animations Menu";
				condition = QUOTE(alive player && RAA_animation_enableAnimMenu);
            //    exceptions[] = {};
			//	statement = "[player] call RAA_animation_createAnimList";
				statement = QUOTE(ARR_1(player) call FUNC(createAnimList));
				icon = QPATHTOF(pics\icon_dance.paa);
				
				class RAA_animationsSelfMenu_clear {
					displayName = "Clear Animation";
					condition = "alive player && RAA_animation_enableAnimMenu";
				//    exceptions[] = {};
					statement = QUOTE(ARR_3(player, '', 2) call ace_common_fnc_doAnimation; player setVariable ARR_2('RAA_animation_loopAnim',-1));
				//	icon = "\z\dance.paa";
				};
			};
		};
	};
};

