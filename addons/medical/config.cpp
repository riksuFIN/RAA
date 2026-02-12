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
			"RAA_painkiller_item",
			"RAA_Item_AED"
		};
		weapons[] = {	// Classes from cfgWeapons
			"RAA_painkiller",
			"RAA_painkiller_4",
			"RAA_painkiller_3",
			"RAA_painkiller_2",
			"RAA_painkiller_1"
		};

		requiredAddons[] = {
			"RAA_common",
			"RAA_ACEA",
			"ace_medical_treatment",
			"ace_interact_menu",
			"A3_Structures_F_EPA_Items_Medical",
			"A3_Data_F_Oldman_Loadorder"
		};
		skipWhenMissingDependencies = 1;
		
	};
};


#include "CfgEventHandlers.hpp"
#include "cfgMoves.hpp"
#include "cfgWeapons.hpp"
#include "cfgSounds.hpp"
#include "cfgVehicles.hpp"
#include "ACE_medical_actions.hpp"
#include "ACE_medical_treatment.hpp"
#include "CfgReplacementItems.hpp"











