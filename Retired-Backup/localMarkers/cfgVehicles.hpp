class CfgVehicles {
	class Man;
	class CAManBase: Man {
		
		class ACE_Actions {
			class ACE_MainActions {
				class GVAR(copy) {
					displayName = "Copy Map Markers";
					condition = QUOTE(GVAR(enabled) && isPlayer _target);
					statement = "[{_this select 0] call FUNC(copyMap_requester_part1)}, [_target]] call CBA_fnc_execNextFrame";	// Delay by frame to avoid crashing game
				//	exceptions[] = {"isNotSwimming"};
					icon = QPATHTOF(pics\icon_map);
				};
			};
		};
	};
	
	
	
	
	
};

