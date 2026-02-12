/*
class CfgSounds
{
	sounds[] = {};
	class RAA_phone_ringing {
		name = "Telephone ringing";
		sound[] = { QPATHTOF(sounds\ringing.ogg), 2, 1, 30}; // filename, volume, pitch, distance (optional)
		titles[] = {};
	};
	
};
*/
class CfgSFX {
	class GVAR(phone_ringing_sfx) {
		name = "Phone ringing";
						// Path,	Volume, Pitch, maxDistance, Propability, minDelay, midDelay, maxDelay
	//	sound1[] = {"\r\misc\addons\RAA_misc\sounds\axe_01.ogg", 3, 1.0, 400, 0.1, 1, 2, 6};
		sound1[] = {QPATHTOF(sounds\ringing.ogg), 1.5, 1.0, 50, 1, 1, 2, 2};
		sounds[] = {"sound1"};
		empty[] = {"", 0, 0, 0, 0, 0, 0, 0};
	};
	
	
	
	
};



class CfgSounds
{
	sounds[] = {};
	class GVAR(earpiece_pickup) {
		name = "Return earpiece to vintage phone";
		sound[] = { QPATHTOF(sounds\pickup.ogg), 4, 1, 15}; // filename, volume, pitch, distance (optional)
		titles[] = {};
	};
	class GVAR(earpiece_return) {
		name = "Pick up earpiece from vintage phone";
		sound[] = { QPATHTOF(sounds\return.ogg), 4, 1, 15}; // filename, volume, pitch, distance (optional)
		titles[] = {};
	};
	
};