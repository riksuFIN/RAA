#include "defines.hpp"
class RscText;
class RscPicture;
class RscFrame;
class RscButton;
class RscListbox;
class RscActiveText;

class RscDisplayInventory {
	
	class controls {
		
		class RAA_beltSlot_slot1: RscListbox {
			idc = IDC_RAA_BELTSLOT_SLOT1;
		//	text = "";
			x = QUOTE(0.2525 * safezoneW + safezoneX);
			y = QUOTE(0.896 * safezoneH + safezoneY);
			w = QUOTE(0.154687 * safezoneW);
			h = QUOTE(0.044 * safezoneH);
			colorBackground[] = {1,1,1,0.1};
			colorSelectBackground[] = {1,1,1,0.1};
			rowHeight = "1.75 * (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			tooltip = "Use ACE Action Menu to swap these items"; //--- ToDo: Localize;
		//	onButtonClick = "systemChat str _this";
			onLBDrop = QUOTE(ARR_6(nil, ACE_player, _this select 4 select 0 select 2, false, 0, _this select 3) call FUNC(beltSlot_doMoveToBelt));
		//	onLBDrag = "systemChat str _this";
			canDrag = 1;
		};
		
	//	class SlotPrimary;
	//	class RAA_beltSlot_testButton2: SlotPrimary {
		class RAA_beltSlot_slot2: RscListbox {
			idc = IDC_RAA_BELTSLOT_SLOT2;
		//	text = "";
			x = QUOTE(0.4175 * safezoneW + safezoneX);
			y = QUOTE(0.896 * safezoneH + safezoneY);
			w = QUOTE(0.154687 * safezoneW);
			h = QUOTE(0.044 * safezoneH);
			colorBackground[] = {1,1,1,0.1};
			rowHeight = "1.75 * (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			tooltip = "Use ACE Action Menu to swap these items"; //--- ToDo: Localize;
		//	onButtonClick = "systemChat str _this";
			onLBDrop = QUOTE(ARR_6(nil, ACE_player, _this select 4 select 0 select 2, false, 1, _this select 3) call FUNC(beltSlot_doMoveToBelt));
		//	onLBDrag = "systemChat str _this";
			canDrag = 1;
		//	style = "0x30 + 0x800";
		};
		
		
		
		
		
		
		class GroundContainer: RscListbox {
		//	onLBDrop = QUOTE([-1, player, 9, _this select 3] call FUNC(beltSlot_doMoveFrombelt));
			onLBDrop = QUOTE(if (_this select 3 in ARR_2(1288,1289)) then {ARR_4(-1, ACE_player, 9, _this select 3) call FUNC(beltSlot_doMoveFrombelt)});
		};
		
		class UniformContainer: GroundContainer {		// idc = 633;		Select 3
			onLBDrop = QUOTE(if (_this select 3 in ARR_2(1288,1289)) then {ARR_4(-1, ACE_player, 0, _this select 3) call FUNC(beltSlot_doMoveFrombelt)});
		};
		
		class VestContainer: UniformContainer {		// idc = 638;
			onLBDrop = QUOTE(if (_this select 3 in ARR_2(1288,1289)) then {ARR_4(-1, ACE_player, 1, _this select 3) call FUNC(beltSlot_doMoveFrombelt)});
		};
		
		class BackpackContainer: UniformContainer {		// idc = 619;
			onLBDrop = QUOTE(if (_this select 3 in ARR_2(1288,1289)) then {ARR_4(-1, ACE_player, 2, _this select 3) call FUNC(beltSlot_doMoveFrombelt)});
		};
		
	};
	
	
	class controlsBackground {
		/*
		class BI_Background_Base;
		class BI_Frame_Base;
		class RAA_Background_belt1: BI_Background_Base {
			idc = 88881;
			x = "safeZoneX + safeZoneW * 0.3";
			y = "safeZoneY + safeZoneH * 0.86";
			w = "safeZoneW * 0.035";
			h = "safeZoneH * 0.04888889";
		};
		class RAA_Background_belt2: BI_Frame_Base {
		idc = 88882;
		x = "safeZoneX + safeZoneW * 0.35";
		y = "safeZoneY + safeZoneH * 0.86";
		w = "safeZoneW * 0.035";
		h = "safeZoneH * 0.04888889";
		};
		*/
		
		
		class RAA_beltSlot_backGround: RscText
		{
			idc = IDC_RAA_BELTSLOT_BACKGROUND1;
			x = QUOTE(0.247344 * safezoneW + safezoneX);
			y = QUOTE(0.874 * safezoneH + safezoneY);
			w = QUOTE(0.33 * safezoneW);
			h = QUOTE(0.077 * safezoneH);
			colorBackground[] = {0,0,0,0.8};
		};
		
		class RAA_beltSlot_frame: RscFrame
		{
			idc = IDC_RAA_BELTSLOT_BACKGROUND2;
			text = "Items on belt"; //--- ToDo: Localize;
			x = QUOTE(0.247344 * safezoneW + safezoneX);
			y = QUOTE(0.874 * safezoneH + safezoneY);
			w = QUOTE(0.33 * safezoneW);
			h = QUOTE(0.077 * safezoneH);
			colorBackground[] = {0.05,0.05,0.05,0.7};
			colorFrame[] = {1,1,1,1};
			SizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			
		//	colorBackground[] = {1,0,1,1};
		//	sizeEx = 1 * GUI_GRID_H;
		};
		
		
		
		
		
	};
};





