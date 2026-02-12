// https://community.bistudio.com/wiki/Modules
// https://community.bistudio.com/wiki/Eden_Editor:_Configuring_Attributes:_Controls
class CfgVehicles {
class Logic;
class Module_F: Logic {
	class AttributesBase {
		class Default;
		class Combo;
		class Edit;
		class EditArray;
		class Checkbox;
		class CheckboxNumber;
		class ModuleDescription;
		class Units;				// Selection of units on which the module is applied
	};
	class ModuleDescription {
		class AnyBrain;
	};
};
//class ACE_Module: Module_F {};

class GVAR(module_base): Module_F {
	author = "riksuFIN";
	category = "RAA_main";
	displayName = "Base. This should not be visible";
	function = "";
	functionPriority = 4;				// Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
	scope = 0;
	isGlobal = 0;						// 0 for server only execution, 1 for global execution, 2 for persistent global execution
	icon = "iconModule";
	description = "Main module for saving";

	isTriggerActivated = 0;				// 1 for module waiting until all synced triggers are activated
	isDisposable = 0;					// 1 if modules is to be disabled once it is activated (i.e. repeated trigger activation will not work)
	is3DEN = 0;							// 1 to run init function in Eden Editor as well
//	curatorCanAttach = 1;				// 1 to allow Zeus to attach the module to an entity
//	curatorInfoType = "RscDisplayAttributeModuleNuke"; // Menu displayed when the module is placed or double-clicked on by Zeus
	canSetArea = 1;				// Allows for setting the area values in the Attributes menu in 3DEN
	canSetAreaShape = 1;			// Allows for setting "Rectangle" or "Ellipse" in Attributes menu in 3DEN
	canSetAreaHeight = 1;		// Allows for setting height or Z value in Attributes menu in 3DEN
	class AttributeValues {	// This section allows you to set the default values for the attributes menu in 3DEN
		size3[] = { 100, 100, -1 };		// 3D size (x-axis radius, y-axis radius, z-axis radius)
		isRectangle = 0;				// Sets if the default shape should be a rectangle or ellipse
	};
	class Attributes: AttributesBase {
		class ModuleDescription: ModuleDescription {};
	};
	
	class ModuleDescription: ModuleDescription {
		description = "Used to save loadouts of player as well as vehicles and ammo crates in given areas and ammo";	// Short description, will be formatted as structured text
		sync[] = {};				// Array of synced entities (can contain base classes)
		class LocationArea_F {
			description[] = { // Multi-line descriptions are supported
				"First line",
				"Second line"
			};
				position = 1;	// Position is taken into effect
				direction = 1;	// Direction is taken into effect
				optional = 1;	// Synced entity is optional
				duplicate = 1;	// Multiple entities of this type can be synced
				synced[] = {};	// Pre-defined entities like "AnyBrain" can be used (see the table below)
		};
		
