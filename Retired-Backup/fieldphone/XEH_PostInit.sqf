#include "script_component.hpp"
/* File: XEH_postInit.sqf
 * Authors: riksuFIN
 * Description: 

 * Called from: config.cpp/ XEH_postInit
 * Local to: 
 * Scheduled
 */





GVAR(connectedPhones) = [];	// ARRAY of phone connected to each cable. Used for ringing function
GVAR(connectedPhones) resize [15, []];		// Number of channels available for using
GVAR(channelOffset) = 50;		// Offset in channel numbers for actual radio
// 148 radio supports channels 17-32 at group 2
// 152 radio supports channels 1 - 99