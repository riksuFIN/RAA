#include "script_component.hpp"
/* File: XEH_postInit.sqf
 * Authors: riksuFIN
 * Description:

 * Called from: config.cpp/ XEH_postInit
 * Local to: Client
 * Scheduled
 */



/*
// Compile functions
RAA_firesA_fnc_getAllAmmoModules	= compileFinal preprocessFileLineNumbers "\r\misc\addons\RAA_firesupport_additions\functions\fnc_getAllAmmoModules.sqf";
RAA_firesA_fnc_clearAndRetry	= compileFinal preprocessFileLineNumbers "\r\misc\addons\RAA_firesupport_additions\functions\fnc_clearAndRetry.sqf";

RAA_firesA_fnc_createDialog_selectSide	= compileFinal preprocessFileLineNumbers "\r\misc\addons\RAA_firesupport_additions\functions\fnc_createDialog_selectSide.sqf";
RAA_firesA_fnc_createDialog_editGun	= compileFinal preprocessFileLineNumbers "\r\misc\addons\RAA_firesupport_additions\functions\fnc_createDialog_editGun.sqf";
RAA_firesA_fnc_createDialog_editAmmo	= compileFinal preprocessFileLineNumbers "\r\misc\addons\RAA_firesupport_additions\functions\fnc_createDialog_editAmmo.sqf";

RAA_firesA_fnc_handleDialog_editGun	= compileFinal preprocessFileLineNumbers "\r\misc\addons\RAA_firesupport_additions\functions\fnc_handleDialog_editGun.sqf";
RAA_firesA_fnc_handleDialog_editAmmo	= compileFinal preprocessFileLineNumbers "\r\misc\addons\RAA_firesupport_additions\functions\fnc_handleDialog_editAmmo.sqf";
RAA_firesA_fnc_createGun	= compileFinal preprocessFileLineNumbers "\r\misc\addons\RAA_firesupport_additions\functions\fnc_create_gun.sqf";
RAA_firesA_fnc_createAmmo	= compileFinal preprocessFileLineNumbers "\r\misc\addons\RAA_firesupport_additions\functions\fnc_create_ammo.sqf";
*/



// Init all custom Zeus modules
//[] execVM "\r\misc\addons\RAA_firesupport_additions\init.sqf";
call compile preprocessFileLineNumbers QPATHTOF(init.sqf);