#include "script_component.hpp"

class CfgPatches
{
	class RAA_ACEX_Additions
	{
		author = "riksuFIN";
		name = COMPONENT_NAME;
		requiredVersion = REQUIRED_VERSION;
		VERSION_CONFIG;
		
		units[] = {	// Classes from cfgVehicles
			"RAA_Can_beer_Item",
			"RAA_bottle_whiskey_Item",
			"RAA_bottle_whiskey_75_Item",
			"RAA_bottle_whiskey_50_Item",
			"RAA_bottle_whiskey_25_Item",
			"RAA_bottle_whiskey_empty_Item",
			"RAA_bottle_genericAlcohol_Item",
			"RAA_bottle_genericAlcohol_water_Item"
			
		};
		weapons[] = {	// Classes from cfgWeapons
			"RAA_Can_beer",
			"RAA_Can_ES",
			"RAA_sodaBottle",
			"RAA_sodaBottle_mixed",
			"RAA_sodaBottle_half",
			"RAA_sodaBottle_mixed_half",
			"RAA_sodaBottle_empty",
			"RAA_bottle_whiskey",
			"RAA_bottle_whiskey_75",
			"RAA_bottle_whiskey_50",
			"RAA_bottle_whiskey_25",
			"RAA_bottle_whiskey_empty",
			"RAA_bottle_genericAlcohol",
			"RAA_bottle_genericAlcohol_23",
			"RAA_bottle_genericAlcohol_13",
			"RAA_bottle_genericAlcohol_empty",
			"RAA_bottle_genericAlcohol_water",
			"RAA_tinCan_DelMontre",
			"RAA_tinCan_peaSoup"
			
			
		};

		requiredAddons[] = {
			"RAA_common",
			"acex_field_rations"
		};

	};
};

#include "CfgEventHandlers.hpp"
#include "cfgVehicles.hpp"
#include "cfgWeapons.hpp"
#include "cfgSounds.hpp"
#include "CfgMovesMaleSdr.hpp"


/*
class Extended_PostInit_EventHandlers {
    class RAA_ACEX_Additions_post_init_event {
        init = "call compile preprocessFileLineNumbers '\r\misc\addons\RAA_ACEX_Additions\XEH_postInit.sqf'";
    };
};
*/