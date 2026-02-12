#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#include "CBA_Settings.inc.sqf"


ADDON = true;



// This is a redirect for changed fnc name. For backwards-compatibility to avoid breaking old missions
RAA_misc_fnc_beltSlot_doMoveToBelt	= compileFinal preprocessFileLineNumbers QPATHTOF(functions\fnc_beltSlot_redirect.sqf);
