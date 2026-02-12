#include "script_component.hpp"
/* File: fnc_treatmentFeedback_patient.sqf
 * Author(s): riksuFIN
 * Description: Second part of letting unsconscious player know when they're being treated
 *						This one is executed on patient's side
 *
 * Called from: fnc_treatmentFeedback_helper.sqf, via CBA Event
 * Local to:	Client (who's being treated)
 * Parameter(s):
 * 	Data from eventhandler
 *
 Returns: 
 *
 * Example:	
 *	[player, player, "", "CPR"] call RAA_ACEA_fnc_treatmentFeedback_patient
*/

params ["_caller", "_target", "_selectionName", "_className", "_itemUser", "_usedItem"];
// [zeus,B Alpha 1-5:2,"rightarm","ApplyTourniquet",zeus,"ACE_tourniquet"]


if (GVAR(debug)) then {systemChat format ["[RAA_ACEA] Treated with classname: %1 on %2 with item %3 by %4", _className, _selectionName, _usedItem, _itemUser];};

// Ignore conscious players
if (_target call ace_common_fnc_isAwake || _target isNotEqualTo player) exitWith {
	if (GVAR(debug)) then {systemChat "[RAA_ACEA] [Error] fnc_treatmentFeedback_patient.sqf: This fnc was executed on wrong client!";};
};

// Avoid spamming unsconscious player. They don't need to know everything, they're unscosious, after all ;)
if (time - (_target getVariable [QGVAR(treatmentFeedback_lastMsgTime), 0]) < 40) exitWith {
	if (GVAR(debug)) then {systemChat "[RAA_ACEA] treatmentFeedback: Executed too often, skipping this message";};
};



private _msgHeader = "You're dreaming...";
private _msgAdditional = "";
private _msg = "";

