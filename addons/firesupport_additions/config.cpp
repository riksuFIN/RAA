#include "script_component.hpp"

class CfgPatches
{
	class RAA_firesupport_additions
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
			"cba_xeh",
			"RAA_common",
			"Tun_Firesupport",
			"tun_artycomputer_models"
		};
		skipWhenMissingDependencies = 1;
	};
};

#include "CfgEventHandlers.hpp"
#include "cfgAmmo.hpp"
#include "cfgMagazines.hpp"
#include "cfgVehicles.hpp"
#include "cfgWeapons.hpp"