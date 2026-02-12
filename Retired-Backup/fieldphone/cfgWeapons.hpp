class cfgWeapons
{
	
	class CBA_MiscItem_ItemInfo;
	class CBA_MiscItem;
	class RAA_fieldphone_item: CBA_MiscItem {
		scope = 2;
		
		author = "riksuFIN";
		displayName = "Field Telephone";
	//	picture = "\A3\EditorPreviews_F_Enoch\Data\CfgVehicles\Land_IPPhone_01_olive_F.jpg";
		picture = QPATHTOEF(fieldphone,pics\fieldphone_preview.paa);
		model = "\a3\Props_F_Enoch\Military\Equipment\IPPhone_01_F.p3d";
		descriptionShort = "Field Telephone. Connect two of these with pair cables for voice communications";
		descriptionUse = "Field Telephone";
		
		class ItemInfo: CBA_MiscItem_ItemInfo {
			mass = 22.05;	// 1 kg
		};
	};
	
	
	
	
};