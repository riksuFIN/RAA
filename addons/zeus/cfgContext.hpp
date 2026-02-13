
class zen_context_menu_actions {
	class RAA_disableAIMove {
		displayName = "Toggle AI Movement";
		icon = QPATHTOF(pics\disable_move.paa);
		condition = QUOTE(ARR_1(_objects) call FUNC(canDisableAIMovement));	// MUST return bool.
		statement = QUOTE(ARR_1(_objects) call FUNC(disableAIMovement));	// Code to execute
		priority = 54;
	};
	
	class RAA_teleportVehicle {
		displayName = "Teleport Object";
		icon = QPATHTOF(pics\arrows.paa);
		condition = "count _objects > 0";	// MUST return bool.
		statement = QUOTE(ARR_1(_objects) call FUNC(teleportVehicle));	// Code to execute
		priority = 55;
	};
	
	class RAA_lambs_doSupress {
		displayName = "Do Supress";
		icon = QPATHTOF(pics\arrows.paa);
		condition = QUOTE(ARR_1(_objects) call FUNC(canDisableAIMovement));
		statement = QUOTE(ARR_1(_objects) call FUNC(doSupress));
		priority = 56;
	};
	
	
	class RemoteControl {
//	displayName = "$STR_A3_CfgVehicles_ModuleRemoteControl_F";
//	condition = QUOTE(_hoveredEntity call EFUNC(remote_control,canControl));
//	statement = QUOTE(_hoveredEntity call EFUNC(remote_control,start));
//	icon = "\a3\modules_f_curator\data\portraitremotecontrol_ca.paa";
//	priority = 20;
	
//	insertChildren = "[_objects, _hoveredEntity ] call RAA_zeus_fnc_remoteControl_getChildrens";
	insertChildren = QUOTE(ARR_2(_objects, _hoveredEntity) call FUNC(remoteControl_getChildrens));
	
	
	};
	
	
};

