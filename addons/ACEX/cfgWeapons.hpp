#define PRIVATE 0
#define PROTECTED 1
#define PUBLIC 2

class cfgWeapons
{
	// ---- CANS (DRINK)
	class ACE_Can_Spirit;
	class RAA_Can_beer: ACE_Can_Spirit {
		author = "riksuFIN";
		displayName = "Can (Beer)";
		descriptionShort = "A nice, (not-so) cold can of beer";
    	model = QPATHTOF(data\can_beer2.p3d);
		picture = QPATHTOF(pics\can_beer_2);
		acex_field_rations_thirstQuenched = 5;
    };

	class RAA_Can_Beer_AlcoholFree: RAA_Can_beer {
		displayName = "Can (Beer 0,0 %)";
		descriptionShort = "A nice, (not-so) cold can of beer. This one is without alcohol!";
    	model = QPATHTOF(data\can_beer1.p3d);
		picture = QPATHTOF(pics\can_beer_1);
		acex_field_rations_thirstQuenched = 5;
    };


	class RAA_Can_ES: ACE_Can_Spirit {
		author = "riksuFIN";
		displayName = "Can (Energy Drink)";
		descriptionShort = "Get some energy from EuroShooter!";
    //	model = "\a3\structures_f\items\food\can_v2_f.p3d";
		picture = QPATHTOF(pics\can_ES);
	//	acex_field_rations_thirstQuenched = 0;
    };


		// ---- BOTTLES
	class ACE_WaterBottle;
	class RAA_sodaBottle: ACE_WaterBottle {	// Moomin soda
        author = "riksuFIN";
        displayName = "Moomin Soda Bottle";
        descriptionShort = "Refreshing bottle of soda pop";
		picture = QPATHTOF(pics\soda_bottle_moomin);
		acex_field_rations_replacementItem = "RAA_sodaBottle_half";
		acex_field_rations_consumeTime = 10;
		acex_field_rations_thirstQuenched = 9;
    };


	class RAA_sodaBottle_mixed: RAA_sodaBottle {	// Moomin soda Diluted
		scopeArsenal = PRIVATE;
		displayName = "Moomin Soda Bottle (diluted)";
		descriptionShort = "Tasty Moomin Soda. Mixed with water. Yuck!";
		picture = QPATHTOF(pics\soda_bottle_moomin);
		acex_field_rations_replacementItem = "RAA_sodaBottle_mixed_half";
		acex_field_rations_consumeTime = 10;
		acex_field_rations_thirstQuenched = 6;
	};

	class CBA_MiscItem_ItemInfo;
	class RAA_sodaBottle_mixed_half: RAA_sodaBottle {	// Moomin soda Diluted Half
		scopeArsenal = PRIVATE;
		displayName = "Moomin Soda Bottle (diluted) (Half)";
		descriptionShort = "Tasty Moomin Soda. Mixed with water. Yuck!<br/><br/>Thankfully half of it is already gone";
		picture = QPATHTOF(pics\soda_bottle_moomin_half);
		acex_field_rations_replacementItem = "RAA_sodaBottle_empty";
        acex_field_rations_refillItem = "RAA_sodaBottle_mixed";
        acex_field_rations_refillAmount = 0.5;
        acex_field_rations_refillTime = 6;
		
		class ItemInfo: CBA_MiscItem_ItemInfo {
			mass = 3;
		};
	};

    class RAA_sodaBottle_half: RAA_sodaBottle {	// Half bottle of Moomin soda
        displayName = "Moomin Soda Bottle (Half)";
        descriptionShort = "Refreshing bottle of soda pop. It's still half full! Or is it half empty?";
		picture = QPATHTOF(pics\soda_bottle_moomin_half);
		acex_field_rations_replacementItem = "RAA_sodaBottle_empty";
        acex_field_rations_refillItem = "RAA_sodaBottle_mixed";
        acex_field_rations_refillAmount = 0.5;
        acex_field_rations_refillTime = 6;

