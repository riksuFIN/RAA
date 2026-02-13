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
		};
		weapons[] = {	// Classes from cfgWeapons
			"RAA_PRC152_broken",
			"RAA_PPRC77_broken",
			"RAA_PRC117F_broken",
			"RAA_PRC148_broken",
			"RAA_PRC343_broken",
			"RAA_SEM52SL_broken",
			"RAA_SEM70_broken",
			"RAA_BF888S_broken",
			"RAA_PPRC77_broken"
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