		class BluforUnit {
			description = "Short description";
			displayName = "Any BLUFOR unit";	// Custom name
			icon = "iconMan";					// Custom icon (can be file path or CfgVehicleIcons entry)
			side = 1;							// Custom side (determines icon color)
		};
	};
};

class GVAR(module_save_main): GVAR(module_base) {
	scope = 2;
	displayName = "Save Init";
	function = QFUNC(save_module);
	isGlobal = 2;						// 0 for server only execution, 1 for global execution, 2 for persistent global execution
	icon = "iconModule";
	description = "Main module for saving";
	canSetArea = 1;				// Allows for setting the area values in the Attributes menu in 3DEN
	canSetAreaShape = 1;			// Allows for setting "Rectangle" or "Ellipse" in Attributes menu in 3DEN
	canSetAreaHeight = 1;		// Allows for setting height or Z value in Attributes menu in 3DEN
	class AttributeValues {
		size3[] = {50,50,-1};
		IsRectangle = 0;
	};
	class Attributes: AttributesBase {
		class GVAR(save_key): Default {
			property = QGVAR(save_key);
			displayName = "Key";
			tooltip = "A short string used to identify saves from each other.\n\nNo spaces allowed!, use underscore (_) instead if needed.";
			typeName = "SCRIPT";
			control = "EditCodeShort";
			validate = "variable";
			defaultValue = """myGreatKey""";
		};
		class GVAR(saveTrigger): Combo {
			property = QGVAR(save_trigger);
			displayName = "Saving trigger";
			tooltip = "How will saving be triggered. Can also always be activated by calling function RAA_saveLoad_fnc_doSave";
			typeName = "NUMBER";
			defaultValue = 1;
			class values {
				class mission_end {
					name = "On mission end";
					tooltip = "Saving will be automatically be triggered on mission end.\n\nMission has to be ended gracefully, using endMission command or similar.";
					value = 1;
					default = 1;
				};
				class onActivation {
					name = "Manual";
					tooltip = "Either use a module 'Save: Trigger' or call following function on server:\n[] call RAA_saveLoad_fnc_doSave";
					value = 0;
				};
			};
		};
		class GVAR(SubCat11) {
			control = "SubCategoryNoHeader1";
			property = QGVAR(SubCat11);
			description = "Players";
		};
		class GVAR(loadouts): Combo {
			property = QGVAR(loadouts);
			displayName = "Save Player's Loadouts";
			tooltip = "Save invidual player's loadouts.";
			typeName = "NUMBER";
			defaultValue = 1;
			class values {
				class always {
					name = "Always";
					tooltip = "Always save indivual player's loadouts, regardless of where they are.";
					value = 1;
					default = 1;
				};
				class inSaveAreas {
					name = "Only if player's inside saving zone(s)";
					tooltip = "Save player's loadout only if they're inside one of saving zones.\n\nThese saving zones are marked by this module as well as Additional Search Locations module";
					value = 2;
				};
				class never {
					name = "Never";
					tooltip = "Do not save invidual player's loadouts.";
					value = 0;
				};
			};
		};
		class GVAR(deleteDeadsLoadout): Checkbox {
			property = QGVAR(deleteDeadsLoadout);
			displayName = "Delete Dead player's loadouts";
			tooltip = "If set loadouts of dead or in-spectator players will not be saved and any pre-existing saves will be deleted.\n\nNote: For spectator only ACE Spectator is counted, not vanilla one!";
			typeName = "BOOL";
			defaultValue = 1;
		};
		class GVAR(fillMags): Checkbox {
			property = QGVAR(fillMags);
			displayName = "Save magazine ammo count";
			tooltip = "Save exact ammo count in each magazine or fill them up?\nNumber of magazines will not be changed, only count of cartridges in them.";
			typeName = "BOOL";
			defaultValue = 1;
		};
		class GVAR(SubCat21) {
			control = "SubCategoryNoHeader1";
			property = QGVAR(SubCat21);
			description = "Vehicles";
		};
		class GVAR(saveVehicles): Checkbox {
			property = QGVAR(saveVehicles);
			displayName = "Save Vehicles";
			tooltip = "Save vehicles located within this module and 'Additional search location' module's range.";
			typeName = "BOOL";
			defaultValue = 1;
		};
		// WIP, delayed till next release
		/*
		class GVAR(saveVehicles_ammo): Checkbox {
			property = QGVAR(saveVehicles_ammo);
			displayName = "Save Ammo Count";
			tooltip = "WIP! CURRENTLY DOES NOTHING!\n\nSave vehicle's ammo. If disabled ammo count will be reset to full on load.\n\nNote: Increases savefiles size moderately.";
			typeName = "BOOL";
			defaultValue = 0;
		};
		class GVAR(saveVehicles_damage): Checkbox {
			property = QGVAR(saveVehicles_damage);
			displayName = "Save Extended Damage";
			tooltip = "WIP! CURRENTLY DOES NOTHING!\n\nSave vehicle's damage precisely. Note: Increases savefile size moderately. Vehicle's generic damage state is always saved, this is only extension to that.";
			typeName = "BOOL";
			defaultValue = 0;
		};*/
		
