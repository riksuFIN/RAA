/* File: init_chat_commands.sqf
 * Author(s): riksuFIN
 * Description: Prepares all chat commands
 *
 * Called from: XEH_postInit.sqf			NOTE: Disabled for now
 * Local to: 
 * Parameter(s):
 0:	
 1:	
 2:	
 3:	
 4:	
 *
 Returns: 
 *
 * Example:	[] execVM "scripts\init_chat_commands.sqf"
*/



["hint", {
	systemChat str (_this select 0);
}, "all"] call CBA_fnc_registerChatCommand;



["random", {
	systemChat str (random (_this select 0));
}, "all"] call CBA_fnc_registerChatCommand;




