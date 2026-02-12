class CfgPatches
{
	class nagas_Convoy
	{
		units[] = {"nagas_Convoy"};
		requiredVersion = 1.0;
		requiredAddons[] = {"A3_Modules_F"};
	};
};

class CfgFactionClasses
{
	class NO_CATEGORY;
	class nagas_mechanics: NO_CATEGORY
	{
		displayName = "Mechanics";
	};
};

class CfgVehicles
{
	class Logic;
	class Module_F: Logic
	{
		class AttributesBase
		{
			class Default;
			class Edit;					// Default edit box (i.e., text input field)
			class Combo;				// Default combo box (i.e., drop-down menu)
			class Checkbox;				// Default checkbox (returned value is Boolean)
			class CheckboxNumber;		// Default checkbox (returned value is Number)
			class ModuleDescription;	// Module description
			class Units;				// Selection of units on which the module is applied
		};
		// Description base classes, for more information see below
		class ModuleDescription
		{
			class AnyBrain;
		};
	};
	class nagas_Convoy: Module_F
	{
		// Standard object definitions
		scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
		displayName = "Convoy"; // Name displayed in the menu
		icon = "\a3\ui_f\data\igui\cfg\simpletasks\types\truck_ca.paa"; // Map icon. Delete this entry to use the default icon
		category = "Effects";
		
		// Name of function triggered once conditions are met
		function = "myTag_fnc_initConvoy";
		// Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
		functionPriority = 1;
		// 0 for server only execution, 1 for global execution, 2 for persistent global execution
		isGlobal = 0;
		// 1 for module waiting until all synced triggers are activated
		isTriggerActivated = 0;
		// 1 if modules is to be disabled once it is activated (i.e., repeated trigger activation won't work)
		isDisposable = 1;
		// 1 to run init function in Eden Editor as well
		is3DEN = 0;

		// Menu displayed when the module is placed or double-clicked on by Zeus
		curatorInfoType = "RscDisplayAttributeModuleNuke";

