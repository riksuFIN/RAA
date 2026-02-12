#include "script_component.hpp"

class CfgPatches
{
	class RAA_firesupport_additions
	{
		author = "riksuFIN";
		name = COMPONENT_NAME;
		requiredVersion = REQUIRED_VERSION;
		VERSION_CONFIG;
		units[] = {	// Classes from cfgVehicles
		};
		weapons[] = {	// Classes from cfgWeapons
		};

		requiredAddons[] = {
			"A3_Data_F_Tank_Loadorder",
			"cba_xeh",
			"RAA_common",
			"Tun_Firesupport",
			"tun_artycomputer_models"
		};
		skipWhenMissingDependencies = 1;
	};
};

#include "CfgEventHandlers.hpp"
#include "cfgAmmo.hpp"
#include "cfgMagazines.hpp"
#include "cfgVehicles.hpp"
#include "cfgWeapons.hpp"


/*	CBA framework conversion; moved to XEH
//	Add CBA Settings
class Extended_PreInit_EventHandlers {
    class RAA_firesupport_additions_pre_init_event {
        init = "call compile preprocessFileLineNumbers '\r\misc\addons\RAA_firesupport_additions\CBA_Settings.sqf'";
    };
};
*/

/*
class Extended_PostInit_EventHandlers {
    class RAA_firesupport_additions_post_init_event {
        init = "call compile preprocessFileLineNumbers '\r\misc\addons\RAA_firesupport_additions\XEH_postInit.sqf'";
    };
};
*/