	   class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 3;
        };
	};


    class RAA_sodaBottle_empty: RAA_sodaBottle {	// Empty moomin soda
        displayName = "Moomin Soda Bottle (Empty)";
        descriptionShort = "Refreshing bottle of soda pop. Too bad someone already drank it all.";
		picture = QPATHTOF(pics\soda_bottle_moomin_empty);

        acex_field_rations_thirstQuenched = 0;
        acex_field_rations_replacementItem = "";
        acex_field_rations_refillItem = "ACE_WaterBottle";
        acex_field_rations_refillAmount = 1;
        acex_field_rations_refillTime = 8;
		class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
	
	
	
	class RAA_bottle_whiskey: RAA_sodaBottle {	// Bottle of whiskey
		displayName = "Whiskey Bottle";
		descriptionShort = "Quality, Barrel-aged whiskey you 'found' from somewhere.";
		model = QPATHTOF(data\bottle_whiskey.p3d);
		picture = QPATHTOF(pics\bottle_whiskey);

		acex_field_rations_thirstQuenched = 3;
		acex_field_rations_replacementItem = "RAA_bottle_whiskey_75";
		acex_field_rations_refillItem = "";		// Cannot be refilled
		acex_field_rations_refillAmount = 0;
		acex_field_rations_refillTime = 8;
		class ItemInfo: CBA_MiscItem_ItemInfo {
			mass = 15;	// 0,68 kg
		};
	};
	
	class RAA_bottle_whiskey_75: RAA_bottle_whiskey {	// Bottle of whiskey
		displayName = "Whiskey Bottle (3/4)";
		descriptionShort = "Quality, Barrel-aged whiskey you 'found' from somewhere.";
	//	model = "\a3\structures_f\items\food\can_v2_f.p3d";
		picture = QPATHTOF(pics\bottle_whiskey);
		
		acex_field_rations_replacementItem = "RAA_bottle_whiskey_50";
		class ItemInfo: CBA_MiscItem_ItemInfo {
			mass = 13.07;
		};
	};
	
	class RAA_bottle_whiskey_50: RAA_bottle_whiskey {	// Bottle of whiskey
		displayName = "Whiskey Bottle (1/2)";
		descriptionShort = "Quality, Barrel-aged whiskey you 'found' from somewhere.";
	//	model = "\a3\structures_f\items\food\can_v2_f.p3d";
		picture = QPATHTOF(pics\bottle_whiskey);

		acex_field_rations_replacementItem = "RAA_bottle_whiskey_25";
	//	acex_field_rations_refillItem = "ACE_WaterBottle";
		class ItemInfo: CBA_MiscItem_ItemInfo {
			mass = 11.14;
		};
	};
	
	class RAA_bottle_whiskey_25: RAA_bottle_whiskey {	// Bottle of whiskey
		displayName = "Whiskey Bottle (1/4)";
		descriptionShort = "Quality, Barrel-aged whiskey you 'found' from somewhere.";
	//	model = "\a3\structures_f\items\food\can_v2_f.p3d";
		picture = QPATHTOF(pics\bottle_whiskey);

		acex_field_rations_replacementItem = "RAA_bottle_whiskey_empty";
		class ItemInfo: CBA_MiscItem_ItemInfo {
			mass = 9.21;
		};
	};
	
	
	class RAA_bottle_whiskey_empty: RAA_bottle_whiskey {	// Bottle of whiskey
		displayName = "Whiskey Bottle (Empty)";
		descriptionShort = "Quality, Barrel-aged whiskey you 'found' from somewhere. Too bad it was already empty. Right?";
	//	model = "\a3\structures_f\items\food\can_v2_f.p3d";
		picture = QPATHTOF(pics\bottle_whiskey);

		acex_field_rations_thirstQuenched = 0;
		acex_field_rations_replacementItem = "";	// Cannot be drunk
		acex_field_rations_refillItem = "";			// Cannot be refilled
		acex_field_rations_refillAmount = 1;
		acex_field_rations_refillTime = 8;
		class ItemInfo: CBA_MiscItem_ItemInfo {
			mass = 7.28;	// 330 g of bottle
		};
	};
	
	
	
	// Brown alcohol bottle
	class RAA_bottle_genericAlcohol: ACE_WaterBottle {
		author = "riksuFIN";
		displayName = "Alcohol Bottle";
		descriptionShort = "Unlabeled, brown glass bottle.<br/>You wonder what's inside";
		model = QPATHTOF(data\BrownBottle.p3d);
		picture = QPATHTOF(pics\brown_bottle_ca);
		acex_field_rations_thirstQuenched = 4;
		acex_field_rations_replacementItem = "RAA_bottle_genericAlcohol_23";
		acex_field_rations_refillItem = "";		// Cannot be refilled
		acex_field_rations_refillAmount = 0;
		acex_field_rations_refillTime = 8;
		class ItemInfo: CBA_MiscItem_ItemInfo {
			mass = 15.43;
		};
	};
	
	class RAA_bottle_genericAlcohol_23: RAA_bottle_genericAlcohol {
		scope = 1;
		scopeArsenal = 0;
		displayName = "Alcohol Bottle (2/3)";
	//	descriptionShort = "A nice, (not-so) cold can of beer";
		acex_field_rations_replacementItem = "RAA_bottle_genericAlcohol_13";
		class ItemInfo: CBA_MiscItem_ItemInfo {
			mass = 11.76;
		};
	};
	
	class RAA_bottle_genericAlcohol_13: RAA_bottle_genericAlcohol {
		scope = 1;
		scopeArsenal = 0;
		displayName = "Alcohol Bottle (1/3)";
	//	descriptionShort = "A nice, (not-so) cold can of beer";
		acex_field_rations_replacementItem = "RAA_bottle_genericAlcohol_empty";
		class ItemInfo: CBA_MiscItem_ItemInfo {
			mass = 8.08;
		};
	};
	
	class RAA_bottle_genericAlcohol_empty: RAA_bottle_genericAlcohol {
		scope = 1;
		scopeArsenal = 0;
		displayName = "Alcohol Bottle (Empty)";
		descriptionShort = "Unlabeled, brown glass bottle.<br/>You're not quite sure what was inside";
		acex_field_rations_thirstQuenched = 0;
		acex_field_rations_replacementItem = "RAA_bottle_whiskey_75";
		acex_field_rations_refillItem = "RAA_bottle_genericAlcohol_water";		// Cannot be refilled
		acex_field_rations_refillAmount = 0;
		acex_field_rations_refillTime = 8;
		class ItemInfo: CBA_MiscItem_ItemInfo {
			mass = 4.41;
		};
	};
	
	
	class RAA_bottle_genericAlcohol_water: RAA_bottle_genericAlcohol {
		scope = 2;
		scopeArsenal = 0;
		displayName = "Alcohol Bottle";
	//	descriptionShort = "A nice, (not-so) cold can of beer";
		acex_field_rations_thirstQuenched = 8;
		acex_field_rations_replacementItem = "RAA_bottle_genericAlcohol_empty";
		class ItemInfo: CBA_MiscItem_ItemInfo {
			mass = 15.43;
		};
	};
	
	
	
	
	
	// DIRTY WATER BOTTLES --------------------------------------------------------
	class RAA_waterBottle_dirty: ACE_WaterBottle {	// 
		scope = 1;
		scopeArsenal = 0;
		author = "riksuFIN";
		displayName = "Water Bottle (Dirty)";
		descriptionShort = "Bottle filled with water from standing water source, like a lake<br/><br/>Not safe for consumption";
	//	picture = QPATHTOF(pics\soda_bottle_moomin);
		acex_field_rations_replacementItem = "RAA_waterBottle_dirty_half";
		acex_field_rations_consumeTime = 10;
		acex_field_rations_thirstQuenched = 5;
	};
	
	class ACE_WaterBottle_Half;
	class RAA_waterBottle_dirty_half: ACE_WaterBottle_Half {	// 
		scope = 1;
		scopeArsenal = 0;
		author = "riksuFIN";
		displayName = "Water Bottle (Dirty, half)";
		descriptionShort = "Bottle filled with water from standing water source, like a lake<br/><br/>Not safe for consumption";
	//	picture = QPATHTOF(pics\soda_bottle_moomin);
		acex_field_rations_replacementItem = "ACE_WaterBottle_Empty";
		acex_field_rations_consumeTime = 10;
		acex_field_rations_thirstQuenched = 5;
	};
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	// Thermos cans ------------------------------
	class RAA_thermos_empty: RAA_sodaBottle {
		author = "riksuFIN";
		scope = 2;
		displayName = "Thermos Can (Empty)";
		descriptionShort = "Empty thermos can. Fill with any liquid you want to preserve temperature of.";
		model = QPATHTOF(data\thermos_1.p3d);
		picture = QPATHTOF(data\thermos_preview_co);

		acex_field_rations_thirstQuenched = 0;
		acex_field_rations_replacementItem = "";
		acex_field_rations_refillItem = "RAA_thermos_water";
		acex_field_rations_refillAmount = 0.5;
		acex_field_rations_refillTime = 6;
		class ItemInfo: CBA_MiscItem_ItemInfo {
			mass = 6.61;	// 0,3 kg
		};
	};
	
	class RAA_thermos_water: RAA_thermos_empty {
		displayName = "Thermos Can (Water)";
		descriptionShort = "Thermos can filled with Ice Cold Water.";
		
		acex_field_rations_thirstQuenched = 3;
		acex_field_rations_replacementItem = "RAA_thermos_water_half";
		acex_field_rations_refillItem = "";		// Cannot be refilled
		acex_field_rations_refillAmount = 0;
		acex_field_rations_refillTime = 8;
		scopeArsenal = PRIVATE;		// No need to clutter arsenal with this
		class ItemInfo: CBA_MiscItem_ItemInfo {
			mass = 17.64;	// 0,8 kg (300 grams of thermos bottle, 0,5L of drink)
		};
	};
	class RAA_thermos_water_half: RAA_thermos_empty {
		displayName = "Thermos Can (Water, half)";
		descriptionShort = "Thermos can half-filled with Ice Cold Water!";
		acex_field_rations_thirstQuenched = 3;
		acex_field_rations_replacementItem = "RAA_thermos_empty";
		acex_field_rations_refillItem = "";		// Cannot be refilled
		acex_field_rations_refillAmount = 0;
		acex_field_rations_refillTime = 8;
		scopeArsenal = PRIVATE;		// No need to clutter arsenal with this
		class ItemInfo: CBA_MiscItem_ItemInfo {
			mass = 12.13;	// 0,55 kg (300 grams of thermos bottle, 0,25L of drink)
		};
	};
	
	
	class RAA_thermos_tea: RAA_thermos_empty {
		displayName = "Thermos Can (Tea)";
		descriptionShort = "Thermos can full of hot, high-Quality Black Tea!";
		acex_field_rations_thirstQuenched = 3;
		acex_field_rations_replacementItem = "RAA_thermos_tea_half";
		acex_field_rations_refillItem = "";		// Cannot be refilled
		acex_field_rations_refillAmount = 0;
		acex_field_rations_refillTime = 8;
		class ItemInfo: CBA_MiscItem_ItemInfo {
			mass = 17.64;	// 0,8 kg (300 grams of thermos bottle, 0,5L of drink)
		};
	};
	class RAA_thermos_tea_half: RAA_thermos_tea {
		displayName = "Thermos Can (Tea, half)";
		descriptionShort = "Thermos can half empty of High-Quality Black Tea!";
		acex_field_rations_thirstQuenched = 3;
		acex_field_rations_replacementItem = "RAA_thermos_empty";
		acex_field_rations_refillItem = "";		// Cannot be refilled
		acex_field_rations_refillAmount = 0;
		acex_field_rations_refillTime = 8;
		scopeArsenal = PRIVATE;		// No need to clutter arsenal with this
		class ItemInfo: CBA_MiscItem_ItemInfo {
			mass = 12.13;	// 0,55 kg (300 grams of thermos bottle, 0,25L of drink)
		};
	};
	
	
	class RAA_thermos_coffee: RAA_thermos_empty {
		displayName = "Thermos Can (Coffee)";
		descriptionShort = "Thermos can filled with hot coffee!";
		acex_field_rations_thirstQuenched = 3;
		acex_field_rations_replacementItem = "RAA_thermos_coffee_half";
		acex_field_rations_refillItem = "";		// Cannot be refilled
		acex_field_rations_refillAmount = 0;
		acex_field_rations_refillTime = 8;
		class ItemInfo: CBA_MiscItem_ItemInfo {
			mass = 17.64;	// 0,8 kg (300 grams of thermos bottle, 0,5L of drink)
		};
	};
	class RAA_thermos_coffee_half: RAA_thermos_tea {
		displayName = "Thermos Can (Coffee, half)";
		descriptionShort = "Thermos can filled with coffee. It's half empty though";
		acex_field_rations_thirstQuenched = 3;
		acex_field_rations_replacementItem = "RAA_thermos_empty";
		acex_field_rations_refillItem = "";		// Cannot be refilled
		acex_field_rations_refillAmount = 0;
		acex_field_rations_refillTime = 8;
		scopeArsenal = PRIVATE;		// No need to clutter arsenal with this
		class ItemInfo: CBA_MiscItem_ItemInfo {
			mass = 12.13;	// 0,55 kg (300 grams of thermos bottle, 0,25L of drink)
		};
	};
	
	
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	// --------- TIN CANS (FOOD)
	class ACE_MRE_LambCurry;
	class RAA_tinCan_DelMontre: ACE_MRE_LambCurry {
        author = "riksuFIN";
        scope = 2;
        displayName = "Tin Can (Del Montre)";
        descriptionShort = "canned pineapple.";
		model = "\A3\Structures_F_EPA\Items\Food\BakedBeans_F.p3d";
		picture = QPATHTOF(pics\TinCan_DelMontre);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 5.07;
        };
       acex_field_rations_consumeTime = 15;
       acex_field_rations_hungerSatiated = 10;
     //   GVAR(consumeText) = CSTRING(EatingX);
    };


	class RAA_tinCan_peaSoup: RAA_tinCan_DelMontre {
        displayName = "Tin Can (Pea Soup)";
        descriptionShort = "Is it thursday yet?";
		model = "\A3\Structures_F_EPA\Items\Food\BakedBeans_F.p3d";
		picture = QPATHTOF(pics\tinCan_PeaSoup);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 9.59;
        };
       acex_field_rations_consumeTime = 15;
       acex_field_rations_hungerSatiated = 20;
     //   GVAR(consumeText) = CSTRING(EatingX);
    };