		// Module attributes, uses https://community.bistudio.com/wiki/Eden_Editor:_Configuring_Attributes#Entity_Specific
		class Attributes: AttributesBase
		{
			// Arguments shared by specific module type (have to be mentioned in order to be present)
			class Units: Units
			{
				//property = "blake_moduleAudio_Units";
			};
			// Module specific arguments
			class maxSpeed: Edit
			{
				// Unique property, use "<moduleClass>_<attributeClass>" format to make sure the name is unique in the world
				property = "nagas_convoy_maxSpeed";
				displayName = "Max Speed"; // Argument label
				tooltip = "Maximum speed of the convoy, in km/h."; // Tooltip description
				typeName = "NUMBER"; // Value type, can be "NUMBER", "STRING" or "BOOL"
				defaultValue = "40"; // Default attribute value. WARNING: This is an expression, and its returned value will be used (50 in this case)
			};
			class convSeparation: Edit
			{
				displayName = "Convoy Separation";
				property = "nagas_convoy_convSeparation";
				tooltip = "Convoy separation distance, in meters.";
				typeName = "NUMBER"; // Value type, can be "NUMBER", "STRING" or "BOOL"
				defaultValue = "35";
			};
			class stiffnessCoeff: Edit
			{
				displayName = "Convoy Stiffness";
				property = "nagas_convoy_stiffnessCoeff";
				tooltip = "How much should the lead vehicle brake, in order to establish the desired convoy separation.";
				typeName = "NUMBER"; // Value type, can be "NUMBER", "STRING" or "BOOL"
				defaultValue = "0.2";
			};
			class dampingCoeff: Edit
			{
				displayName = "Convoy Damping";
				property = "nagas_convoy_dampingCoeff";
				tooltip = "How much should the lead vehicle brake, in order to minimize the relative speeds between the vehicles.";
				typeName = "NUMBER"; // Value type, can be "NUMBER", "STRING" or "BOOL"
				defaultValue = "0.6";
			};
			class curvatureCoeff: Edit
			{
				displayName = "Curvature Coefficient";
				property = "nagas_convoy_curvatureCoeff";
				tooltip = "How much should the lead vehicle brake, when traversing winding roads.";
				typeName = "NUMBER"; // Value type, can be "NUMBER", "STRING" or "BOOL"
				defaultValue = "0.3";
			};
			class stiffnessLinkCoeff: Edit
			{
				displayName = "Link Stiffness";
				property = "nagas_convoy_stiffnessLinkCoeff";
				tooltip = "How much should a follower vehicle accelerate and break, in order to establish the desired convoy separation with the vehicle in front.";
				typeName = "NUMBER"; // Value type, can be "NUMBER", "STRING" or "BOOL"
				defaultValue = "0.1";
			};
			class pathFrequecy: Edit
			{
				displayName = "Path Frequency";
				property = "nagas_convoy_pathFrequecy";
				tooltip = "Path update frequency, in seconds (adjust for performance).";
				typeName = "NUMBER"; // Value type, can be "NUMBER", "STRING" or "BOOL"
				defaultValue = "0.05";
			};
			class speedFrequecy: Edit
			{
				displayName = "Speed Control Frequency";
				property = "nagas_convoy_speedFrequecy";
				tooltip = "Speed control update frequency, in seconds (adjust for performance).";
				typeName = "NUMBER"; // Value type, can be "NUMBER", "STRING" or "BOOL"
				defaultValue = "0.2";
			};
			class speedModeConv: Combo
			{
				// Unique property, use "<moduleClass>_<attributeClass>" format to make sure the name is unique in the world
				property = "nagas_convoy_speedMode";
				displayName = "Convoy Speed Mode"; // Argument label
				tooltip = "Change the Speed Mode for all the convoy's groups."; // Tooltip description
				typeName = "STRING"; // Value type, can be "NUMBER", "STRING" or "BOOL"
				defaultValue = """Normal"""; // Default attribute value. WARNING: This is an expression, and its returned value will be used (50 in this case)
				class Values
				{
					class 0	{name = "Unchanged";	value = "UNCHANGED";}; // Listbox item
					class 1	{name = "Limited"; 		value = "LIMITED";};
					class 2	{name = "Normal"; 		value = "NORMAL";};
					class 3	{name = "Full"; 		value = "FULL";};
				};
			};
			/* class followRoad: Combo
			{
				// Unique property, use "<moduleClass>_<attributeClass>" format to make sure the name is unique in the world
				property = "nagas_convoy_followRoad";
				displayName = "Follow the Road"; // Argument label
				tooltip = "Forces convoy leader to follow the road (might work better in some cases)."; // Tooltip description
				typeName = "STRING"; // Value type, can be "NUMBER", "STRING" or "BOOL"
				defaultValue = """NO"""; // Default attribute value. WARNING: This is an expression, and its returned value will be used (50 in this case)
				class Values
				{
					class 0	{name = "Unchanged";	value = "UNCHANGED";}; // Listbox item
					class 1	{name = "No"; 			value = "NO";};
					class 2	{name = "Yes"; 			value = "YES";};
				};
			}; */
			class behaviourConv: Combo
			{
				// Unique property, use "<moduleClass>_<attributeClass>" format to make sure the name is unique in the world
				property = "nagas_convoy_behaviourConv";
				displayName = "Behaviour"; // Argument label
				tooltip = "Forces convoy vehicles to push through enemy contact."; // Tooltip description
				typeName = "STRING"; // Value type, can be "NUMBER", "STRING" or "BOOL"
				defaultValue = """pushThroughContact"""; // Default attribute value. WARNING: This is an expression, and its returned value will be used (50 in this case)
				class Values
				{
					class 0	{name = "Aware";				value = "AWARE";}; // Listbox item
					class 1	{name = "Push Through Contact"; value = "pushThroughContact";};
				};
			};
			/* class followRoad: Checkbox
			{
				displayName = "Follow the Road";
				property = "nagas_convoy_followRoad";
				tooltip = "Forces convoy leader to follow the road (might work better in some cases).";
				typeName = "BOOL"; // Value type, can be "NUMBER", "STRING" or "BOOL"
				defaultValue = "false";
			}; */
			class debug: Checkbox
			{
				displayName = "Debug";
				property = "nagas_convoy_debug";
				tooltip = "Draw paths.";
				typeName = "BOOL"; // Value type, can be "NUMBER", "STRING" or "BOOL"
				defaultValue = "false";
			};
			class ModuleDescription: ModuleDescription{}; // Module description should be shown last
		};

		// Module description. Must inherit from base class, otherwise pre-defined entities won't be available
		class ModuleDescription: ModuleDescription
		{
			description[] = 
			{ 
				"This module is used to compose a vehicle convoy.", 
				"First, place the vehicles in distinct groups. Then, sync the vehicles with this module.",
				"The sync order dictates the order of the convoy."
			};							 // Short description, will be formatted as structured text
			/* sync[] = {"LocationArea_F"}; // Array of synced entities (can contain base classes)

			class LocationArea_F
			{
				position = 0; // Position is taken into effect
				optional = 0; // Synced entity is optional
				duplicate = 0; // Multiple entities of this type can be synced
				synced[] = {"Anything"}; // Pre-define entities like "AnyBrain" can be used. See the list below
			}; */
		};
	};
};

class CfgFunctions
{
	class nagas_Convoy
	{
		class Effects
		{
			file = "\nagas_Convoy\functions";
			class initConvoy{};
		};
	};
};