class ace_medical_treatment {
	
	class Medication
	{
		class RAA_painkiller
		{
			painReduce = 0.3;
			timeInSystem = 600;
			timeTillMaxEffect = 60;
			maxDose = 10;
			incompatibleMedication[] = {};
			viscosityChange = 5;
		};
	};
	
	class Bandaging {
		class QuikClot;
		class RAA_torn_fabric: QuikClot {
			
		};
	};
	
	
	
	
	
};