#define PRIVATE 0
#define PROTECTED 1
#define PUBLIC 2

class cfgWeapons
{
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






};