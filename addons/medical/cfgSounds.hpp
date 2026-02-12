class CfgSounds
{
	sounds[] = {};
	class RAA_AED_speak_prep {
		name = "AED Speech:  Preparing";
		sound[] = { QPATHTOF(sounds\AED_prep_speech.ogg), 3, 1 }; // filename, volume, pitch, distance (optional)
		titles[] = {};
	};
	class RAA_AED_speak_check_pulse {
		name = "AED Speech: Check Pulse";
		sound[] = { QPATHTOF(sounds\AED_check_pulse.ogg), 4, 1 }; // filename, volume, pitch, distance (optional)
		titles[] = {};
	};
	class RAA_AED_speak_finished {
		name = "AED Speech: Finished";
		sound[] = { QPATHTOF(sounds\AED_finished.ogg), 4, 1 }; // filename, volume, pitch, distance (optional)
		titles[] = {};
	};
	class RAA_AED_speak_safe_to_touch {
		name = "AED Speech: safe to touch";
		sound[] = { QPATHTOF(sounds\AED_it_is_now_safe_to_touch.ogg), 3, 1 }; // filename, volume, pitch, distance (optional)
		titles[] = {};
	};
	class RAA_AED_speak_no_shock_adviced {
		name = "AED Speech: no shock adviced";
		sound[] = { QPATHTOF(sounds\AED_no_shock_adviced.ogg), 5, 1 }; // filename, volume, pitch, distance (optional)
		titles[] = {};
	};
	class RAA_AED_speak_preparing_shock {
		name = "AED Speech: preparing shock";
		sound[] = { QPATHTOF(sounds\AED_preparingShock.ogg), 3, 1 }; // filename, volume, pitch, distance (optional)
		titles[] = {};
	};
	class RAA_AED_speak_shock_delivered {
		name = "AED Speech: shock delivered";
		sound[] = { QPATHTOF(sounds\AED_shock_delivered.ogg), 3, 1 }; // filename, volume, pitch, distance (optional)
		titles[] = {};
	};
	class RAA_AED_speak_shock_delivered_analyzing {
		name = "AED Speech: shock delivered analyzing heart rythim";
		sound[] = { QPATHTOF(sounds\AED_shock_delivered_analyzing_heart.ogg), 3, 1 }; // filename, volume, pitch, distance (optional)
		titles[] = {};
	};
	class RAA_AED_speak_start_cpr {
		name = "AED Speech: start cpr";
		sound[] = { QPATHTOF(sounds\AED_start_cpr.ogg), 5, 1 }; // filename, volume, pitch, distance (optional)
		titles[] = {};
	};
	class RAA_AED_speak_connection_lost {
		name = "AED Speech: connection lost";
		sound[] = { QPATHTOF(sounds\AED_connection_lost.ogg), 5, 1 }; // filename, volume, pitch, distance (optional)
		titles[] = {};
	};
	class RAA_AED_effect_shock {
		name = "AED Effect: Defibrilator Shock";
		sound[] = { QPATHTOF(sounds\AED_effect_shock.ogg), 3, 1 }; // filename, volume, pitch, distance (optional)
		titles[] = {};
	};
	class RAA_defibrillator_effect_shock {
		name = "Defibrillator charging and shock: ";
		sound[] = { QPATHTOF(sounds\effect_defib_charging.ogg), 2, 1 }; // filename, volume, pitch, distance (optional)
		titles[] = {};
	};
	
	
};