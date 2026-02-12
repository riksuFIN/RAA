#include "script_component.hpp"

class CfgPatches {
    class ADDON {
			author = "riksuFIN";
        name = COMPONENT_NAME;
		  VERSION_CONFIG;
		  requiredVersion = REQUIRED_VERSION;
		  
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {
			  "RAA_common",
			  "cba_xeh",
			  "zen_context_menu",
			  "nagas_Convoy"
		  };
        
    };
};

#include "CfgEventHandlers.hpp"