		class GVAR(saveVehicles_textures): Checkbox {
			property = QGVAR(saveVehicles_textures);
			displayName = "Save Textures";
			tooltip = "Save vehicle's textures. \n\nNote: Increases savefile size slighly.\n\nUse if you have vehicles that randomize their looks.";
			defaultValue = 0;
		};
		class GVAR(SubCat31) {
			control = "SubCategoryNoHeader1";
			property = QGVAR(SubCat31);
			description = "Loose Equipment";
		};
		class GVAR(ammoCrates): Checkbox {
			property = QGVAR(ammoCrates);
			displayName = "Save Equipment";
			tooltip = "Save contents of ammo crates and vehicle inventories in same areas where vehicles would be searched for.";
			defaultValue = 1;
		};
		class GVAR(SubCat41) {
			control = "SubCategoryNoHeader1";
			property = QGVAR(SubCat41);
			description = "Other";
		};
		class GVAR(testMode): Combo {
			control = "combo";
			property = QGVAR(save_testMode);
			displayName = "Testing Mode";
			tooltip = "Make testing saveLoad system in your mission easier.";
			defaultValue = 1;
			typeName = "NUMBER";
			class Values {
				class disabled {
					name = "Disable Testing Mode";
					tooltip = "Saving will always be done normally.\n\nDo note that this will always override any previous save data, including client loadouts which are saved locally. Use with caution.";
					value = 0;
				};
				class enabled_sp {
					name = "Enable Testing Mode in Singleplayer";
					tooltip = "Key will be altered to seperate SP from MP saves, allowing for testing in editor while keeping 'live' data in Multiplayer untouched.\n\nIf your campaing is only played in Multiplayer this setting is safe to leave always on.\n\nNote that self-hosted MP server is still counted as Multiplayer!";
					//tooltip = "Saving is isolated from normal saves, allowing you to safely do testing in Sinleplayer/ Editor without worrying about overriding live mission saves.\n\nSaving in Multiplayer works normally, so if your mission is played exclusively in MP it is safe to leave this setting on.";
					value = 1;
					default = 1;
				};
				class enabled {
					name = "! SAVING IS DISABLED !";
					tooltip = "Mission WILL NEVER be saved, instead a full debug data will be provided.\n\nI repeat, NO DATA WILL BE SAVED!!";
					value = 2;
				};
			};
		};
		class GVAR(showZonesMap): Combo {
			property = QGVAR(showZonesMap);
			displayName = "Show Saving Zones on Map";
			tooltip = "Who will see saving zone areas on map in form of blue circles. Usefull for knowing exactly what is within saveable zone(s)";
			typeName = "NUMBER";
			defaultValue = 2;
			class values {
				class disabled {
					name = "Disabled";
					tooltip = "Saving zones are not visible on map.";
					value = 0;
				};
				class admin {
					name = "Admin and Zeus";
					tooltip = "Show saving zones on map for admin and zeus";
					value = 2;
					default = 1;
				};
				class everyone {
					name = "Everyone";
					tooltip = "Show everyone";
					value = 1;
				};
			};
		};
		
