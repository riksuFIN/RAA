class cfgVehicles {
	class ACE_Can_Spirit_Item;
	class RAA_Can_beer_Item: ACE_Can_Spirit_Item {
		scope = 2;
		scopeCurator = 2;
		displayName = "Can (Beer)";
		author = "riksuFIN";
		vehicleClass = "Items";
		editorPreview = QPATHTOF(pics\can_beer_2.paa);		// TODO: replace this with proper pic
//		model = QPATHTOF(data\can_base.p3d);
		class TransportItems {
			class xx_RAA_Can_beer {
				name = "RAA_Can_beer";
				count = 1;
			};
		};
	};
	
	
	class RAA_Can_Beer_AlcoholFree_Item: RAA_Can_beer_Item {
		scope = 2;
		scopeCurator = 2;
		displayName = "Can (Beer 0,0 %)";
		author = "riksuFIN";
		editorPreview = QPATHTOF(pics\can_beer_1.paa);		// TODO: replace this with proper pic
//		model = QPATHTOF(data\can_base.p3d);
		class TransportItems {
			class xx_RAA_Can_beer_AlcoholFree {
				name = "RAA_Can_Beer_AlcoholFree";
				count = 1;
			};
		};
	};
	
	
	
	
	class ACE_WaterBottle_Item;
	class RAA_bottle_whiskey_Item: ACE_WaterBottle_Item {
		scope = 2;
		scopeCurator = 2;
		displayName = "Bottle (Whiskey)";
		author = "riksuFIN";
		vehicleClass = "Items";
		editorPreview = QPATHTOF(pics\bottle_whiskey.paa);		// TODO: replace this with proper pic
																								//  https://community.bistudio.com/wiki/Eden_Editor:_Configuring_Asset_Previews
		class TransportItems {
			class xx_RAA_bottle_whiskey {
				name = "RAA_bottle_whiskey";
				count = 1;
			};
		};
	};
	
	class RAA_bottle_whiskey_75_Item: RAA_bottle_whiskey_Item {
		scope = 2;
		scopeCurator = 2;
		displayName = "Bottle (Whiskey) (3/4)";
		author = "riksuFIN";
		vehicleClass = "Items";
		class TransportItems {
			class xx_RAA_bottle_whiskey_75 {
				name = "RAA_bottle_whiskey_75";
				count = 1;
			};
		};
	};
	
	class RAA_bottle_whiskey_50_Item: RAA_bottle_whiskey_Item {
		displayName = "Bottle (Whiskey) (1/2)";
		author = "riksuFIN";
		vehicleClass = "Items";
		class TransportItems {
			class xx_RAA_bottle_whiskey_50 {
				name = "RAA_bottle_whiskey_50";
				count = 1;
			};
		};
	};
	
	class RAA_bottle_whiskey_25_Item: RAA_bottle_whiskey_Item {
		displayName = "Bottle (Whiskey) (1/4)";
		author = "riksuFIN";
		vehicleClass = "Items";
		class TransportItems {
			class xx_RAA_bottle_whiskey_25 {
				name = "RAA_bottle_whiskey_25";
				count = 1;
			};
		};
	};
	
	class RAA_bottle_whiskey_empty_Item: RAA_bottle_whiskey_Item {
		displayName = "Bottle (Whiskey) (Empty)";
		author = "riksuFIN";
		vehicleClass = "Items";
		class TransportItems {
			class xx_RAA_bottle_whiskey_empty {
				name = "RAA_bottle_whiskey_empty";
				count = 1;
			};
		};
	};
	
	
	
	
	class RAA_bottle_genericAlcohol_Item: ACE_WaterBottle_Item {
		scope = 2;
		scopeCurator = 2;
		displayName = "Bottle (Alcohol)";
		author = "riksuFIN";
		vehicleClass = "Items";
		editorPreview = QPATHTOF(pics\brown_bottle_ca.png);		// TODO: replace this with proper pic
		class TransportItems {
			class xx_RAA_bottle_whiskey {
				name = "RAA_bottle_genericAlcohol";
				count = 1;
			};
		};
	};
	/*
	class RAA_bottle_genericAlcohol_23_Item: RAA_bottle_genericAlcohol_Item {
		scope = 1;
		scopeCurator = 0;
		displayName = "Bottle (Alcohol) (2/3)";
		class TransportItems {
			class xx_RAA_bottle_whiskey {
				name = "RAA_bottle_genericAlcohol_23";
				count = 1;
			};
		};
	};
	class RAA_bottle_genericAlcohol_13_Item: RAA_bottle_genericAlcohol_Item {
		scope = 1;
		scopeCurator = 0;
		displayName = "Bottle (Alcohol) (1/3)";
		class TransportItems {
			class xx_RAA_bottle_whiskey {
				name = "RAA_bottle_genericAlcohol_13";
				count = 1;
			};
		};
	};
	class RAA_bottle_genericAlcohol_empty_Item: RAA_bottle_genericAlcohol_Item {
		scope = 1;
		scopeCurator = 0;
		displayName = "Bottle (Alcohol) (Empty)";
		class TransportItems {
			class xx_RAA_bottle_whiskey {
				name = "RAA_bottle_genericAlcohol_empty";
				count = 1;
			};
		};
	};
	*/
	class RAA_bottle_genericAlcohol_water_Item: RAA_bottle_genericAlcohol_Item {
		scope = 2;
		scopeCurator = 2;
		displayName = "Bottle (Alcohol) (Water)";
		class TransportItems {
			class xx_RAA_bottle_whiskey {
				name = "RAA_bottle_genericAlcohol_water";
				count = 1;
			};
		};
	};
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	// Sitable objects
	class Furniture_Residental_base_F;
	class Land_Sofa_01_F: Furniture_Residental_base_F {
		acex_sitting_canSit = 1;
		acex_sitting_sitDirection = 0;
		acex_sitting_sitPosition[] = { {-0.6, 0.2, 0}, {0.6, 0.2, 0} };	// Z was 0.5
		acex_sitting_interactPosition[] = { {-0.5, 0, 0.2}, {0.5, 0, 0.2} };

		ace_interaction_replaceTerrainObject = 1;
		ace_dragging_canCarry = 0;
		ace_dragging_carryDirection = 0;
		ace_dragging_canDrag = 1;
		ace_dragging_dragPosition[] = {0, 1, 0};
		ace_dragging_dragDirection = 0;
	};
	
	
	
	
	
	
	
	
	/*
	class Man;
	class CAManBase: Man {
		class ACE_SelfActions {
			class field_rations {
				class RAA_advDrink_bottle {
					displayName = "Drink from water bottle (adv)";
					condition = "true";
				//    exceptions[] = {};
					statement = "[] call RAA_acex_fnc_drinkFromBottle;";
					icon = "\r\misc\addons\RAA_ACE_additions\pics\icon_aed_action";
				};
			};
		};
	};
	*/
	
	class Man;
	class CAManBase: Man {
		class ACE_SelfActions {
			class ace_field_rations {
				class RAA_fillBottleGroundwater {
					displayName = "Fill bottle from ground water";
					condition = "call RAA_acex_fnc_canFillBottle_groundWater";
				//    exceptions[] = {};
					statement = "call RAA_acex_fnc_doFillBottle_groundWater;";
				//	icon = QPATHTOF(pics\icon_aed_action);		// TODO: add proper icon
				};
				
				
				class GVAR(drinkWhileMoving) {
					displayName = "Drink While Moving";
					condition = "true";
				//	exceptions[] = {"isNotInside"};
					exceptions[] = {};
				//	statement = QUOTE(GVAR(hudInteractionHover) = true; [] call FUNC(handleHUD));
					statement = "";
					runOnHover = 0;
					insertChildren = QUOTE(_player call FUNC(drinkWhileMoving_getChildren));
					icon = QPATHTOF(pics\icon_drinkWalk.paa);
				};
				
			};
		};
	};
	
	
	
	
	
	
	
	
};