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

		};
		requiredAddons[] = {"A3_Characters_F", "cba_main", "ace_main"};
		
		
	};
};

#include "CfgEventHandlers.hpp"