RAA_save v2.0
A system made by riksuFIN to save:
	- Loadouts of players
	- Vehicles in defined area(s) and near players
	- Inventory of vehicles and ammo crates in defined area(s) and near players

.. And load them to next mission, whether that was same mission base at next playing session, or next mission in form of campaign



---------------------------------------------
------------ USAGE INSTRUCTIONS -------------
---------------------------------------------

------------------------------------
---- 1. PREPARATIONS IN EDITOR -----
------------------------------------
1. Place ONE map marker where you want your base/ start location to be and give it VARIABLE name of your choice
	This will be where loaded inventory items will be spawned
	
(Optional) 2. Place 5 objects with inventory space (Ammo crates, vehicles, etc) where you want loaded items to be spawned (Has to be within 150m of previously created marker)
				Items are organized into 5 categories: Weapons, Ammo, Medical, Containers (backpacks, vests etc) and Items
				Those are defined by adding following to each object's init field: 
					this setVariable ["RAA_load_boxType", "WEAPONS"];
				Replace "WEAPONS" with whatever that container will contain. Possible values: 
					"WEAPONS"
					"MAGAZINES"
					"ITEMS"
					"BACKPACKS"
					"MEDICAL"
								Single object can contain several categories. Single category can only have one object defined

3. Place one or more map markers where you want saved vehicles to be spawned and give them VARIABLE name(s) of your choice

(Optional) 4. If you want vehicles that are within saving areas but you do not want to be saved (i.e. editor-placed vehicles in editor. If they're saved they would be duplicated on load):
				Place following to each vehicle(s) init field:
					this setVariable ["RAA_save_blacklist", true];
				Any objects with this line will be ignored by saving script




-----------------------------
----- 2. SAVING MISSION -----
-----------------------------
fnc_doSave.sqf:
- MUST be executed GLOBALLY
- MUST be executed before mission end, when all players still have their full equipment

In missions with Zantzan's Framework best way to do this is to place this:

[
	"myGreatKey",	// Key
	true,		// Save loadouts
	false,	// Delete dead player's loadouts
	false,	// Fill up any partial mags in players loadouts
	true,		// Save vehicles
	true,		// Save ammo crates content
	25,		// Search distance around players for vehicles and ammo crates
	[getMarkerPos "mark_base"],	// Additional search locations (i.e. Base)
	[],		// Blacklisted objects never saved
	true,		// Save to RTP as well. Serves as a backup, should be kept enabled
	false		// Debug
] call compileFinal preprocessFileLineNumbers "RAA_save\fnc_doSave.sqf";

.. to:
[mission folder]\za_framework\statistics\fnc_endmission.sqf line 79 
	(AFTER 'if (isNil "zafw_statistics_missionstarttime") exitWith'..., BEFORE 'if (isServer)''...)


Check all parameters and change to your liking.
Make sure "Additional search locations" is updated with name of marker you created
This parameter wants array of positions (Can be more than one), which can be provided any way you like, getMarkerPos is just one of them

Refer to file RAA_save\fnc_doSave.sqf for more details



-----------------------------
---- 3. LOADING MISSION -----
-----------------------------
fnc_doLoad.sqf:
	- MUST be executed GLOBALLY
	- INTENDED to be executed early at mission start

Easiest way to accomplish this is by adding following to init.sqf:
(Do note: Has to be executed on both clients AND server, so don't place it anywhere inside brackets)

[
	"myGreatKey",		// Key
	true,			// Load loadouts
	true,			// Load vehicles
	["mark_vehSpawn_1", "mark_vehSpawn_2", "mark_vehSpawn_3", "mark_vehSpawn_4"],		// ARRAY of MARKERS where to spawn vehicles (Picked randomly)
	true,			// Load gear stored in ammo crates
	true,			// Clear gear crates of any pre-existing stuff
	"mark_base",	// MARKER where existing ammo crates are searched for, and, if missing, new ones are spawned at
	[],			// ARRAY of classnames of vehicles that are not loaded, and object references to players whose loadouts are not loaded
	false			// Debug
] call compileFinal preprocessFileLineNumbers "RAA_save\fnc_doLoad.sqf";


Check all parameters in code above and change to your liking.
Especially make sure you update marker names to match what you placed in step 1

Refer to file RAA_save\fnc_doLoad.sqf for more details

NOTE: Zanza's Framework deletes any pre-existing medical gear, and so does this function.
So there _will_ be conflict! Propably best to disable ZAFW medical gear spawning and add them yourself to starting loadout.




ADDITIONALLY if you're creating a mission series (campaign) and you want same save to be available across different missions of different names
you must add following line to description.ext
	missionGroup = "ChangeThisToMatchYourCampaign";

For single missions that never changes its file name this is not necessary

More info:
https://community.bistudio.com/wiki/Description.ext#missionGroup












==============================================
||               T O    D O                 ||
==============================================
- doLoad:
	- Vaihda käyttämään koordinaatteja (position)

doSave:
	-
	
	
Both:
	- Tallenna jano/ nälkä





==============================================
||          C H A N G E L O G S             ||
==============================================
v2.0
	- Converted to mod format
	- DoLoad changed to use positionAGL(S) everywhere instead of requiring markers for locations
	- DoSave changed to use positionAGL everywhere
	- Now medical items sorting is fully supported, including all mods (as long as they inherit from ACE medical items)
	- Now supports saving ACE Fieldrations



TODO:
	Blacklist: Consider adding support for blacklisting a typeName https://community.bistudio.com/wiki/isKindOf
		Could be excessively heave on performance?
	
	
https://community.bistudio.com/wiki/Modules
https://community.bistudio.com/wiki/Eden_Editor:_Configuring_Attributes:_Controls#Slider