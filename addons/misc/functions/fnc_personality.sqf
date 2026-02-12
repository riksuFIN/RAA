#include "script_component.hpp"
/* File: fnc_personality.sqf
 * Author(s): riksuFIN
 * Description: Assigns each player a randomly drawn personality trait for RP purposes.
 *
 * Called from: 
 * Local to:	
 * Parameter(s):
 * 0:	
 * 1:	
 * 2:	
 * 3:	
 * 4:	
 *
 Returns: 
 *
 * Example:	
 *	[] call RAA_misc_fnc_personality
*/
params ["_reassign", "_s"];


if (player getVariable [GVAR(personality), ""] isEqualTo "" && !_reassign) exitWith {
[COMPNAME, GVAR(debug), "INFO", format ["Personality is already assigned."]] call EFUNC(common,debugNew);
};



private _personality = selectRandom [
["Smoker", "Every now and then you feel the need to light up a cigarette.", "You always keep a pack of cigarettes with you."],
["Heavy Smoker", "You feel naked without a cigarette. Fresh air is poison to you.", "You always have a carton if cigarettes with you."],
["Hydrohomie", "You really, really appreciate good, fresh cold bottle of water.", "You always remember to stay hydrated, and keep a bottle handy!"],
["Severely dehydrated", "You always forget to grab a drink in time.", "You have no water with you, and you seem to never become fully hydrated."],
["Alcoholic", "Water? What's that, a disgusting poison? Sweet King Alcohol is your best, and only friend!", "You have always have a few bottles of nice, cold... some type of alcohol with you. Anything will do, really."],
//["Hoplophobia", ""],
["Heavy eater", "You're always hungry. Always.", "You carry a restaurant meal amount of food in your pockets. But you forgot the fork, again."],
["Snacker", "You're always in mood of some light snack.", "'Just gonna grab something small, not too hungry really.' -You, propably"],
["Dishonest", "On average, about every second sentence coming out of your mouth is either false or exaggerated.", "Remember that time you saved a person trapped under a car... sorry, no, a truck by lifting the whole thing in the air, all alone! With one hand since you were fending off bunch of angry dogs with other hand!"],
["Poor shooter", "You couldn't hit side of barn from two meters away.", "In Military you earned nickname 'Sharpshooter'. Bunch of jokers back there..."],
["Distrustful", "You can't trust anyone, not even your own family. You learned this the hard way.", "Better sleep with one eye open and have head on swivel. Especially while with 'friends'"],
["Easily distracted", "You cannot concentrate on single thing even if your life depended on it."],
["Troublemaker", "You life of thrill! Getting shouted at is part of exitment!"],
["Corrupted", "You work for the highest bidder. Or else..."]
];




