#include "defines.hpp"

class RscText;
class RscStructuredText;
class RscFrame;
class RscListbox;

class ace_arsenal_display {
	
//	class controls {
	class controlsBackground {
		
		// ================= Items Overview ====================
		class RAA_overview_header: RscText {
			idc = IDC_RAA_OVERVIEW_HEADER;
			text = "Items Overview";
			colorText[] = {0.7,0.7,0.7,1};
			
			x = QUOTE((0.5 - WIDTH_TOTAL / 2) + WIDTH_GAP);
			y = QUOTE(safeZoneY + 70 * GRID_H);
			w = QUOTE(60 * GRID_W);
			h = QUOTE(5 * GRID_H);
			
			
			colorBackground[] = {0,0,0,0.5};
			style = "0x02";
			sizeEx = "4 * (pixelH * pixelGridNoUIScale * 0.25)";
		};
		class RAA_overview_listbox: RscListbox {
			idc = IDC_RAA_OVERVIEW_LISTBOX;
			x = QUOTE((0.5 - WIDTH_TOTAL / 2) + WIDTH_GAP);
			y = QUOTE(safeZoneY + 75 * GRID_H);
			w = QUOTE(60 * GRID_W);
			h = QUOTE(0.65 * safezoneH);
			
		//	colorBackground[] = {0,0,0,0};
			colorBackground[] = {0,0,0,0.5};
		//	colorSelectBackground[] = {1,1,1,0.5};
			colorSelectBackground[] = {0,0,0,0.5};
		//	colorSelectBackground2[] = {1,1,1,0.5};
			colorSelectBackground2[] = {0,0,0,0.5};
			colorPictureSelected[] = {1,1,1,1};
			colorSelect[] = {1,1,1,1};
			colorSelect2[] = {1,1,1,1};
			colorPictureRightSelected[] = {1,1,1,1};
		//	sizeEx = QUOTE((4 * (pixelH * pixelGridNoUIScale * 0.25)) * GVAR(arsenal_overview_textScale));
			sizeEx = "4 * (pixelH * pixelGridNoUIScale * 0.25)";
			
			deletable = 0;
			//fade = 1;
			
			autoScrollSpeed = 1;
			autoScrollDelay = 7;
			autoScrollRewind = 1;	// true
		};
		
		// ================= Item Description ====================
		class RAA_description_text: RscStructuredText {
			idc = IDC_RAA_DESCRIPTION_TEXT;
			text = "DESCRIPTION";
			x = QUOTE(safeZoneX + safeZoneW - 175 * GRID_W);
			y = QUOTE(safeZoneY + 1.8 * GRID_H);
			w = QUOTE(80 * GRID_W);
		//	h = QUOTE(30 * GRID_H);
			h = QUOTE(ARSENALDESC_DEF_H);
			colorBackground[] = {0,0,0,0.5};
		//	style = "0x02";
			sizeEx = "4 * (pixelH * pixelGridNoUIScale * 0.25)";
			
			lines = 5;
			linespacing = 1;
			style = QUOTE(ST_MULTI + ST_CENTER);
			autoScrollSpeed = 1;
			autoScrollDelay = 5;
			autoScrollRewind = 1;	// True
		};
	};
};
