set search_path "
	$search_path
	/nfs/project/shared_lib/t28_hpcplus/SC/tcbn28hpcplusbwp30p140_190a/TSMCHOME/digital/Front_End/timing_power_noise/CCS/tcbn28hpcplusbwp30p140_180a
        /nfs/project/shared_lib/t28_hpcplus/IO/tphn28hpcpgv18_170d/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tphn28hpcpgv18_170a
"

# WC corner
set target_library "
        tcbn28hpcplusbwp30p140ssg0p81v125c_ccs.db  
"

set link_library "
	    *
	    $target_library
        tphn28hpcpgv18ssg0p81v1p62v125c.db
"


