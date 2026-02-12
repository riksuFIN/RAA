/// Sample character config ///
class cfgVehicles		// Character classes are defined under cfgVehicles.
{
	
	
	
	
	
	class ACE_morphineItem;
	class RAA_painkiller_item: ACE_morphineItem {
		scope = 2;
		scopeCurator = 2;
		vehicleClass = "Items";
		displayName = "Box of painkillers";
		class TransportItems {
			class xx_RAA_painkiller {
				name = "RAA_painkiller";
				count = 1;
			};
		};
	};
	
	
	
	class ACE_MedicalLitterBase;
	class RAA_medicalLitter_painkiller: ACE_MedicalLitterBase {
		 model = QPATHTOF(data\pill_wrapper.p3d);
	};
	
	
	
	
	
	class Land_Defibrillator_F;
	class RAA_Item_AED: Land_Defibrillator_F {
		displayName = "Automated External Defibrillator (AED)";
		
		// Dragging
		ace_dragging_canDrag = 1;  // Can be dragged (0-no, 1-yes)
		ace_dragging_dragPosition[] = {0, 1.5, 0};  // Offset of the model from the body while dragging (same as attachTo) (default: [0, 1.5, 0])
		ace_dragging_dragDirection = 0;  // Model direction while dragging (same as setDir after attachTo) (default: 0)

		// Carrying
		ace_dragging_canCarry = 1;  // Can be carried (0-no, 1-yes)
		ace_dragging_carryPosition[] = {0, 1.5, 0};  // Offset of the model from the body while dragging (same as attachTo) (default: [0, 1, 1])
		ace_dragging_carryDirection = 0;  // Model direction while dragging (same as setDir after attachTo) (default: 0)
		
		/*
		class ACE_Actions {
			class ACE_MainActions {
				class RAA_ACEA_AED_pickup {
					displayName = "Pick up AED";
				//	condition = "!(_target getVariable ['RAA_AED_inUse', false]) && {_player canAdd 'RAA_AED'}";
					condition = "true";
				//	exceptions[] = {};
					statement = "deleteVehicle _target; _player addItem 'RAA_AED'";
				//	icon = "";
				};
			};
		};
		*/
	};
		//!(cursorObject getVariable ["RAA_AED_inUse", false]) && (player canAdd "RAA_AED")
		
		
	
		
	// AED
	class Man;
	class CAManBase: Man {
		class ACE_SelfActions {
			class ACE_Equipment {
				class RAA_AED_deploy {
					displayName = "Deploy AED";
					condition = "'RAA_AED' in items _player";
				//    exceptions[] = {};
					statement = "[_player] call RAA_fnc_ACEA_AED_deployitem;";
					icon = QPATHTOF(pics\icon_aed_action);
				};
				
				
			};
		};
	};
	
};