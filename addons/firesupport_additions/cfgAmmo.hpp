class CfgAmmo {
	class F_40mm_White;
	class RAA_ammo_arty_illum: F_40mm_White {
		scope = 2;
		intensity = 300000;
	//	brightness = 3000;
		lightColor[] = {100,100,100,100};
		timeToLive = 120;
		coefGravity = 0.25;
		affectedByWind = 1;
	};
	class RAA_ammo_arty_illum_IR: RAA_ammo_arty_illum {
		intensity = 50000;
	//	brightness = 500;
		irLight = 1;
	};
	class RAA_ammo_mortar_illum: RAA_ammo_arty_illum {
		intensity = 200000;
	//	brightness = 200;
		lightColor[] = {100,100,100,100};
		timeToLive = 40;
		coefGravity = 0.5;
	};
	
	
	
	
};

// 850 000, 500 000, 300 000, 1m
// 4-6 m/s
// submunitionAmmo[] = {"rhs_ammo_flare_m485",1};