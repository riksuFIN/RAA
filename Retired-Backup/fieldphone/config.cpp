#include "script_component.hpp"

class CfgPatches
{
	class ADDON
	{
		author = "riksuFIN";
		name = COMPONENT_NAME;
		requiredVersion = REQUIRED_VERSION;
		VERSION_CONFIG;
		
		units[] = {	// Classes from cfgVehicles
		//	"RAA_fieldphone"
		};
		weapons[] = {	// Classes from cfgWeapons
			
			
			
		};

		requiredAddons[] = {
			"RAA_common",
			"acre_main"
		};

	};
};

//#if __has_include("\z\ace\addons\main\script_component.hpp")
//#if __has_include("\idi\acre\addons\main\script_version.hpp")
	#include "CfgEventHandlers.hpp"
	#include "cfgVehicles.hpp"
	#include "cfgWeapons.hpp"
	#include "cfgSounds.hpp"
//#endif





/*
class Extended_PostInit_EventHandlers {
    class RAA_ACEX_Additions_post_init_event {
        init = "call compile preprocessFileLineNumbers '\r\misc\addons\RAA_ACEX_Additions\XEH_postInit.sqf'";
    };
};
*/