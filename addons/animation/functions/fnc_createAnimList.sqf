#include "script_component.hpp"
/* File: fnc_createAnimList.sqf
 * Authors: riksuFIN
 * Description: Create GUI allowing selection of animation
 *
 * Called from: ACE self-action menu.sqf
 * Parameter(s):
 0: Unit playing animation		<OBJECT, default player>	
 1:
 2:
 3:
 4:
 *
 Returns:
 *	None

 Example:
	[player] call RAA_animation_fnc_createAnimList;
 */




/*	Used to get anim length
player addEventHandler ["AnimDone", { 
timeEnd = time;
timeAnimLength = timeEnd - timeStart;
systemChat str timeAnimLength;
copyToClipboard str timeAnimLength;
}];
*/

params [["_unit", player]];

["Select animation to play",[
	["LIST",
		["Animation", "Prefixes:\n[L] : Animation naturally loops (Do not select loop type)"],[
			[	// ARRAY of returned values
				// Explanation: <Classname>	animation className
				// COMMAND_TYPE:	<NUMBER>	 0 for playMove, 1 for playMoveNow (default), 2 for switchMove (Use 1 by default, if it doesnt work use 2)
				// ForceEnd		BOOL		Set to true if animation leads to unwanted anim and has to be reset before loopTime is over
				// ANIM_LENGTH	<NUMBER>	Length of non-looping animation. Animation will be re-installed (or cut, depending on other settings) after this time.
				// END ANIMATION			<CLASSNAME>	Once loop ends do this animation, unless anim was forced to end prematurely. Likely to be never actually used (wip)
				/* LOOP_TYPE	<NUMBER>	Config-defined type of looping. Types:
				 	-1 for no looping allowed, with feedback message telling this animation will not loop.
					0 for no effect whatsoever (= No looping)
					1: Loops with Queue type
					2: Loops with waitUntill detects animation change
					3: Loops with waitUntill ANIM_LENGTH, after which execute animaation again
					5: Reserved for internal use
					6: If user selects NO LOOP, end animation after ANIM_LENGTH, otherwise do nothing (Select this if animation loops naturally so that it can be ended automaticly) 
					*/
				// SPECIAL	<NUMBER>	Special thing to do BEFORE animation is played. 1: Put weapon on back
				// ["ANIMATION", CMD_Type, ForceEnd, ANIM_LENGTH, "END_ANIM", LOOP_TYPE, SPECIAL]
				
				["",2, false, 0, "", 0, 0],				// CATEGORY: GENERAL
				["Acts_PercMstpSlowWrflDnon_handup2",	1, false, 4.45, "", 1, 0],
				["Acts_PercMstpSlowWrflDnon_handup1b",	1, false, 2.695, "", -1, 0],
				["Acts_PercMstpSlowWrflDnon_handup1",	1, false, 2.981, "", 0, 0],
		//		["Acts_JetsMarshallingClear_in",2, false, 1.485, "", 0, 0],
				["Acts_CivilInjuredGeneral_1",			2, true, 20, "", 1, 0],		// Injured
				["ApanPercMstpSnonWnonDnon_G01",		2, false, 0, "", -2, 0],	// Panic
				["Acts_Accessing_Computer_loop",		1, false, 0, "", 6, 0],		
			//	["acts_millerDisarming_deskLoop",		1, false, 0, "", 6, 0],		
				["Acts_ShowingTheRightWay_in",			1, false, 0, "", -2, 0],		
				["Acts_JetsMarshallingEmergencyStop_in",2, false, 0.858002, "Acts_JetsMarshallingEmergencyStop_loop", -2, 1],
				["Acts_JetsMarshallingLeft_in",			2, false, 1.03, "Acts_JetsMarshallingLeft_loop", -2, 1],
				["Acts_JetsMarshallingRight_in",		2, false, 0.82399, "Acts_JetsMarshallingRight_loop", -2, 1],
				["Acts_Rifle_Operations_Checking_Chamber",	1, false, 5.44501, "", -1, 0],
				["Acts_Rifle_Operations_Zeroing",		1, false, 6.02701, "", -1, 0],
				["Acts_Rifle_Operations_Barrel",		1, false, 5.15799, "", -1, 0],
				["",2, false, 0, "", 0, 0],				// CATEGORY: IDLE
				["random1",								1, false, 0, "", 1, 0],
				["Acts_AidlPercMstpSlowWrflDnon_warmup03",1, false, 0, "", 6, 0],
				["HubStandingUC_idle1",					2, false, 0, "", 6, 0],
			//	["HubStanding_idle1",					2, true, 25, "", 0, 0],		// These cannot be looped with
			//	["HubStanding_idle2",					2, true, 32.6, "", 0, 0],	//  ..Current system
			//	["HubStanding_idle3",					2, true, 41, "", 0, 0],
				["Acts_Briefing_Intro3_Physicist_1",	2, true, 120, "", -1, 0],
				["HubStandingUA_move2",					2, true, 16.5, "", -1, 0],
				["Acts_Ambient_Relax_2",				1, false, 12.341, "", -1, 0],
				["Acts_Ambient_Relax_4",				1, false, 9.77203, "", 0, 0],
				["Acts_Ambient_Relax_1",				1, false, 8.25, "", 0, 0],
				["Acts_Gallery_Visitor_01",				2, false, 0, "", 6, 0],		// Loops
				["",2, false, 0, "", 0, 0],				// CATEGORY: BRIEFING
				["HubStandingUB_idle1",					2, false, 18.9291, "", 6, 0],	// Loops but gets stuck
				["Acts_A_M01_briefing",					2, false, 95, "", 6, 0],	// Loops but ends in static pose
				["Acts_A_M02_briefing",					2, false, 42, "", 6, 0],	// Loops but ends in static pose
				["Acts_B_out2_briefing",				2, false, 0, "", -1, 0],
				["Acts_Briefing_Intro3_Major_1",		2, false, 0, "", 0, 0],
				["Acts_CivilTalking_1",					2, true, 19, "", 0, 0],		// TODO: Measure accurately length
		//		["Acts_AidlPercMstpSnonWnonDnon_warmup_1",1, false, 0, "", 0, 0],	// Something's wrong with this one?
				["HubBriefing_ext_Contact",				2, false, 34, "", 0, 0],
				["HubBriefing_think",					2, false, 9, "", 0, 0],
				["HubBriefing_stretch",					2, false, 9, "", 0, 0],
				["HubBriefing_scratch",					2, false, 6, "", 0, 0],
				["HubBriefing_pointAtTable",			2, false, 3, "", 0, 0],
				["HubBriefing_pointLeft",				2, false, 5, "", 0, 0],
				["HubBriefing_pointRight",				2, false, 4, "", 0, 0],
				["",2, false, 0, "", 0, 0],				// CATEGORY: MISC
				["Acts_Ambient_Facepalm_1",				1, false, 6.604, "", -1, 0],
			//	["Acts_AidlPercMstpSnonWnonDnon_warmup_7",1, false, 0, "", 0, 0],
				["Acts_Dance_01",						2, false, 25, "", 6, 0],	// Loops
				["Acts_Dance_02",						2, false, 20.8419, "", 6, 0],	// Loops
				["AmovPercMstpSnonWnonDnon_exerciseKata",1, false, 35.955, "", 1, 0],	// Puts weapon to back first (+2,6 secs)
				["Acts_Ambient_Gestures_Tired",			1, false, 10.3031, "", 0, 0],
				["Acts_Examining_Device_Player",		1, false, 5.42798, "", 0, 0],
				["Acts_Ambient_Approximate",			1, false, 1.79199, "", 0, 0],
				["Acts_Ambient_Picking_Up",				1, false, 7.776, "", 0, 0],
				["Acts_Ambient_Aggressive",				1, false, 7.22205, "", 0, 0],
				["Acts_Ambient_Disagreeing",			1, false, 5.3811, "", 0, 0],
			//	["Acts_Ambient_Disagreeing_with_pointing",	1, false, 6.19897, "", 0, 0],
				["Acts_Ambient_Rifle_Drop",				1, false, 4.9519, "", 0, 0],
				["viperSgt_crouchLoop",					2, true, 12, "", 0, 0],
				["acts_miller_knockout",				2, true, 5.13, "", 0, 0],
				["Acts_Ambient_Shoelaces",				1, false, 10.62, "", 0, 0],
				["Acts_Grieving",						2, false, 0, "", 6, 0],
				["Acts_InjuredLyingRifle01",			2, false, 18, "", 6, 0],	// Loops beatifully
				["Acts_AidlPercMstpSlowWrflDnon_pissing",			2, false, 20, "", 6, 0],
			//	["Acts_Waking_Up_Player",				2, false, 7.995, "", 0, 0],		// Not sure if this animation's very good
				["Acts_ExecutionVictim_Loop",			2, false, 10, "", 6, 0]	// Loops fine
				
				
			],[	// ARRAY of pretty names & tooltips	========================================
				["------ CATEGORY: GENERAL ------",""],// ------------

				["[Armed] 'Hey, i'm over here!' (Waving hands)",""],
				["[Armed] [No loop] Raised hand, low","As if greeting"],
				["[Armed] [No loop] Raised hand, high",""],
		//		["Holding hand high up","Looping"],
				["Playing injured","Lying on the ground looking to be in great pain"],
				["[Unarmed] Panic","Loopin\nYou may freely move, animation adjusts itself\nNOTE: If you have rifle it will look strange"],
				["Operating computer on table, standing",""],
			//	["Operating computer on table, standing, suspicious looking","Loopin\nOffset, sprints about 5 meters to left"],
				["Showing vehicle way: Right","Looping\nTurning camera resets animation"],
				["Marshalling: Stop","Will end when touching any movement controls"],
				["Marshalling: Right","Will end when touching any movement controls"],
				["Marshalling: Left","Will end when touching any movement controls"],
				["[Armed] [No loop] Weapon Handling: Checking chamber","Short"],
				["[Armed] [No loop] Weapon Handling: Zeroing irons","Short"],
				["[Armed] [No loop] Weapon Handling: Checking barrel","Short"],
				["------ CATEGORY: IDLE ------",""],// ---------------------------------
				["[Armed] Generic idling","Randomized"],
				["Standing idle, kinda anxious",""],
				["Standing idle, slight lean",""],
			//	["Standing idle 1",""],
			//	["Standing idle 2",""],
			//	["Standing idle 3",""],
				["[No loop] Standing idle, hands crossed","Eventually starts moving\nSTRONGY recommend putting weapon to back!"],
				["[No loop] Standing idle, kicking ground","Limited"],
				["[Armed] [No loop] Looking cool, rifle pointin up, peeking behind","Quite short"],
				["[Armed] [No loop] Relaxed, rifle up on shoulder","Quite short"],
				["[Armed] [No loop] Relaxed, rifle hanging on strap","Quite short"],
				["Thinking","Looping\nThinking, real hard"],
				["----- CATEGORY: BRIEFING ------",""],// ------------------------------
				["Standing still, with hands on belt","Looking very important"],
				["Briefing, moving few steps forward","Ends with static hands on hip"],
				["Briefing, pointing left","Make sure there's map or something to your left"],
				["[No loop] Briefing, quite mobile, pointing forward",""],
				["[Unarmed!] Briefing, very mobile. Should be unarmed","Ends with hands on waist"],
				["[No loop] Talking (Unarmed)",""],
		//		["Standing idle, checking watch time by time. Waiting for something?","Looping"],
				["HUBBriefing: Base: Standing still, with hands on hips","Looking important"],
				["HUBBriefing: Thinking","Returns to HUBBriefing Base once finished"],
				["HUBBriefing: Stretching your back","Returns to HUBBriefing Base once finished"],
				["HUBBriefing: Scratching you neck","Returns to HUBBriefing Base once finished"],
				["HUBBriefing: Pointing down at table","Make sure there's something in front of you. Returns to HUBBriefing Base once finished"],
				["HUBBriefing: Pointing Left","Returns to HUBBriefing Base once finished"],
				["HUBBriefing: Pointing Right","Returns to HUBBriefing Base once finished"],
				["------ CATEGORY: MISC ------",""],//-------------------------------------------
				["[No loop] Facepalm",""],
		//		["Warming up for exercise","Looping"],
				["Dancing 1","Good song?"],
				["Dancing 2","Smooth Moves"],
				["[Unarmed!] Martial Arts Exercise","Rifle will be floating mid-air"],
				["[Armed] [No loop] Exhausted, catching breath",""],
				["[Pistol] [No loop] Examining Pistol",""],
				["[Armed] [No loop] Spreading hands (I Don't Know -gesture)",""],
				["[Armed] Picking up something small","Reach down to ground and pick up something small"],
				["[Armed] [No loop] Agressive",""],
				["[Armed] [No loop] Strong Disagreeing",""],
		//		["[Armed] [No loop] Disagreeing, pointing around"," "],
				["[Armed] [No loop] Almost dropping rifle",""],
				["[Armed] [No loop] Crouch, weapon pointing forward",""],
				["[Armed] [No loop] Hitting ground with weapon buttstock",""],
				["[Armed] [No loop]Tying shoelaces",""],
				["Grieving",""],
				["Playing injured on the ground",""],
				["Taking a leak",""],
			//	["Sitting on ground against something, looking stunned",""],
				["On knees on the ground, hands tied behind back",""]
			],	// ARRAY of pretty names for above list
			1,	// Default index
			25	// Height of list box
		]
	],
	
	
	["TOOLBOX:YESNO",
	["Loop Animation","Select if animation be looped or not"],[
		true	// Default setting
		],
		false	// Force default setting
	],
	
	
/*
	["TOOLBOX",
	["Loop Animation Override","WIP!\nWheter animation looping should be allowed. \nSelect No Change to keep animation's default behavior\nWIP Settings:\nQueue: Add next animation to queue. Works with very few anims\nDetect: Detects when animation ends and re-starts. May look akward, and will not work with all anims.\nTimed: Force-restarts animation after certain time (non-configurable)\nALL loops can be interrupted at any time by selecting 'Clear animation'"],[
		0,	// Default setting
		1,	// Number of rows
		4,	// Number of columns
		["No change", "Loop (Queue)", "Loop (Detect)","Loop (Timed)"]	// Option names <ARRAY>
		]
	],
*/
	
	
	["TOOLBOX:YESNO",
	["Clear Animation","Use this to stop animation or in case it gets stuck. Will also stop any loops"],[
		false	// Default setting
		],
		true	// Force default setting
	]

], {	// Code to execute upon pressing OK
	
			// When enabling loop setting again REMEMBER to switch this 'select 2' to 3
	if (_this select 0 select 2) then {	// Force exit animation
		[_this select 1 select 0, "", 2] call ace_common_fnc_doAnimation;
		(_this select 1 select 0) setVariable ["RAA_animation_loopAnim", -1];
		if (RAA_misc_debug) then {systemChat "Animation force exit";};
		
	} else {
		
		private _delay = 0;
		switch (_this select 0 select 0 select 6) do {
			case (1): {
				private _unit = _this select 1 select 0;
				
				if (currentWeapon _unit != "") then {
					[_unit] call ace_weaponselect_fnc_putWeaponAway;	// Holster unit's weapon
					_delay = 3;				// ..And wait for that to happen before doing animation
				};
				
			};
		};
		
		
		
		if (_delay > 0) then {
			
			[	{
				//	[_this select 0] call RAA_animation_fnc_playAnim;
					[_this select 0] call FUNC(playAnim);
				}, [
					_this
				],
				_delay
			] call CBA_fnc_waitAndExecute;
			
		} else {
			// No time to wait
	//	[_this] call RAA_animation_fnc_playAnim;
		[_this] call FUNC(playAnim);
		};
	
	
	
	
	};
},
{},	// On Cancel
[	// Arguments
	_unit
]
] call zen_dialog_fnc_create;