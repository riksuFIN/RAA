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
		requiredAddons[] = {"A3_Structures_F","cba_common","acex_field_rations", "ace_medical_engine"};
		skipWhenMissingDependencies = 1;
	};
};

#include "CfgEventHandlers.hpp"


class CfgSounds {
	class RAA_Hungry1 {
		name 		= "[RAA] Stomach Growling 1";	// how the sound is referred to in the editor (e.g. trigger effects)
		sound[]		= { "\r\misc\addons\RAA_FieldRation_Warnings\sounds\Hunger1.ogg", 7, 1 };	// filename, volume, pitch, distance (optional)
		titles[] 	= {};	// subtitle delay in seconds, subtitle text
	};
	
};