		class ModuleDescription: ModuleDescription {};
	};
	/*
	class ModuleDescription: ModuleDescription {
		description = "Used to save loadouts of player as well as vehicles and ammo crates in given areas and ammo ";
	};*/
	class ModuleDescription: ModuleDescription {
		description = "Used to save loadouts of player as well as vehicles and ammo crates in given areas and ammo";	// Short description, will be formatted as structured text
		sync[] = {};				// Array of synced entities (can contain base classes)
	};
};





//========================== ADDITIONAL SEARCH LOCATION =============================
class GVAR(module_save_additionalSearchLocation): GVAR(module_base) {
	scope = 2;
	displayName = "Save: Additional Search Location";
//	function = QFUNC(test);
	icon = "iconModule";
	canSetArea = 1;				// Allows for setting the area values in the Attributes menu in 3DEN
	canSetAreaShape = 1;			// Allows for setting "Rectangle" or "Ellipse" in Attributes menu in 3DEN
	canSetAreaHeight = 1;		// Allows for setting height or Z value in Attributes menu in 3DEN
	class AttributeValues {
		size3[] = {100,100,-1};
		IsRectangle = 0;
	};
	class Attributes: AttributesBase {
		
		
	//	class ModuleDescription: ModuleDescription {};
	};
	class ModuleDescription: ModuleDescription {
		description = "Used to mark additional locations to search vehicles and ammo boxes from.";	// Short description, will be formatted as structured text
		sync[] = {};				// Array of synced entities (can contain base classes)
		position = 1;
	};
};



//========================== SAVE TRIGGER =============================
class GVAR(module_save_trigger): GVAR(module_base) {
	scope = 2;
	displayName = "Save: Trigger";
	function = QFUNC(doSave);
	functionPriority = 0;
	isGlobal = 0;						// 0 for server only execution, 1 for global execution, 2 for persistent global execution
	isTriggerActivated = 1;				// 1 for module waiting until all synced triggers are activated
	isDisposable = 0;					// 1 if modules is to be disabled once it is activated (i.e. repeated trigger activation will not work)
	icon = "iconModule";
	canSetArea = 0;				// Allows for setting the area values in the Attributes menu in 3DEN
	canSetAreaShape = 0;			// Allows for setting "Rectangle" or "Ellipse" in Attributes menu in 3DEN
	canSetAreaHeight = 0;		// Allows for setting height or Z value in Attributes menu in 3DEN
	class Attributes: AttributesBase {
		
		class ModuleDescription: ModuleDescription {};
	};
	class ModuleDescription: ModuleDescription {
		description = "Synchronize this module to a trigger to save mission when that trigger activates.<br/>This is altenerative to just calling following function on server: [] call RAA_saveLoad_fnc_doSave";	// Short description, will be formatted as structured text
		sync[] = {"EmptyDetector"};				// Array of synced entities (can contain base classes)
		position = 0;
		optional = 0;	// Synced entity is optional
	};
};


//========================== SAVE ZEUS =============================
class GVAR(module_save_zeus): GVAR(module_base) {
	scope = 2;
	scopeCurator = 2;
	displayName = "SaveLoad: Save";
	function = "[] call FUNC(doSave)";
	isGlobal = 0;						// 0 for server only execution, 1 for global execution, 2 for persistent global execution
	isTriggerActivated = 0;				// 1 for module waiting until all synced triggers are activated
	isDisposable = 0;					// 1 if modules is to be disabled once it is activated (i.e. repeated trigger activation will not work)
	icon = "iconModule";
	canSetArea = 0;				// Allows for setting the area values in the Attributes menu in 3DEN
	canSetAreaShape = 0;			// Allows for setting "Rectangle" or "Ellipse" in Attributes menu in 3DEN
	canSetAreaHeight = 0;		// Allows for setting height or Z value in Attributes menu in 3DEN
	class Attributes: AttributesBase {
		
		class ModuleDescription: ModuleDescription {};
	};
	class ModuleDescription: ModuleDescription {
		description = "Synchronize this module to a trigger to save mission when that trigger activates.<br/>This is altenerative to just calling following function on server: [] call RAA_saveLoad_fnc_doSave";	// Short description, will be formatted as structured text
		sync[] = {"EmptyDetector"};				// Array of synced entities (can contain base classes)
		position = 0;
		optional = 0;	// Synced entity is optional
	};
};


//========================== BLACKLIST =============================
class GVAR(module_blacklist): GVAR(module_base) {
	scope = 2;
	displayName = "SaveLoad: Blacklist";
//	function = QFUNC(save_blacklist);
	canSetArea = 0;
	icon = "iconModule";
	class Attributes: AttributesBase {
		