switch true do {
	case (_className isEqualTo "CPR"): {
		_msg = selectRandom [
			"In a dream there's a person dancing on your chest.",
			"In a dream there's a person jumping on your chest.",
			"In a dream there's a person jumping on your chest. You just hope they don't find any high-heels..",
			"In a dream there's a person dancing on your chest. You cannot see their face.",
			"In a dream there's a person dancing on your chest. That person's face is blurry.",
			"In a dream you see a person dancing on your chest.",
			"In a dream you see a person dancing on your chest. You just hope they don't find any wooden shoes..",
			"In a dream you're laying on your back, and someone is dancing on your chest."
		];
	};
	case (_className isEqualTo "CheckPulse"): {
		_msg = selectRandom [
			"You somehow feel someone touching your neck with cold fingers.",
			"In a dream you feel someone touching your neck with cold fingers.",
			"In a dream you feel someone touching your neck with cold fingers.",
			"In a dream you feel someone touching your neck with cold fingers."
		];
	};
	case (_className isEqualTo "RAA_defibrillator"): {
		_msg = selectRandom [
			"In a dream you're relaxing in a bathtub when a toaster suddenly drops into water.",
			"In a dream you're relaxing in a bathtub when a toaster suddenly drops into water.",
			"In a dream you're pissing into an electric fence.",
			"In a dream you're pissing into an electric fence.",
			"In a dream you're pissing into an electric fence. You're thinking: 'Weird.. That actually felt good.'",
			"You dream of being hit by lighting bolt.",
			"You dream of being hit by lighting bolt.",
			"You dream of being hit by lighting bolt. You're thinking: 'Weird.. That actually felt good.'",
			"You're standing next to your unconscious body, watching from aside as someone is using defibrillator on your inanimate body."
		];
	};
	case (_className isEqualTo "RAA_AED"): {
		_msg = selectRandom [
			"You hear a soothing voice.",
			"You hear a soothing voice.",
			"In a dream you hear a soothing voice coming out of nowhere.",
			"In a dream you hear a soothing voice coming out of nowhere. There's nobody here, just disconnected voice.",
			"In a dream you hear a soothing voice, followed by electrical charge running through your body.",
			"In a dream you see a person telling you to stick a screwdriver into electrical socket.",
			"You hear a voice telling to prepare for electrical shock.",
			"There's a person telling you everything is gonna be okay.",
			"You hear a calm voice saying 'Remain calm. Make sure 911 is called now..'",
			"You hear a calm voice saying 'Remain calm. Make sure 911 is called now..'",
			"You hear a calm voice saying 'Remain calm. Make sure 911 is called now..'",
			"There's a person telling you everything is gonna be okay. Soon after they push you to electric fence."
		];
	};
	
	case (_className isEqualTo "Morphine"): {
		_msg = selectRandom [
			"All your pain suddenly goes away.",
			"All your pain suddenly goes away.",
			"All your pain suddenly goes away. You're starting to feel easy.",
			"In a dream you're in massive, incapaciting pain. Then, suddenly, someone injects you with something and all pain goes away.",
			"In a dream you're in massive, incapaciting pain. Then, suddenly, someone injects you with something and all pain goes away.",
			"In a dream you're in massive, incapaciting pain. Then, suddenly, someone injects you with something and all pain goes away. Then, that person fades away",
			"One second ago you felt massive pain, but now it's all gone",
			"You start to dream of sitting on very comfortable couch."
		];
	};
	case (_className isEqualTo "Epinephrine"): {
		_msg = selectRandom [
			"That bright, white light that was just approaching is now suddenly gone. Only darkness remains.",
			"You were walking torwards a bright, white light, but now you're being rapidly pulled back.",
			"Deep inside yourself you know that very soon you will have to continue your journey on this world.",
			"Deep inside yourself you know that your story is not over yet.",
			"In a dream you meet a person. That person's face is blurry. They tell you that it is not your time yet. They point to direction where you came from.",
			"You hear a voice telling you to wake up.",
			"You hear a voice telling you to wake up.",
			"You hear a voice calling you. They're telling you to come back.",
			"You hear a voice calling for you.",
			"You realize you didn't finish watching that series you just started, you cannot go yet!"
		];
	};
	case (_className isEqualTo "ApplyTourniquet"): {
		_msg = selectRandom [
			"All of sudden, you cannot move your arm anymore.",
			"In a dream someone wraps something around your arm. It's tight. Really tight.",
			"You dream of someone placing a rope around your arm, blocking all blood flow."
		];
	};
	case (_className isEqualTo "RAA_naloxone"): {
		_msg = selectRandom [
			"All pain suddenly comes back.",
			"All pain suddenly comes back, hitting you like a truck.",
			"You were feeling very comfortable, but now you're suddenly feeling massive, incomprehensible pain"
		];
	};
	case (_className isEqualTo "ACE_surgicalKit"): {
		_msg = selectRandom [
			"In a dream you see a woodoo doll, and a person sewing it. Doll looks remotely like you, but person sewing... Their face is blurry.",
			"In a dream you're floating, unable to move, with someone stiching you with needle.",
			"You're standing next to your inanimate body, watching as someone is stiching you up.",
			"You're standing inside Operating Room, watching as Doctors are stiching up a person on table. That person looks weirdly familiar."
		];
	};
	case (_className in ["BasicBandage", "FieldDressing", "PackingBandage", "ElasticBandage", "QuikClot"]): {
		_msg = selectRandom [
			"Of blood flow from your body rapidly decreasing.",
			"You dream of Blood flow from your body rapidly decreasing.",
			"In a dream someone is putting something on your body. It feels weirdly good.",
			"You're standing next to unconscious body, watching as someone is bandaging that body. You try to help, but your hands go right trough.",
			"You feel a touch. Human's trying to help you. At least you hope it's a human.",
			"You feel someone touching you. Someone's trying to bandage you! You're not forgotten! You just hope this isn't a dream..",
			"You feel someone touching you. Someone's trying to bandage you!",
			"You feel someone touching you. Someone's trying to bandage you!",
			"You feel someone touching you. Someone's trying to bandage you! You're not forgotten!"
		];
	};
	case (_className in ["BloodIV", "BloodIV_500", "BloodIV_250", "PlasmaIV", "PlasmaIV_500", "PlasmaIV_250", "SalineIV", "SalineIV_500", "SalineIV_250"]): {
		_msg = selectRandom [
			"A very weird dream where blood is flowing... Not out of your body, but back inside you?",
			"That white light.. it's starting to back away, and you start feeling anxious and uncomfortable again.",
			"White light that was just approaching is now fading away, and that warm feeling is starting to fade.",
			"In a dream you're laying down on a bed, your arm connected to another person via blood transfusion line. Other person's face is blurry.",
			"You're laying down on a bed, your arm connected to another person via blood transfusion line. Other person's face is blurry.",
			"You're laying down on a bed, your arm connected to another person via blood transfusion line. Other person's face is blurry.",
			"In a dream your arm connected to another person via blood transfusion line. You are unable to see other person's face..",
			"Your arm connected to another person via blood transfusion line. You are unable to see other person's face..",
			"Your arm connected to another person via blood transfusion line. You are unable to see other person's face..",
			"Your arm connected to another person via blood transfusion line. You are unable to see other person's face..",
			"In a dream you see blood floating in space, slowly entering you veins.",
			"Deep inside you know that your time is not over yet.",
			"In a dream you're floating in space, feeling easy. Slowly, though, you're starting to approach a planet below you.",
			"In a dream you're floating in space, feeling easy. Slowly, though, you're starting to approach a planet below you. Maybe your time is not over yet."
		];
	};
	case (_className isEqualTo "BodyBag"): {
		_msg = selectRandom [
			"In nightmare you're in a morgue, placed inside very small freezer. But you're still very much alive.",
			"You see a nightmare of being put inside a black, very dark bag. All hope is lost.",
			"You're standing next to your inanimate body while someone is placing it inside a body bag. You try to shout to them that you're still alive, but nobody is able to hear you scream."
		];
	};
	
	default {
		if (GVAR(debug)) then {systemChat format ["[RAA_ACEA] TreatmentFeedback: Item %1 does not have message attached to it.", _className];};
		_msg = selectRandom [
			"You dream of touch.",
			"In a dream someone is touching you. You feel good.",
			"You're dreaming of someone experimenting on your inanimate body.",
			"You're dreaming of someone experimenting on your inanimate body. You feel good about it",
			"You feel someone touching you.",
			"You see a strange dream where someone is doing something weird on your body.",
			"You see a strange dream where someone is doing something on your body.",
			"Deep inside you know you're not forgotten.",
			"You dream of playing a video game where you've just taken a hit, but your buddies are already reviving you!",
			"You dream of playing a video game where you've just taken a hit, but your buddies are already reviving you. What a weird dream!"
		];
	};
	
};


_target setVariable [QGVAR(treatmentFeedback_lastMsgTime), time];


//[_msg, false, 20, 6] call ace_common_fnc_displayText;
titleText ["<t color='#A7C7E7'><t size='2.0'>" + _msgHeader + "<t size='1.5'><br></br>" + _msg + _msgAdditional, "PLAIN", 2.5, false, true];

//GVAR(treatmentFeedback_textVisible) = true;