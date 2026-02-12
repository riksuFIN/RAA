class CfgMovesBasic {
	class default;
};
	
class CfgMovesMaleSdr: CfgMovesBasic {
	skeletonName = "OFP2_ManSkeleton";
	gestures = "CfgGesturesMale";
	class StandBase;
	class States {
		class RAA_anim_painkiller_stand: StandBase {
			file=QPATHTOF(data\painkiller_stand2.rtm);
			looped=0;
			speed=0.17;
			mask = "bodyFullReal";
			rightHandIKCurve[] = {0};
			leftHandIKCurve[] = {0};
		};
	};
};