#ifdef NOT_WORKSHOP
	// ------------ DRUGS
	
	class ItemCore;	// Make item consumeable so that effects can be triggered
	class InventoryItem_Base_F;
	class UMI_Cocaine_Brick: ItemCore {
		acex_field_rations_consumeTime = 15;
		acex_field_rations_hungerSatiated = 2;
		acex_field_rations_consumeText = "Consuming some of %1...";
		acex_field_rations_replacementItem = "UMI_Coke_Pile_01";
		class ItemInfo: InventoryItem_Base_F {
			mass = 33.07;	// 1,5 kg
		};
	 };

	class UMI_Coke_Pile_01: ItemCore {
		 acex_field_rations_consumeTime = 15;
		 acex_field_rations_hungerSatiated = 2;
		 acex_field_rations_consumeText = "Sniffing %1...";
		acex_field_rations_replacementItem = "UMI_Coke_Pile_01_4";
		class ItemInfo: InventoryItem_Base_F {
			 mass = 22;		// 1 kg
		 };
	 };


	class UMI_Coke_Pile_01_4: UMI_Coke_Pile_01 {
		scopeArsenal = PROTECTED;
		displayName = "Pile of Cocaine (800 g)";
 		acex_field_rations_replacementItem = "UMI_Coke_Pile_01_3";
		class ItemInfo: InventoryItem_Base_F {
			 mass =17.6367;		// 0,8 kg
		 };
 	};
	
	class UMI_Coke_Pile_01_3: UMI_Coke_Pile_01_4 {
		displayName = "Pile of Cocaine (600 g)";
 		acex_field_rations_replacementItem = "UMI_Coke_Pile_01_2";
		class ItemInfo: InventoryItem_Base_F {
			 mass = 13.228;		// 0,6 kg
		 };
 	};
	
	class UMI_Coke_Pile_01_2: UMI_Coke_Pile_01_4 {
		displayName = "Pile of Cocaine (400 g)";
		acex_field_rations_replacementItem = "UMI_Coke_Pile_01_1";
		class ItemInfo: InventoryItem_Base_F {
			 mass = 8.818;		// 0,4 kg
		 };
	};
	
	class UMI_Coke_Pile_01_1: UMI_Coke_Pile_01_4 {
		displayName = "Pile of Cocaine (200 g)";
		acex_field_rations_replacementItem = "";
		class ItemInfo: InventoryItem_Base_F {
			 mass = 4.4;		// 0,2 kg
		 };
	};
	
	
	// Tampered ones. These are identical to regular ones and have no special effects attached. Any effects must be scripted mission-side.
	class UMI_Cocaine_Brick_tampered: UMI_Cocaine_Brick {
		scopeArsenal = PROTECTED;
		acex_field_rations_replacementItem = "UMI_Coke_Pile_tampered_01";
	 };

	class UMI_Coke_Pile_tampered_01: UMI_Coke_Pile_01 {
		scopeArsenal = PROTECTED;
		acex_field_rations_replacementItem = "UMI_Coke_Pile_01_tampered_4";
	 };

	class UMI_Coke_Pile_01_tampered_4: UMI_Coke_Pile_01_4 {
		scopeArsenal = PROTECTED;
		acex_field_rations_replacementItem = "UMI_Coke_Pile_01_tampered_3";
	};
	
	class UMI_Coke_Pile_01_tampered_3: UMI_Coke_Pile_01_3 {
		scopeArsenal = PROTECTED;
		acex_field_rations_replacementItem = "UMI_Coke_Pile_01_tampered_2";
	};
	
	class UMI_Coke_Pile_01_tampered_2: UMI_Coke_Pile_01_2 {
		scopeArsenal = PROTECTED;
		acex_field_rations_replacementItem = "UMI_Coke_Pile_01_tampered_1";
	};
	
	class UMI_Coke_Pile_01_tampered_1: UMI_Coke_Pile_01_1 {
		scopeArsenal = PROTECTED;
		acex_field_rations_replacementItem = "";
	};
	
#endif













};