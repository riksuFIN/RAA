#include "script_component.hpp"

class CfgPatches 
{
	class ADDON
	{
		name = COMPONENT_NAME;
		author = "riksuFIN";
		requiredVersion = REQUIRED_VERSION;
		VERSION_CONFIG;
		units[] = {	// Classes from cfgVehicles
			"RAA_unfinished_ied_item",
			"RAA_facepaint_item",
			"RAA_sound_axe_01"
		};
		weapons[] = {	// Classes from cfgWeapons
			"RAA_facepaint"
		};

		requiredAddons[] = {
			"RAA_common",
			"RAA_misc",
			"ACRE_main"
		};
		
		skipWhenMissingDependencies = 1;
		
	};
};

#include "CfgEventHandlers.hpp"

#include "cfgWeapons.hpp"





