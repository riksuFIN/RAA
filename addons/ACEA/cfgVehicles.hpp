/// Sample character config ///
class cfgVehicles		// Character classes are defined under cfgVehicles.
{
	
	
	
		
	// AED
	class Man;
	class CAManBase: Man {
		class ACE_SelfActions {
			class ACE_Equipment {
				class RAA_tear_fabric {
					displayName = "Tear piece of cloth from uniform";
				//	condition = QUOTE(uniform _player isNotEqualTo '');
					condition = QUOTE(GVAR(tearFrabric_enable) && uniform _player isNotEqualTo '');
				//    exceptions[] = {};
				//statement = "[{[_this select 0, ""RAA_tearFabric"", 10] call RAA_common_fnc_3dSound; [""Tearing uniform.."", 3, {true}, {_this call RAA_ACEA_fnc_tear_fabric}, {}, _this] call CBA_fnc_progressBar}, [_player, _player]] call CBA_fnc_execNextFrame;";
				statement = QUOTE(ARR_2(_player, _player) call FUNC(tearFabric_start));
				//	icon = QPATHTOF(pics\icon_aed_action);
				};
				
			};
		};
		
		class ACE_Actions {
			class ACE_MainActions {
				class RAA_takeDetonator {
					displayName = "Take Detonator";
					condition = QUOTE([_target] call ACE_Explosives_fnc_hasPlacedExplosives);
					statement = "";
				//	exceptions[] = {"isNotSwimming"};
				//	icon = "\z\ace\addons\explosives\UI\Explosives_Menu_ca.paa";
					insertChildren = QUOTE(ARR_2(_target, _player) call FUNC(takeDetonator_getChildren));
				};
				
				class RAA_tear_fabric {
					displayName = "Tear piece of cloth from uniform";
				//	condition = QUOTE(uniform _target isNotEqualTo '');
					condition = QUOTE(GVAR(tearFrabric_enable) && uniform _target isNotEqualTo '');
				//    exceptions[] = {};
			//	statement = "[{[_this select 0, ""RAA_tearFabric"", 10] call RAA_common_fnc_3dSound; [""Tearing uniform.."", 3, {true}, {_this call RAA_ACEA_fnc_tear_fabric}, {}, _this] call CBA_fnc_progressBar}, [_target, _player]] call CBA_fnc_execNextFrame;";
				statement = QUOTE(ARR_2(_player, _target) call FUNC(tearFabric_start));
				//	icon = QPATHTOF(pics\icon_aed_action);
				};
				
			};
		};
	};
	
	
};