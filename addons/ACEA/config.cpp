#include "script_component.hpp"

class CfgPatches 
{
	class ADDON
	{
		author = "riksuFIN";
		name = COMPONENT_NAME;
		VERSION_CONFIG;
		requiredVersion = REQUIRED_VERSION;
		
		units[] = {	// Classes from cfgVehicles
		};
		weapons[] = {	// Classes from cfgWeapons
			"RAA_torn_fabric"
		};

		requiredAddons[] = {
			"RAA_common",
			"ace_interact_menu",
//			"A3_Structures_F_EPA_Items_Medical",
			"A3_Data_F_Oldman_Loadorder"
		};
		
		
	};
};


#include "CfgEventHandlers.hpp"
#include "cfgWeapons.hpp"
#include "cfgSounds.hpp"
#include "cfgVehicles.hpp"
//#include "gui_loadoutOverview.hpp"
#include "arsenalGUI.hpp"










