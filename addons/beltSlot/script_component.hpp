#define COMPONENT beltSlot
#define COMPONENT_BEAUTIFIED BeltSlot
#include "\r\RAA\addons\common\script_mod.hpp"

 #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_RAA_misc
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_BLANK
    #define DEBUG_SETTINGS DEBUG_SETTINGS_BLANK
#endif

#define COMPNAME "BeltSlot"

#include "\z\ace\addons\main\script_macros.hpp"

// Number of belt slots. 0-based
#define BELTSLOT_NUMBEROFSLOTS 1