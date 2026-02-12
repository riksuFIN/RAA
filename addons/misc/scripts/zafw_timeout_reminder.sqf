/* File: zafw_timeout_reminder.sqf
 * Author(s): riksuFIN
 * Description: Handle timeout reminders for Zeus mission containing ZAFW
 *
 * Called from: XEH_postInit. Only executed if:
										- System is enabled (CBA settings)
										- ZAFW is present
										- Safestart system is enabled (ZAFW config)
										
										Additionally execution will wait untill more than 4 players are connected
 * Local to: Server
 *
 Returns: NOTHING
 *
 */

params [["_wasDelayed", false]];

// If zeus jumped in just before slotting don't reduce his prep time
if (_wasDelayed && (time < RAA_misc_zafw_timeOutReminder_firstWarning_jip)) then {
	_wasDelayed = false;
};


private _firstTimeOut = 0;
private _secondTimeOut = 0;
if (_wasDelayed) then {
	_firstTimeOut = RAA_misc_zafw_timeOutReminder_firstWarning_jip * 60;
	_secondTimeOut = RAA_misc_zafw_timeOutReminder_secondWarning_jip * 60;
} else {
	_firstTimeOut = RAA_misc_zafw_timeOutReminder_firstWarning * 60;
	_secondTimeOut = RAA_misc_zafw_timeOutReminder_secondWarning * 60;
};


// First timeout (Zeus briefing)
[	{
		private _condition = if (isNil "zafw_safestart_on") then {
			true;
		} else {
			zafw_safestart_on;
		};
		if (_condition) then {
			[RAA_misc_zafw_timeOutReminder_firstWarning_text, ""] remoteExec ["RAA_misc_fnc_showMessage", 0]
		};
	},
	[],
	_firstTimeOut
] call CBA_fnc_waitAndExecute;


// 5 minutes
[	{
		private _condition = if (isNil "zafw_safestart_on") then {
			true;
		} else {
			zafw_safestart_on;
		};
		if (_condition) then {
			[RAA_misc_zafw_timeOutReminder_secondWarning_text_5, ""] remoteExec ["RAA_misc_fnc_showMessage", 0];
			
			// 3 minutes
			[	{
					private _condition = if (isNil "zafw_safestart_on") then {
						true;
					} else {
						zafw_safestart_on;
					};
					if (_condition) then {
						[RAA_misc_zafw_timeOutReminder_secondWarning_text_2, ""] remoteExec ["RAA_misc_fnc_showMessage", 0];
						
						// Time's up
						[	{
								private _condition = if (isNil "zafw_safestart_on") then {
									true;
								} else {
									zafw_safestart_on;
								};
								if (_condition) then {
									[RAA_misc_zafw_timeOutReminder_secondWarning_text_now, "", true] remoteExec ["RAA_misc_fnc_showMessage", 0];
								};
							}, [],
							120	// 2 minutes -- Timeout message
						] call CBA_fnc_waitAndExecute;
					};
				}, [],
				180	// 3 minutes -- 2 left minutes warning
			] call CBA_fnc_waitAndExecute;
			
		};
	}, 
	[],
//	(RAA_misc_zafw_timeOutReminder_secondWarning - 5) * 60
	_secondTimeOut - 300
] call CBA_fnc_waitAndExecute;













