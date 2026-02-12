class CfgMovesBasic {
	class default;
};
	
class CfgMovesMaleSdr: CfgMovesBasic {
	skeletonName = "OFP2_ManSkeleton";
	gestures = "CfgGesturesMale";
	class StandBase;
	class States {
		class RAA_anim_chainsaw_01: StandBase {
		//	file="\r\misc\addons\RAA_misc\data\chainsaw_02.rtm";
			file=QPATHTOF(data\chainsaw_02.rtm);
			looped=0;
			speed=0.04;
			mask = "bodyFullReal";
			rightHandIKCurve[] = {0};
			leftHandIKCurve[] = {0};
			
			weaponLowered = 1;
			
			
		};
	};
};