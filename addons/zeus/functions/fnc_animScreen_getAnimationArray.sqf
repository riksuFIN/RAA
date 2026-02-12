#include "script_component.hpp"
/* File: fnc_getAnimatinArray.sqf
 * Author(s): riksuFIN
 * Description: Config file where all possible animations are defined.
 					Called by script to get animation composed of array of images
 *
 * Called from: Any
 * Parameter(s):
 0:	Animation ID <STRING>
 *
 Returns: ARRAY of pictures
 *
 * Example:	["COUNTDOWN_5"] call RAA_zeus_fnc_animScreen_getAnimArray
*/
params ["_animType"];

private _texturesList = [];
switch (_animType) do {
	case ("COUNTDOWN_5"): {
		_texturesList = [
			QPATHTOF(pics\numbers\5.paa),
			QPATHTOF(pics\numbers\4.paa),
			QPATHTOF(pics\numbers\3.paa),
			QPATHTOF(pics\numbers\2.paa),
			QPATHTOF(pics\numbers\1.paa),
			QPATHTOF(pics\numbers\0.paa)
		];
	};
	
	case ("COUNTDOWN_10"): {
		_texturesList = [
			QPATHTOF(pics\numbers\10.paa),
			QPATHTOF(pics\numbers\9.paa),
			QPATHTOF(pics\numbers\8.paa),
			QPATHTOF(pics\numbers\7.paa),
			QPATHTOF(pics\numbers\6.paa),
			QPATHTOF(pics\numbers\5.paa),
			QPATHTOF(pics\numbers\4.paa),
			QPATHTOF(pics\numbers\3.paa),
			QPATHTOF(pics\numbers\2.paa),
			QPATHTOF(pics\numbers\1.paa),
			QPATHTOF(pics\numbers\0.paa)
		];
	};
	
	case ("BSOD"): {
		_texturesList = [
			QPATHTOF(pics\bsod\bsod_0.paa),
			QPATHTOF(pics\bsod\bsod_1.paa),
			QPATHTOF(pics\bsod\bsod_2.paa),
			QPATHTOF(pics\bsod\bsod_3.paa),
			QPATHTOF(pics\bsod\bsod_4.paa),
			QPATHTOF(pics\bsod\bsod_5.paa),
			QPATHTOF(pics\bsod\bsod_6.paa),
			QPATHTOF(pics\bsod\bsod_7.paa),
			QPATHTOF(pics\bsod\bsod_8.paa)
		];
	};
	
	case ("PROGRESS_GENERIC"): {
		_texturesList = [
			QPATHTOF(pics\progress\progress_generic_0.paa),
			QPATHTOF(pics\progress\progress_generic_1.paa),
			QPATHTOF(pics\progress\progress_generic_2.paa),
			QPATHTOF(pics\progress\progress_generic_3.paa),
			QPATHTOF(pics\progress\progress_generic_4.paa),
			QPATHTOF(pics\progress\progress_generic_5.paa),
			QPATHTOF(pics\progress\progress_generic_6.paa),
			QPATHTOF(pics\progress\progress_generic_7.paa),
			QPATHTOF(pics\progress\progress_generic_8.paa),
			QPATHTOF(pics\progress\progress_generic_9.paa),
			QPATHTOF(pics\progress\progress_generic_10.paa),
			QPATHTOF(pics\progress\progress_generic_11.paa),
			QPATHTOF(pics\progress\progress_generic_12.paa),
			QPATHTOF(pics\progress\progress_generic_13.paa),
			QPATHTOF(pics\progress\progress_generic_14.paa),
			QPATHTOF(pics\progress\progress_generic_15.paa),
			QPATHTOF(pics\progress\progress_generic_16.paa),
			QPATHTOF(pics\progress\progress_generic_16.paa),
			QPATHTOF(pics\progress\progress_generic_16.paa),
			QPATHTOF(pics\progress\progress_generic_16.paa),
			QPATHTOF(pics\progress\progress_generic_17.paa)
		];
	};
	
	
	case ("EREASING"): {
		_texturesList = [
			QPATHTOF(pics\hacking_ereasing\1.paa),
			QPATHTOF(pics\hacking_ereasing\2.paa),
			QPATHTOF(pics\hacking_ereasing\3.paa),
			QPATHTOF(pics\hacking_ereasing\4.paa),
			QPATHTOF(pics\hacking_ereasing\5.paa),
			QPATHTOF(pics\hacking_ereasing\6.paa),
			QPATHTOF(pics\hacking_ereasing\7.paa),
			QPATHTOF(pics\hacking_ereasing\8.paa),
			QPATHTOF(pics\hacking_ereasing\9.paa),
			QPATHTOF(pics\hacking_ereasing\10.paa),
			QPATHTOF(pics\hacking_ereasing\11.paa),
			QPATHTOF(pics\hacking_ereasing\12.paa),
			QPATHTOF(pics\hacking_ereasing\13.paa),
			QPATHTOF(pics\hacking_ereasing\14.paa),
			QPATHTOF(pics\hacking_ereasing\15.paa),
			QPATHTOF(pics\hacking_ereasing\16.paa),
			QPATHTOF(pics\hacking_ereasing\17.paa),
			QPATHTOF(pics\hacking_ereasing\18.paa),
			QPATHTOF(pics\hacking_ereasing\19.paa),
			QPATHTOF(pics\hacking_ereasing\20.paa),
			QPATHTOF(pics\hacking_ereasing\21.paa),
			QPATHTOF(pics\hacking_ereasing\22.paa),
			QPATHTOF(pics\hacking_ereasing\23.paa),
			QPATHTOF(pics\hacking_ereasing\end.paa)
		];
	};
	
	
	case ("HACKING_PROGRESS"): {
		_texturesList = [
			QPATHTOF(pics\hacking_progress\1.paa),
			QPATHTOF(pics\hacking_progress\2.paa),
			QPATHTOF(pics\hacking_progress\3.paa),
			QPATHTOF(pics\hacking_progress\4.paa),
			QPATHTOF(pics\hacking_progress\5.paa),
			QPATHTOF(pics\hacking_progress\6.paa),
			QPATHTOF(pics\hacking_progress\7.paa),
			QPATHTOF(pics\hacking_progress\8.paa),
			QPATHTOF(pics\hacking_progress\9.paa),
			QPATHTOF(pics\hacking_progress\10.paa),
			QPATHTOF(pics\hacking_progress\11.paa),
			QPATHTOF(pics\hacking_progress\12.paa),
			QPATHTOF(pics\hacking_progress\13.paa),
			QPATHTOF(pics\hacking_progress\14.paa),
			QPATHTOF(pics\hacking_progress\15.paa),
			QPATHTOF(pics\hacking_progress\16.paa),
			QPATHTOF(pics\hacking_progress\17.paa),
			QPATHTOF(pics\hacking_progress\18.paa),
			QPATHTOF(pics\hacking_progress\19.paa),
			QPATHTOF(pics\hacking_progress\20.paa),
			QPATHTOF(pics\hacking_progress\21.paa),
			QPATHTOF(pics\hacking_progress\22.paa),
			QPATHTOF(pics\hacking_progress\23.paa),
			QPATHTOF(pics\hacking_progress\24.paa),
			QPATHTOF(pics\hacking_progress\25.paa),
			QPATHTOF(pics\hacking_progress\26.paa),
			QPATHTOF(pics\hacking_progress\end.paa)
		];
	};
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	default {
		_texturesList = [
			QPATHTOF(pics\bsod\bsod_0.paa),
			QPATHTOF(pics\bsod\bsod_1.paa),
			QPATHTOF(pics\bsod\bsod_2.paa),
			QPATHTOF(pics\bsod\bsod_3.paa),
			QPATHTOF(pics\bsod\bsod_4.paa),
			QPATHTOF(pics\bsod\bsod_5.paa),
			QPATHTOF(pics\bsod\bsod_6.paa),
			QPATHTOF(pics\bsod\bsod_7.paa),
			QPATHTOF(pics\bsod\bsod_8.paa)
		];
	};
};



_texturesList