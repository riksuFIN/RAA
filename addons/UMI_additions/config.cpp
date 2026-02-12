#include "script_component.hpp"

class CfgPatches
{
	class RAA_UMI_additions
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
			"RAA_common",
			"RAA_ACEX_Additions",
			"acex_field_rations",
			"UMI_Inventory"
		};
		
		skipWhenMissingDependencies = 1;
	};
};

#include "CfgEventHandlers.hpp"
#include "cfgWeapons.hpp"