		class GVAR(SubCat1) {
			control = "SubCategoryNoHeader2";
			property = QGVAR(SubCat1);
			description = "Synchronize this module to objects you do not wish to be saved and loaded.";
		};
		class GVAR(SubCat2) {
			control = "SubCategoryNoHeader2";
			property = QGVAR(SubCat2);
			displayName = "Accepted values:";
			description = "You can also write any of following values to field below: player's SteamID64 or Nickname (wrapped in quotes) ";
		};
		class GVAR(blacklist): Edit {
			control="EditArray";
			property = QGVAR(blacklist);
			displayName = "Blacklist entries";
			tooltip = "Seperate entries with commas.\nNickname must be wrapped in quotes, everything else is plain.";
		//	typeName = "STRING";
		//	validate = "expression";
			defaultValue = "[]";
		};

	//	class ModuleDescription: ModuleDescription {};
	};
	class ModuleDescription: ModuleDescription {
		description = "Synchronize to any objects/ vehicles/ units you DO NOT wish to be saved and loaded.<br/><br/>You can also enter player's SteamID64 or in-game nickname to exclude them from saving function";	// Short description, will be formatted as structured text
		sync[] = {};				// Array of synced entities (can contain base classes)
		position = 0;
	};
};



//========================== LOAD: Main =============================
class GVAR(module_load_main): GVAR(module_base) {
	displayName = "Load Init";
	function = QFUNC(load_module);
	scope = 2;
	isGlobal = 2;						// 0 for server only execution, 1 for global execution, 2 for persistent global execution
	icon = "iconModule";
	description = "Main module for Loading saved mission";
	canSetArea = 0;				// Allows for setting the area values in the Attributes menu in 3DEN
	canSetAreaShape = 0;			// Allows for setting "Rectangle" or "Ellipse" in Attributes menu in 3DEN
	canSetAreaHeight = 0;		// Allows for setting height or Z value in Attributes menu in 3DEN
	class Attributes: AttributesBase {
		class GVAR(save_key): Default {
			property = QGVAR(save_key);
			displayName = "Key";
			tooltip = "A string used to identify saves from each other.\n\nNo spaces allowed!, use underscore (_) instead if needed";
			typeName = "SCRIPT";
			control = "EditCodeShort";
			validate = "variable";
			defaultValue = """myGreatKey""";
		};
		class GVAR(SubCat1) {
			control = "SubCategoryNoHeader1";
			property = QGVAR(SubCat1);
			description = "Players";
		};
		class GVAR(loadouts): Checkbox {
			property = QGVAR(loadouts);
			displayName = "Load Loadouts";
			tooltip = "Load invidual player's loadouts";
			typeName = "BOOL";
			defaultValue = 1;
		};
		class GVAR(fieldRations): Checkbox {
			property = QGVAR(fieldRations);
			displayName = "Load Hunger/ Thirst";
			tooltip = "Load each player's hunger and thirst values (if ACE Field Rations is enabled)";
			typeName = "BOOL";
			defaultValue = 1;
		};
		class GVAR(playerpos): Checkbox {
			property = QGVAR(playerpos);
			displayName = "Player's position";
			tooltip = "Load player's location(s).\nIf enabled players will be moved exactly where they were at during saving.\n\nIf disabled players will be where they are placed in Editor.";
			typeName = "BOOL";
			defaultValue = 0;
		};
		class GVAR(SubCat2) {
				control = "SubCategoryNoHeader1";
				property = QGVAR(SubCat2);
				description = "Vehicles";
		};
		class GVAR(loadVehicles): Checkbox {
			property = QGVAR(loadVehicles);
			displayName = "Load Vehicles";
			tooltip = "Load saved vehicles. This includes all static weapons.";
			defaultValue = 1;
		};
		class GVAR(vehicles_fuel): Checkbox {
			property = QGVAR(vehicles_fuel);
			displayName = "Load fuel level";
			tooltip = "Load vehicle's fuel level or refuel it";
			typeName = "BOOL";
			defaultValue = 1;
		};
		class GVAR(vehicles_ammo): Checkbox {
			property = QGVAR(vehicles_ammo);
			displayName = "Load ammo level";
			tooltip = "Load vehicle's ammo level or rearm it to full?";
			typeName = "BOOL";
			defaultValue = 1;
		};
		class GVAR(vehicles_damage): Checkbox {
			property = QGVAR(vehicles_damage);
			displayName = "Load damage status";
			tooltip = "Load vehicle's damage or will it be spawned spotless and waxed?";
			typeName = "BOOL";
			defaultValue = 1;
		};
		class GVAR(subCat3) {
			property = QGVAR(subCat3);
			control = "SubCategoryNoHeader1";
			description = "Loose Equipment";
		};
		class GVAR(equipment): Checkbox {
			property = QGVAR(equipment);
			displayName = "Load Equipment";
			tooltip = "Load gear stored in containers, crates and vehicle inventories during saving?\n\nAll items will be spawned in several boxes, sorted by their type.\nThese boxes can either be auto-spawned to this module's location or manually defined using seperate module.";
			typeName = "BOOL";
			defaultValue = 1;
		};
		class GVAR(ammoCrates_empty): Checkbox {
			property = QGVAR(ammoCrates);
			displayName = "Load Empty Ammo Crates";
			tooltip = "Any gear that was stored in crates will be loaded in new, sorted boxes. Should we still load old, empty boxes?";
			typeName = "BOOL";
			defaultValue = 0;
		};
		
