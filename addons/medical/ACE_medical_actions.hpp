class ace_medical_treatment_actions {
    class CheckPulse ;
    class RAA_checkHunger: CheckPulse  {
        displayName = "Check thirst/ hunger";
        displayNameProgress = "Checking Meal Timetable";
        category = "examine";
        allowedSelections[] = {"Head"};
		items[] = {};
		treatmentTime = 6;
        allowSelfTreatment = 1;
        medicRequired = 0;
        callbackSuccess = "[_medic, _patient] call RAA_fnc_ACEA_checkHunger";	//"[_medic, _patient, _bodyPart] call etr_operation_kat_fnc_checkSkin";
        callbackFailure = "";
        callbackProgress = "";
        condition = "ACEX_field_rations_enabled";
	};
	
	
	// Torn fabric (DIY bandage)
	class BasicBandage {
		items[] += {"RAA_torn_fabric"};
	};
	
	class RAA_torn_fabric: BasicBandage {
		displayName = "Torn piece of Fabric";
		items[] = {"RAA_torn_fabric"};
	};
	
	class ApplyTourniquet;
	class RAA_ApplyTourniquet_fabric: ApplyTourniquet {
		displayName = "Use Piece of Fabric as Tourniquet";
		items[] = {"RAA_torn_fabric"};
	};
	
	
	
    class RAA_forceDrink: BasicBandage  {
        displayName = "Force Drinking";
        displayNameProgress = "Pouring some water to patient's mouth";
        category = "advanced";
        allowedSelections[] = {"Head"};
		items[] = {};
		treatmentTime = 10;
		allowSelfTreatment = 1;
		medicRequired = 0;
		callbackSuccess = "[_medic, _patient] call RAA_fnc_ACEA_forceFeed";
		callbackFailure = "";
		callbackProgress = "";
		//condition = "ACEX_field_rations_enabled";
		condition = QUOTE(ARR_1(_player) call FUNC(forceFeed_canUse));
    };
	
	
	
	class Morphine;
	class RAA_painkiller: Morphine {
		displayName = "Take painkillers";
		displayNameProgress = "Taking some painkillers..";
		icon = "\a3\Missions_F_Oldman\Props\data\Antibiotic_ca.paa";
		allowedSelections[] = {"Head"};
		category = "medication";
		items[] = {"RAA_painkiller", "RAA_painkiller_4", "RAA_painkiller_3", "RAA_painkiller_2", "RAA_painkiller_1"};
		condition = "";
		treatmentTime = QGVAR(painkiller_useTime);
		callbackSuccess = "RAA_fnc_ACEA_onMedicalAction";
		animationMedic = "AinvPknlMstpSnonWnonDnon_medic1";
		sounds[] = {{QPATHTO_R(sounds\taking_pills.ogg),1,1,50}};
		litter[] = {{"RAA_medicalLitter_painkiller"}};
	};
	
	 class RAA_naloxone: Morphine {
			displayName = "Inject Naloxone";
			displayNameProgress = "Injecting Naloxone...";
		//	icon = "\z\ace\addons\medical_gui\ui\auto_injector.paa";
			allowedSelections[] = {"LeftArm","RightArm","LeftLeg","RightLeg"};
			category = "medication";
			items[] = {"RAA_naloxone"};
			condition = "";
		//	treatmentTime = 8;
			callbackSuccess = "RAA_fnc_ACEA_naloxone";
		//	animationMedic = "AinvPknlMstpSnonWnonDnon_medic1";
		//	sounds[] = {{QPATHTOF(sounds\taking_pills.ogg),1,1,50}};
		//	litter[] = {{"RAA_medicalLitter_painkiller"}};
	  };
	
	class RAA_propofol: Morphine {
		displayName = "Inject Propofol";
		displayNameProgress = "Injecting Propofol...";
		//	icon = "\z\ace\addons\medical_gui\ui\auto_injector.paa";
		allowedSelections[] = {"LeftArm","RightArm","LeftLeg","RightLeg"};
		category = "medication";
		items[] = {"RAA_propofol"};
		condition = "";
		//	treatmentTime = 8;
		callbackSuccess = QFUNC(propofol);
		//	animationMedic = "AinvPknlMstpSnonWnonDnon_medic1";
		//	sounds[] = {{QPATHTOF(sounds\taking_pills.ogg),1,1,50}};
		//	litter[] = {{"RAA_medicalLitter_painkiller"}};
	};
	
	
	
	
	class CPR;
	class RAA_AED: CPR {
		displayName = "Use AED";
		displayNameProgress = "Connecting AED!";
		icon = "";
		category = "advanced";
	//	treatmentLocations = TREATMENT_LOCATIONS_ALL;
		allowedSelections[] = {"Body"};
		allowSelfTreatment = 0;
		medicRequired = 0;
		treatmentTime = 2;
		items[] = {};
		condition = "RAA_fnc_ACEA_AED_canUse";
		callbackSuccess = "RAA_fnc_ACEA_AED_start";
		callbackFailure = "";
		callbackProgress = "";
		callbackStart = "";
		animationMedic = "AinvPknlMstpSnonWnonDnon_medic3";
		animationMedicProne = "";
		animationMedicSelf = "";
		animationMedicSelfProne = "";
		consumeItem = 0;
		litter[] = {};
	};
	
	class RAA_AED_deploy: CPR {
		displayName = "Deploy AED";
		displayNameProgress = "Deploying AED!";
		icon = "";
		category = "advanced";
	//	treatmentLocations = TREATMENT_LOCATIONS_ALL;
		allowedSelections[] = {"Body"};
		allowSelfTreatment = 0;
		medicRequired = 0;
		treatmentTime = 1;
		items[] = {"RAA_AED"};
		condition = "true";
		callbackSuccess = "RAA_fnc_ACEA_AED_deployitem";
		callbackFailure = "";
		callbackProgress = "";
		callbackStart = "";
		animationMedic = "";
		animationMedicProne = "";
		animationMedicSelf = "";
		animationMedicSelfProne = "";
		consumeItem = 0;
		litter[] = {};
	};
	
	 class RAA_defibrillator: RAA_AED {
		displayName = "Use Defibrillator";
		displayNameProgress = "Defibrillating!";
		icon = "";
		category = "advanced";
	 //	treatmentLocations = TREATMENT_LOCATIONS_ALL;
		allowedSelections[] = {"Body"};
		allowSelfTreatment = 0;
		medicRequired = 1;
		treatmentTime = 8;
	//	items[] = {"RAA_defibrillator"};
		condition = QUOTE(ARR_1(_player) call FUNC(defib_canUse));
		callbackSuccess = "RAA_fnc_ACEA_defib_success";
		callbackFailure = "";
		callbackProgress = "";
		callbackStart = "";
	//	animationMedic = "AinvPknlMstpSnonWnonDnon_medic5";
		animationMedic = "AinvPknlMstpSnonWnonDnon_medic1";
		animationMedicProne = "";
		animationMedicSelf = "";
		animationMedicSelfProne = "";
		consumeItem = 0;
	//	sounds[] = {{QPATHTOF(sounds\effect_defib_charging.ogg),1,1,50}};
		sounds[] = {{QPATHTO_R(sounds\effect_defib_charging.ogg),1,1,50}};
		litter[] = {};
	};
	
	
	
	
	
};