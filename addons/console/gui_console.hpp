#include "defines.hpp"

class RscText;
class RscStructuredText;
class RscEdit;
class RscControlsGroup;

class GVAR(console) {
    idd = 556644;
    movingEnable = 0;
    onLoad = QUOTE(uiNamespace setVariable [ARR_2(QQGVAR(consoleDisplay),(_this select 0))]; [ARR_2({call FUNC(onConsoleOpen)},_this)] call CBA_fnc_execNextFrame);
    onUnload = QUOTE(call FUNC(onUnload));
    class controlsBackground {
        class pathbox: RscText {
            idc = IDC_PATHBOX;
            x = QUOTE(0.324687 * safezoneW + safezoneX);
            y = QUOTE(0.687 * safezoneH + safezoneY);
            w = QUOTE(0.33 * safezoneW);
            h = QUOTE(0.033 * safezoneH);
            colorBackground[] = COLOR_BACKGROUND;
            linespacing = 0.6;
            font = FONT;
			size = 0.6;
            text = "testPath. This should never be visible!";
        };


/*        class background {
            type = CT_STATIC;
            idc = -1;
            style = ST_PICTURE;
            font = FONT;
            sizeEx = 0.032;
            x = "safeZoneX";
            w = "safeZoneW";
            y = "2.1 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25) + (safeZoneY + (safeZoneH - (((safeZoneW / safeZoneH) min 1.2) / 1.2))/2)";
            h = "2.9 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)";
            text = "#(argb,8,8,3)color(0,0,0,0.8)";
            colorText[] = {0, 0, 0, "(profilenamespace getVariable ['GUI_BCG_RGB_A',0.9])"};
            colorBackground[] = {0, 0, 0, "(profilenamespace getVariable ['GUI_BCG_RGB_A',0.9])"};
        };*/
    };


    class controls {
		class input: RscEdit {
			idc = IDC_INPUT;
			x = QUOTE(0.324687 * safezoneW + safezoneX);
			y = QUOTE(0.687 * safezoneH + safezoneY);
			w = QUOTE(0.33 * safezoneW);
			h = QUOTE(0.033 * safezoneH);
			colorText[] = {1,1,1,1};
			colorBackground[] = COLOR_BACKGROUND;
			autocomplete = "general";
			onKeyUp = QUOTE(_this call FUNC(onKeyUp));
		//    onKeyUp = "systemChat str _this";
			font = FONT;
			size = 0.6;
			linespacing = 0.6;
			forceDrawCaret = 1;
		};

		class group_feedbox: RscControlsGroup {
			idc = IDC_FEEDBOX_GROUP;
			x = QUOTE(0.324687 * safezoneW + safezoneX);
			y = QUOTE(0.28 * safezoneH + safezoneY);
			w = QUOTE(0.33 * safezoneW);
			h = QUOTE(FEEDBOX_HEIGHT);
			height = 1;
			width = 1;
			color[] = {1,1,1,1};
			colorActive[] = {1,1,1,1};
			colorDisabled[] = {1,1,1,0.3};
			thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
			arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
			arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
			border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
			shadow = 0;
			autoScrollEnabled = 1;
			scrollSpeed = 0.06;
			// params ["_control", "_animType", "_animTime"];
		//	onCommitted = QUOTE([ARR_2({_this ctrlSetScrollValues [ARR_2(1,1)]; systemChat str _this},_this)] call CBA_fnc_execNextFrame);
		//	onCommitted = QUOTE(_this select 0 ctrlSetScrollValues [ARR_2(1,1)]; systemChat str _this);
			
			class controls {
				class feedbox: RscStructuredText {
					idc = IDC_FEEDBOX;
					x = 0;
					y = 0;
					w = QUOTE(0.33 * safezoneW);
				//	h = QUOTE(0.407 * safezoneH);
					h = QUOTE(FEEDBOX_HEIGHT);
					colorBackground[] = COLOR_BACKGROUND;
					linespacing = 0.6;
					font = FONT;
					text = ">TestLine. This should never be visible!";
				//	onLoad = QFUNC(onConsoleOpen);
					onCommitted = QUOTE(displayCtrl IDC_FEEDBOX_GROUP ctrlSetScrollValues [ARR_2(1,1)]; systemChat str _this);
				//	onCommitted = QUOTE(_this select 0 ctrlSetScrollValues [ARR_2(1,1)]; systemChat str _this);
				};
			};
		};
    };
};

