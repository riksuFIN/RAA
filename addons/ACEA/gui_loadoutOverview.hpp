#include "\z\ace\addons\common\define.hpp"
#include "\a3\ui_f\hpp\definecommoncolors.inc"
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by riksuFIN, v1.063, #Cokefa)
////////////////////////////////////////////////////////


class RscPicture;
//class RscListbox;	This one is in define ^
class RscText;
class RscButtonMenuOK;




class GVAR(arsenal_loadoutOverview) {
	idd = 314618;
	movingEnable = 1;
	onLoad = QUOTE([_this select 0] call FUNC(onMenuOpen_loadoutOverview));
//	onUnload = QUOTE(uiNamespace setVariable [ARR_2(QUOTE(QGVAR(menuDisplay)),nil)];);
	onUnload = "";






	class controls {
		
		class list_weapons: RscListbox
		{
			idc = IDC_GUI_LOADOUTOVERVIEW_LIST_WEAPONS;
			x = 0.355625 * safezoneW + safezoneX;
			y = 0.159 * safezoneH + safezoneY;
			w = 0.139219 * safezoneW;
			h = 0.671 * safezoneH;
		};
		class list_items: RscListbox
		{
			idc = IDC_GUI_LOADOUTOVERVIEW_LIST_ITEMS;
			x = 0.5 * safezoneW + safezoneX;
			y = 0.159 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.671 * safezoneH;
		};
		class text_weapons: RscText
		{
			idc = IDC_GUI_LOADOUTOVERVIEW_TEXT_WEAPONS;
			text = "Weapons & Magazines"; //--- ToDo: Localize;
			style = ST_CENTER;
			x = 0.360781 * safezoneW + safezoneX;
			y = 0.115 * safezoneH + safezoneY;
			w = 0.134062 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class text_items: RscText
		{
			idc = IDC_GUI_LOADOUTOVERVIEW_TEXT_ITEMS;
			text = "Items"; //--- ToDo: Localize;
			style = ST_CENTER;
			x = 0.505156 * safezoneW + safezoneX;
			y = 0.115 * safezoneH + safezoneY;
			w = 0.134062 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class RscButtonMenuOK_2600: RscButtonMenuOK
		{
			text = "CLOSE"; //--- ToDo: Localize;
			x = 17 * GUI_GRID_W + GUI_GRID_X;
			y = 28 * GUI_GRID_H + GUI_GRID_Y;
			w = 6 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
		
	};
	
	
	class ControlsBackground {
		class backGround: RscPicture
		{
			idc = IDC_GUI_LOADOUTOVERVIEW_BACKGROUND;
			text = "#(argb,8,8,3)color(1,1,1,1)";
			x = 0.35 * safezoneW + safezoneX;
			y = 0.1 * safezoneH + safezoneY;
			w = 0.3 * safezoneW;
			h = 0.8 * safezoneH;
			colorText[] = {0.5,0.5,0.5,0.5};
		};
		
		
		
	};
};