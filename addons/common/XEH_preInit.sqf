#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;


ADDON = true;



GVAR(allMedicalItems) = [
	"ACE_fieldDressing",
	"ACE_packingBandage",
	"ACE_elasticBandage",
	"ACE_tourniquet",
	"ACE_splint",
	"ACE_morphine",
	"ACE_adenosine",
	"ACE_epinephrine",
	"ACE_plasmaIV",
	"ACE_plasmaIV_500",
	"ACE_plasmaIV_250",
	"ACE_bloodIV",
	"ACE_bloodIV_500",
	"ACE_bloodIV_250",
	"ACE_salineIV",
	"ACE_salineIV_500",
	"ACE_salineIV_250",
	"ACE_quikclot",
	"ACE_personalAidKit",
	"ACE_surgicalKit",
	"ACE_bodyBag",
	"ACE_bodyBag_blue",
	"ACE_bodyBag_white",
	"ACE_suture",
	"FirstAidKit",
	"Medikit",
	"RAA_painkiller",
	"RAA_AED",
	"RAA_defibrillator",
	"RAA_naloxone",
	"RAA_painkiller",
	"RAA_painkiller_4",
	"RAA_painkiller_3",
	"RAA_painkiller_2",
	"RAA_painkiller_1",
	"RAA_propofol"
];