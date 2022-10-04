set_global_assignment -entity "dvi_pll" -library "lib_dvi_pll" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "dvi_pll" -library "lib_dvi_pll" -name IP_TOOL_VERSION "18.1"
set_global_assignment -entity "dvi_pll" -library "lib_dvi_pll" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_dvi_pll" -name SPD_FILE [file join $::quartus(sip_path) "dvi_pll.spd"]

set_global_assignment -library "lib_dvi_pll" -name MISC_FILE [file join $::quartus(sip_path) "dvi_pll_sim/dvi_pll.vo"]
