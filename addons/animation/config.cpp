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
			
		};
		weapons[] = {	// Classes from cfgWeapons
			
		};

		requiredAddons[] = {
			"A3_Data_F_Tank_Loadorder",
			"A3_Anims_F",
			"RAA_common",
			"cba_xeh",
			"ace_interact_menu",
			"zen_dialog"
		};
		
	};
};

#include "CfgEventHandlers.hpp"
#include "cfgVehicles.hpp"
#include "cfgWeapons.hpp"