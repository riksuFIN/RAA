/// Uniform config ///
class cfgWeapons
{
	
	class CBA_MiscItem_ItemInfo;
	
	class ACE_morphine;
	class RAA_painkiller: ACE_morphine {
		scope = 1;
		
		author = "riksuFIN";
		displayName = "Painkillers (5 pills)";
		picture = "\a3\Missions_F_Oldman\Props\data\Antibiotic_ca.paa";
		model = "\A3\Structures_F_EPA\Items\Medical\PainKillers_F.p3d";	// This is from OldMan expansion
		descriptionShort = "Box of painkillers.<br/>Use when some place hurts. <br/>Don't mix with alcohol.";
		descriptionUse = "A drug used to ease pain";
		
		class ItemInfo: CBA_MiscItem_ItemInfo {
			mass = 2.65;	// 120 grams
		};
	};
	
	
	class RAA_painkiller_4: RAA_painkiller {
		scope = 1;
		displayName = "Painkillers (4 pills)";
		class ItemInfo: CBA_MiscItem_ItemInfo {
			mass = 2.25;	// 102 grams
		};
	};
	
	class RAA_painkiller_3: RAA_painkiller_4 {
		displayName = "Painkillers (3 pills)";
		class ItemInfo: CBA_MiscItem_ItemInfo {
			mass = 1.85;	// 84 grams
		};
	};
	
	class RAA_painkiller_2: RAA_painkiller_4 {
		displayName = "Painkillers (2 pills)";
		class ItemInfo: CBA_MiscItem_ItemInfo {
			mass = 1.46;	//	66 grams
		};
	};
	
	class RAA_painkiller_1: RAA_painkiller_4 {
		displayName = "Painkillers (1 pill)";
		class ItemInfo: CBA_MiscItem_ItemInfo {
			mass = 1.06;	// 48 grams -- Since box also weights a bit
		};
	};
	
	
	
	class RAA_naloxone: ACE_morphine {
		scope = 2;
		
		author = "riksuFIN";
		displayName = "Naloxone Autoinjector";
		picture = QPATHTOF(pics\naloxone_ca.paa);
	//	model = "\A3\Structures_F_EPA\Items\Medical\PainKillers_F.p3d";	// This is from OldMan expansion
		descriptionShort = "An reversal agent for narcotic/ opioid such as Morphine.<br/>Used to alleviate over-dose.<br/>More than one injection may be necessary";
		descriptionUse = "An Antidote for opioid such as Morphine.";
		
		/*
		class ItemInfo: CBA_MiscItem_ItemInfo {
			mass = 2.65;	// 120 grams
		};
		*/
	};
	
	class RAA_propofol: ACE_morphine {
		scope = 2;
		author = "riksuFIN";
		displayName = "Propofol Syringe";
		picture = QPATHTOF(pics\syringe_yellow.paa);
	//	model = "\A3\Structures_F_EPA\Items\Medical\PainKillers_F.p3d";	// This is from OldMan expansion
		descriptionShort = "A Short-acting medication used to decrease level of consciouness.<br/><br/>Typically used to provide general anesthesia.<br/><br/>Warning: For Trained Medical Professionals Only! Can make person go unsconscious in 30-60 seconds for 5-10 minutes from injection if accidentally injected..";
		descriptionUse = "A medicine for inducting anesthesia.";
		
		/*
		class ItemInfo: CBA_MiscItem_ItemInfo {
			mass = 2.65;	// 120 grams
		};
		*/
	};
	
	
	
	
	//model = "\A3\Structures_F_EPA\Items\Medical\Defibrillator_F.p3d";
	class CBA_MiscItem;
	class RAA_defibrillator: CBA_MiscItem {
		scope = 2;
		
		author = "riksuFIN";
		displayName = "Defibrillator";
		picture = QPATHTOF(pics\icon_defib.paa);
		model = "\A3\Structures_F_EPA\Items\Medical\Defibrillator_F.p3d";
		descriptionShort = "Mobile Defibrillator Device with Internal Power Source.<br/>For use by trained medical professional only!";
		descriptionUse = "Defibrillator";
		ACE_isMedicalItem = 1;	// This tells ACE to sort this to medical items in arsenal
		
		class ItemInfo: CBA_MiscItem_ItemInfo {
			mass = 55.12;	// 2,5 kg
		};
	};
	
	class RAA_AED: RAA_defibrillator {
		scope = 2;
		
		author = "riksuFIN";
		displayName = "Automated External Defibrillator";
		picture = QPATHTOF(pics\icon_aed.paa);
		model = "\A3\Structures_F_EPA\Items\Medical\Defibrillator_F.p3d";
		descriptionShort = "Automated Defibrillator with internal battery and voice instructions for ease of usage to ensure anyone can use device safely and effectively without training<br/><br/>Must be dropped to ground via ACE Interaction in order to use";
		descriptionUse = "Defibrillator";
		
		class ItemInfo: CBA_MiscItem_ItemInfo {
			mass = 24;	//  kg
		};
	};
	
	
	
};