class CfgMovesBasic {
    class ManActions {
        GVAR(drinkMove) = QGVAR(drinkMove);
    };

    class Actions {
        class NoActions: ManActions {
            GVAR(drinkMove)[] = {QGVAR(drinkMove), "Gesture"};
        };
    };
};


class CfgGesturesMale {
	class States {
		class ace_gestures_Base;
		class GVAR(drinkMove): ace_gestures_Base {
			file = QPATHTOF(data\drink_stand.rtm);	// This is .rtm from ACE Fieldrations
		//	actions = "CivilStandActions";
			actions = "NoActions";
			speed = 0.1;
			mask = "upperTorso";
		//	mask = "handsWeapon_context";
			disableWeapons = 1;
			canReload = 0;
			canPullTrigger = 0;
			showWeaponAim = 0;
			showItemInHand = 0;
			showItemInRightHand = 0;
			
			
		//	looped = 0;
		//	head = "headNo";
		//	aiming = "aimingNo";
		//	legs = "legsNo";
		//	connectTo[] = {"AmovPercMstpSnonWnonDnon", 0.1};
		//	interpolateFrom[] = {"AmovPercMstpSnonWnonDnon", 0.1};
		//	interpolateTo[] = {"Unconscious", 0.1};
		};
		
	};
};




/*
class CfgMovesMaleSdr: CfgMovesBasic {
    class States {
        class CutSceneAnimationBase;
        class GVAR(drinkMove_anim): CutSceneAnimationBase {
            file = QPATHTOF(data\drinkWhileWalking.rtm);
            actions = "CivilStandActions";
            speed = 0.1;
            disableWeapons = 1;
            disableWeaponsLong = 1;
            canReload = 0;
            canPullTrigger = 0;
            showWeaponAim = 0;
            looped = 0;
            head = "headNo";
            aiming = "aimingNo";
            legs = "legsNo";
            connectTo[] = {"AmovPercMstpSnonWnonDnon", 0.1};
            interpolateFrom[] = {"AmovPercMstpSnonWnonDnon", 0.1};
            interpolateTo[] = {"Unconscious", 0.1};
        };
    };
};
*/