		class ModuleDescription: ModuleDescription {};
	};
	class ModuleDescription: ModuleDescription {
		description = "Used to load equipment for players, gear from boxes and vehicles saved using RAA_SaveLoad -series 'Save' Modules.";	// Short description, will be formatted as structured text
		sync[] = {};				// Array of synced entities (can contain base classes). This is used for user's info only? Not actual data validation?
	};
};


//========================== DEFINE GEAR SPAWN CRATE =============================
class GVAR(module_load_defineCrate): GVAR(module_base) {
	displayName = "Load: Configure Crate";
	scope = 2;
	canSetArea = 0;
	icon = "iconModule";
	class Attributes: AttributesBase {
		class GVAR(clearCrate): Checkbox {
			property = QGVAR(clearCrate);
			displayName = "Clear container's inventory";
			tooltip = "Empty out container to avoid any extra items in container.\n\nShould only be disabled if you want to provide some extra items of your choise in this container.";
			typeName = "BOOL";
			defaultValue = 1;
		};
		class GVAR(SubCategoryNoHeader2) {
				control = "SubCategoryNoHeader1";
				property = QGVAR(subCat_loadCrCfg_1);
				displayName = "Configure crate";
				description = "Select what items a crate synchronized to this module should contain.";
		};
		class GVAR(crate_weapons): Checkbox {
			property = QGVAR(crate_weapons);
			displayName = "Weapons";
			tooltip = "";
			typeName = "BOOL";
			defaultValue = 0;
		};
		class GVAR(crate_magazines): Checkbox {
			property = QGVAR(crate_magazines);
			displayName = "Magazines";
			tooltip = "";
			typeName = "BOOL";
			defaultValue = 0;
		};
		class GVAR(crate_gear): Checkbox {
			property = QGVAR(crate_gear);
			displayName = "Gear";
			tooltip = "Anything wearable";
			typeName = "BOOL";
			defaultValue = 0;
		};
		class GVAR(crate_medical): Checkbox {
			property = QGVAR(crate_medical);
			displayName = "Medical";
			tooltip = "All medical items";
			typeName = "BOOL";
			defaultValue = 0;
		};
		class GVAR(crate_items): Checkbox {
			property = QGVAR(crate_items);
			displayName = "Items";
			tooltip = "Anything that does not fit any other categories";
			typeName = "BOOL";
			defaultValue = 0;
		};
		
