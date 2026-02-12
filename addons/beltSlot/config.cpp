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

		requiredAddons[] = {
			"A3_Data_F_Tank_Loadorder",
			"RAA_common",
			"cba_xeh",
			"ace_interact_menu"
		};
		
	};
};

#include "CfgEventHandlers.hpp"
//#include "CfgEden.hpp"
#include "cfgVehicles.hpp"
#include "RscDisplayInventory.hpp"	// Add belt slots to inventory IGUI



// This is used to update beltSlot pics in inventory
class Extended_InventoryOpened_EventHandlers {
	class CAManBase {
		ADDON = "call RAA_beltSlot_fnc_beltSlot_onInventoryOpened";
	};
};
