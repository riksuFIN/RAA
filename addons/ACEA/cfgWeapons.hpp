/// Uniform config ///
class cfgWeapons
{
	class CBA_MiscItem_ItemInfo;
	
	// DIY cabletie
	class ACE_ItemCore;
	class RAA_torn_fabric: ACE_ItemCore {
		scope = 2;
		author = "riksuFIN";
		displayName = "Torn piece of fabric";
		descriptionShort = "Can be usefull for tying someone up or using as a makeshift bandage";
		picture = QPATHTOF(pics\ripped_fabric.paa);
		ACE_captives_restraint = 1;			// Enable cabletie function
		ACE_isMedicalItem = 1;
		class ItemInfo: CBA_MiscItem_ItemInfo {
			mass = 0.6;
		};
	};
};