		class ModuleDescription: ModuleDescription {};
	};
	class ModuleDescription: ModuleDescription {
		description = "Synchronize this to anything with inventory space and configure what will items will be loaded inside from savefile.";	// Short description, will be formatted as structured text
		sync[] = {};				// Array of synced entities (can contain base classes)
		position = 0;
		direction = 0;
		optional = 0;
		duplicate = 0;
	};
};


//========================== Vehicle spawn pos for load =============================
class GVAR(module_load_vehSpawnPos): GVAR(module_base) {
	displayName = "Load: Vehicle Spawn Position";
	scope = 2;
	canSetArea = 0;
	icon = "iconModule";
	class Attributes: AttributesBase {
		class GVAR(subCat1) {
			control = "SubCategoryNoHeader2";
			property = QGVAR(subCat_loadCrCfg_1);
			description = "Select what types of vehicles are spawned here. If spawn position is undefined vehicle will be loaded exactly where it was during saving.";
		};
		class GVAR(crates): Checkbox {
			property = QGVAR(crates);
			displayName = "Ammo Crates";
			tooltip = "Empty ammo crates only. \nContents are loaded elsewhere, as defined by Load: Main and Load: Configure Crate modules.";
			defaultValue = 1;
		};
		class GVAR(cars): GVAR(crates) {
			property = QGVAR(cars);
			displayName = "Cars";
			tooltip = "";
		};
		class GVAR(tanks): GVAR(crates) {
			property = QGVAR(tanks);
			displayName = "Tanks";
			tooltip = "";
		};
		class GVAR(aircrafts): GVAR(crates) {
			property = QGVAR(aircrafts);
			displayName = "Aircrafts.";
			tooltip = "Anything that can fly";
		};
		class GVAR(turrets): GVAR(crates) {
			property = QGVAR(turrets);
			displayName = "Static Weapons";
			tooltip = "";
		};
		class GVAR(other): GVAR(crates) {
			property = QGVAR(other);
			displayName = "Other";
			tooltip = "Everything else.";
		};
		
		
		class ModuleDescription: ModuleDescription {};
	};
	class ModuleDescription: ModuleDescription {
		description = "A vehicle will be spawned at or near this position when loading a save.IF THIS MODULE IS NOT PRESENT IN MISSION all vehicles will be spawned exactly where they were!";	// Short description, will be formatted as structured text
		sync[] = {"Anything"};				// Array of synced entities (can contain base classes)
		position = 1;
		optional = 1;
	};
};

/*
//========================== Clear Saved Data =============================
class GVAR(module_clearSaveData): GVAR(module_base) {
	displayName = "saveLoad: Clear Savedata";
	function = QFUNC(clear_saveData);
	scope = 2;
	canSetArea = 0;
	icon = "iconModule";
	class Attributes: AttributesBase {
		class GVAR(SubCategoryNoHeader2) {
				control = "SubCategoryNoHeader";
				property = QGVAR(subCat_loadCrCfg_1);
				displayName = "Select vehicle types spawned to this position";
				description = "IMPORTANT: Adding this module will override vehicle's saved location!";
			};
		class GVAR(save_key): Default {
			property = QGVAR(save_key);
			displayName = "Key";
			tooltip = "A string used to identify saves from each other.\n\nNO spaces allowed!, use underscore (_) instead if needed";
			typeName = "SCRIPT";
			control = "EditCodeShort";
			validate = "variable";
			defaultValue = """myGreatKey""";
		};
		class GVAR(confirm): Default {
			property = QGVAR(crates);
			displayName = "I understand what this module does.";
			tooltip = "Check this to confirm that you understand that this module will delete all saved data under provided key from both server and clients on mission end.";
			typeName = "BOOL";
			control = "CheckboxState";
			defaultValue = 1;
		};
		
		
		class ModuleDescription: ModuleDescription {};
	};
	class ModuleDescription: ModuleDescription {
		description = "This module is used at end of campaing instead of Save Init module to clear previously saved data to reduce filesize.";	// Short description, will be formatted as structured text
		sync[] = {"Anything"};				// Array of synced entities (can contain base classes)
		position = 1;
		optional = 1;
	};
};
*/

};	// End of cfgVehicles