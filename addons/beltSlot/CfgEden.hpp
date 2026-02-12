#define GET_NUMBER(config,default) (if (isNumber (config)) then {getNumber (config)} else {default})

//#define DEFAULT_ISENGINEER ([ARR_2(0,1)] select (_this getUnitTrait 'engineer'))
//#define DEFAULT_ISREPAIRVEHICLE GET_NUMBER(configOf _this >> QQGVAR(canRepair),0)

class ctrlToolbox;

class Cfg3DEN {
    class Attributes {
        class Default;
        class Title: Default {
            class Controls {
                class Title;
            };
        };
		  
        class GVAR(addBottleControl): Title {
            attributeLoad = "(_this controlsGroupCtrl 101) lbSetCurSel (((_value + 1) min 4) max 0);";
            attributeSave = "(lbCurSel (_this controlsGroupCtrl 101)) - 1";
            class Controls: Controls {
                class Title: Title {};
                class Value: ctrlToolbox {
                    idc = 101;
                    style = "0x02";
                    x = "48 * (pixelW * pixelGrid * 0.50)";
                    w = "82 * (pixelW * pixelGrid * 0.50)";
                    h = "5 * (pixelH * pixelGrid * 0.50)";
                    rows = 1;
                    columns = 3;
                    strings[] = {"None", "Canteen", "Water Bottle"};
                };
            };
        };
		  class GVAR(addBottleControl2): GVAR(addBottleControl) {
				attributeLoad = "(_this controlsGroupCtrl 102) lbSetCurSel (((_value + 1) min 3) max 0);";
				attributeSave = "(lbCurSel (_this controlsGroupCtrl 102)) - 1";
				class Controls: Controls {
					 class Title: Title {};
					 class Value: ctrlToolbox {
						  idc = 102;
						  style = "0x02";
						  x = "48 * (pixelW * pixelGrid * 0.50)";
						  w = "82 * (pixelW * pixelGrid * 0.50)";
						  h = "5 * (pixelH * pixelGrid * 0.50)";
						  rows = 1;
						  columns = 3;
						  strings[] = {"None", "Canteen", "Water Bottle"};
					 };
				};
		  };
    };

    class Object {
        class AttributeCategories {
            //class ace_attributes {
            class Inventory {
                class Attributes {
                    class RAA_beltSlot_addBottle_1 {
                        property = QUOTE(RAA_beltSlot_addBottle_1);
                        displayName = "Add Water Bottles to Belt Slot 1";
                        tooltip = "Allows for easily adding water bottles directly to belt slot";
                        //expression = QUOTE(if !(_value == DEFAULT_ISENGINEER || {_value == -1}) then {_this setVariable [ARR_3('%s',_value,true)]});
							//	expression = QUOTE(if (!is3DEN && _value > -1) then {['', _this, ['ACE_canteen', 'ACE_WaterBottle'] select _value, true, 0] call FUNC(beltSlot_doMoveToBelt)});
								expression = QUOTE(if (!is3DEN && _value > -1) then {['', _this, ['ACE_canteen', 'ACE_WaterBottle'] select _value, true, 1] remoteExec FUNC(beltSlot_doMoveToBelt)});
                        typeName = "NUMBER";
                        condition = "objectBrain";
                        defaultValue = -1;
                        control = QGVAR(addBottleControl);
                    };
                    class RAA_beltSlot_addBottle_2 {
                        property = QUOTE(RAA_beltSlot_addBottle_2);
                        displayName = "Add Water Bottles to Belt Slot 2";
                        tooltip = "Allows for easily adding water bottles directly to belt slot";
                        //expression = QUOTE(if !(_value == DEFAULT_ISENGINEER || {_value == -1}) then {_this setVariable [ARR_3('%s',_value,true)]});
								expression = QUOTE(if (!is3DEN && _value > -1) then {['', _this, ['ACE_canteen', 'ACE_WaterBottle'] select _value, true, 1] remoteExec FUNC(beltSlot_doMoveToBelt)});
                        typeName = "NUMBER";
                        condition = "objectBrain";
                        defaultValue = -1;
                        control = QGVAR(addBottleControl2);
                    };
                };
            };
        };
    };
};

