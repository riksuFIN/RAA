#include "script_component.hpp"
/* File: fnc_effect_genericAlcohol.sqf
 * Author(s): riksuFIN
 * Description: Handle effect(s) for consuming Generic Alcohol Bottle
 *
 * Called from: EH
 * Local to: Client
 * Parameter(s):
 0:	Item consumed <STRING>
 1:	
 2:	
 3:	
 4:	
 *
 Returns:
 *
 * Example:	["RAA_bottle_genericAlcohol"] call RAA_ACEX_fnc_effect_genericAlcohol
*/
params ["_item"];

if (_item isEqualTo "RAA_bottle_genericAlcohol_water") exitWith {
	["It's water.", false, 5, 0] call ace_common_fnc_displayText
};

private _randomMessage1 = selectRandom [
	"Interesting taste... It tastes like...",
	"Hmm, I know this flavor... It's",
	"I can't quite regognize this taste... Is it...",
	"Oh, I know! It's ",
	"Is it",
	"It has to be",
	"So tasty",
	"I have no clue what this is... Maybe",
	"Familiar taste... Maybe it's",
	"Fruity, smoky and salty... It has to be",
	"Yak! This tastes so horrible it has to be",
	"Horrible! Worst drink i've ever had! I hate",
	"Terrible aftertaste. Therefore it is",
	"I should regognize this taste... Maybe",
	"It tastes like",
	"So sweet! It's clearly",
	"I can feel like i'm in middle of Carribean after tasting this",
	"It's clearly",
	"Very familiar taste... It's clearly",
	"Yak! I hate",
	"Anyway, who though it would be good idea to invent something like",
	"Worst drink ever. There's nothing worse than",
	"So fruity and smoky",
	"Oh, it's my favorite",
	"Tastes like",
	"Tastes like",
	"Tastes like",
	"I'm in heaven after drinking this"
];

private _randomMessage2 = selectRandom [
	"Alcohol",
	"Whiskey",
	"Beer",
	"Wine",
	"White wine",
	"Fine Wine",
	"Red wine",
	"Vodka",
	"Tequila",
	"Rum",
	"Wheat beer",
	"Moomin soda",
	".. Actually, I don't know",
	"I don't know",
	"Jagermeister",
	"Margarita",
	"Bloody Mary",
	"Moscow Mule",
	"Martini",
	"Baileys",
	"Brandy",
	"Gin",
	"Applejack",
	"Best drink ever!",
	"Flavourless",
	"Gasoline",
	"Jet Fuel",
	"Soda pop",
	"Sour milk",
	"Kilju"
];





[_randomMessage1 + " " + _randomMessage2, false, 7, 0] call ace_common_fnc_displayText;




if (random 1 > 0.5) then {
	
	[player, 10] call FUNC(effect_drunk);
	
};