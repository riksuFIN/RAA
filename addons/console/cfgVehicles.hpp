class CfgVehicles {

	class Land_Laptop_unfolded_F;
	class GVAR(object_laptop) : Land_Laptop_unfolded_F {
		displayName = "[RAA] Laptop (Console)";
		class EventHandlers {
			class ADDON {
				init = QUOTE([ARR_2(_this select 0,true)] call FUNC(initDevice));
			};
		};
	};


};
