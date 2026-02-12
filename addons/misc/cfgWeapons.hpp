class CfgWeapons {
	
	class ItemCore;
	class CBA_MiscItem_ItemInfo;
	class RAA_unfinished_ied: ItemCore {
		author = "riksuFIN";
		scope = 2;
		scopeArsenal = 2;
		displayName = "Suspicious parts";
		descriptionShort = "Very suspicious-looking parts that could potentially be assempled into an roadside bomb";
		model = QPATHTOF(data\unfinished_ied.p3d);
		picture = QPATHTOF(data\unfin_ied_render.paa);
		class ItemInfo: CBA_MiscItem_ItemInfo {
			mass = 33;
		};
	};
	
	class CBA_MiscItem;
	class RAA_facepaint: CBA_MiscItem {
		author = "riksuFIN";
		scope = 2;
		scopeArsenal = 2;
		displayName = "Camouflage Face Paint";
		descriptionShort = "Used to camouflage your face. Try not to swallow too much.";
		model = QPATHTOF(data\camoFacePaintStick.p3d);
		picture = QPATHTOF(pics\facepaint_inventory.paa);
		class ItemInfo: CBA_MiscItem_ItemInfo {
			mass = 2.2;
		};
	};
	
	/*
	class RAA_mottinaatti: ItemCore {
		author = "riksuFIN";
		scope = 2;
		scopeArsenal = 2;
		displayName = "Motti Grenade";
//		descriptionShort = "A Highly effective piece of gear favored by Battlegroup Motti.<\br>Caution! May cause bodily harm to your enemies if thrown at!";
		model = QPATHTOF(data\mottinaatti.p3d);
		picture = QPATHTOF(data\unfin_ied_render.paa);
		class ItemInfo: CBA_MiscItem_ItemInfo {
			mass = 33;
		};
	};
	*/
	
	class RAA_axe: CBA_MiscItem {
		author = "riksuFIN";
		scope = 2;
		scopeArsenal = 2;
		displayName = "Axe";
		descriptionShort = "Used to chop down trees. Can also be used as hammer.";
	//	model = QPATHTOF(data\camoFacePaintStick.p3d);
		model = "\A3\Structures_F\Items\Tools\Axe_F.p3d";
		picture = QPATHTOF(pics\axe_inventory.paa);
		class ItemInfo: CBA_MiscItem_ItemInfo {
			mass = 30;
		};
	};
	
	class RAA_chainsaw: RAA_axe {
		
		displayName = "Chainsaw";
		descriptionShort = "For cutting down trees and occasionally murdering someone.";
		picture = QPATHTOF(pics\chainsaw_inventory.paa);
		model = "\A3\Structures_F\Items\Tools\Saw_F.p3d";
		class ItemInfo: CBA_MiscItem_ItemInfo {
			mass = 114.64;
		};
	};
	
	
	
	// ==================================================================
	// 	DAMAGEABLE INVENTORY ITEMS
	class ACE_WaterBottle_Empty;
	class RAA_waterBottle_broken: ACE_WaterBottle_Empty {
		 author = "riksuFIN";
		 scope = 2;
		 scopeArsenal = 0;
		 displayName = "Water Bottle (Broken)";
		 descriptionShort = "Water Bottle with hole on its side, letting all water out";
		 acex_field_rations_thirstQuenched = 0;
		 acex_field_rations_replacementItem = "";
		 acex_field_rations_refillItem = "";
		 acex_field_rations_refillAmount = 0;
		 acex_field_rations_refillTime = 8;
	};
	
	class ACE_Canteen_Empty;
	class RAA_canteen_broken: ACE_Canteen_Empty {
		 author = "riksuFIN";
		 scope = 2;
		 scopeArsenal = 0;
		 displayName = "Water Canteen (Broken)";
		 descriptionShort = "Water Canteen with hole on its side, letting all water out";
		 acex_field_rations_thirstQuenched = 0;
		 acex_field_rations_replacementItem = "";
		 acex_field_rations_refillItem = "";
		 acex_field_rations_refillAmount = 0;
		 acex_field_rations_refillTime = 8;
	};
	
	class ACE_Can_Spirit;
	class RAA_can_broken: ACE_Can_Spirit {
		 author = "riksuFIN";
		 scope = 2;
		 scopeArsenal = 0;
		 displayName = "Can (Broken)";
		 descriptionShort = "Soda can with hole on it, letting all content out";
		 acex_field_rations_thirstQuenched = 0;
		 acex_field_rations_replacementItem = "";
		 acex_field_rations_refillItem = "";
		 acex_field_rations_refillAmount = 0;
		 acex_field_rations_refillTime = 8;
	};
	
	
	// Only load ACRE-dependent stuff if ACRE is actually loaded
//	#if __has_include("\idi\acre\addons\main\script_version.hpp")
	class ACRE_PRC152;
	class RAA_PRC152_broken: ACRE_PRC152 {
		displayName = "AN/PRC-152 (Broken)";
		scopeCurator = 0;
		scopeArsenal = 0;
		scope = 2;
		descriptionShort = "L3Harris Falcon III<br/>MultiBand Handheld Radio<br/><br/>This one seems to not turn on";
		acre_isRadio = 0;
		acre_hasUnique = 0;
	};
	
	class ACRE_PRC77;
	class RAA_PPRC77_broken: ACRE_PRC77 {
		displayName = "AN/PRC-77 (Broken)";
		scopeCurator = 0;
		scopeArsenal = 0;
		scope = 2;
		descriptionShort = "AN/PRC-77 Manpack Radio<br/><br/>This one seems to not turn on";
		acre_isRadio = 0;
		acre_hasUnique = 0;
	};
	
	class ACRE_PRC117F;
	class RAA_PRC117F_broken: ACRE_PRC117F {
		displayName = "AN/PRC-117F (Broken)";
		scopeCurator = 0;
		scopeArsenal = 0;
		scope = 2;
		descriptionShort = "AN/PRC-117F Manpack Radio<br/><br/>This one seems to not turn on";
		acre_isRadio = 0;
		acre_hasUnique = 0;
	};
	
	class ACRE_PRC148;
	class RAA_PRC148_broken: ACRE_PRC148 {
		displayName = "AN/PRC-148 (Broken)";
		scopeCurator = 0;
		scopeArsenal = 0;
		scope = 2;
		descriptionShort = "Multiband Inter/Intra Team Radio<br/><br/>This one seems to not turn on";
		acre_isRadio = 0;
		acre_hasUnique = 0;
	};
	
	class ACRE_PRC343;
	class RAA_PRC343_broken: ACRE_PRC343 {
		displayName = "AN/PRC-343 (Broken)";
		scopeCurator = 0;
		scopeArsenal = 0;
		scope = 2;
		descriptionShort = "Personal Role Radio<br/><br/>This one seems to not turn on";
		acre_isRadio = 0;
		acre_hasUnique = 0;
	};
	
	class ACRE_SEM52SL;
	class RAA_SEM52SL_broken: ACRE_SEM52SL {
		displayName = "SEM 52 SL (Broken)";
		scopeCurator = 0;
		scopeArsenal = 0;
		scope = 2;
		descriptionShort = "Sender/EmpfÃ¤nger, mobil SEM 52 SL<br/><br/>This one seems to not turn on";
		acre_isRadio = 0;
		acre_hasUnique = 0;
	};
	
	class ACRE_SEM70;
	class RAA_SEM70_broken: ACRE_SEM70 {
		displayName = "SEM 70 (Broken)";
		scopeCurator = 0;
		scopeArsenal = 0;
		scope = 2;
		descriptionShort = "Sender/EmpfÃ¤nger, mobil SEM 70<br/><br/>This one seems to not turn on";
		acre_isRadio = 0;
		acre_hasUnique = 0;
	};
	
	class ACRE_BF888S;
	class RAA_BF888S_broken: ACRE_BF888S {
		displayName = "BaoFeng BF-888S (Broken)";
		scopeCurator = 0;
		scopeArsenal = 0;
		scope = 2;
		descriptionShort = "Cheap UHF radio<br/>Max range is about 5 km in ideal conditions.<br/><br/>This one seems to not turn on";
		acre_isRadio = 0;
		acre_hasUnique = 0;
	};
	
//	#endif
	
	
	
	
	
	
	
	
	
	
};