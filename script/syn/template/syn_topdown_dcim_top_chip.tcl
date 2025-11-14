define_design_lib work -path ./work

  
set cache_write ""

set_host_options -max_cores 8

set verilogout_no_tri true

# todo
set TOP <your top module name>   
set OUTPUTS_DIR ./outputs_${TOP}
set REPORTS_DIR ./reports_${TOP}

#todo
source ./scripts/lib.tcl

# todo
analyze -vcs "-sverilog +define+ASIC -f ./scripts/syn_filelist_${TOP}.f" 
elaborate $TOP

current_design $TOP
link

check_design > ${REPORTS_DIR}/${TOP}_check_design.rpt

# todo
source ./scripts/${TOP}_constraints.tcl

set clk_list [get_object_name [all_clocks]]
foreach from_clk $clk_list {
	foreach to_clk $clk_list {
		group_path -name ${from_clk}_${to_clk} -critical 0.5 -from [get_clocks $from_clk] -to [get_clocks $to_clk]
	}
}
 

set_wire_load_mode top


set_fix_multiple_port_nets -all -buf

# -------------------------
# clock gating setup
# -------------------------
set_app_var compile_clock_gating_through_hierarchy true
set_app_var power_cg_balance_stages true
set_clock_gating_style -sequential_cell latch \
                       -positive_edge_logic integrated \
                       -control_point before \
                       -num_stages 2
                       # -max_fanout 40
                       # -minimum_bitwidth 3
# -------------------------

uniquify



compile_ultra -no_autoungroup -gate_clock

change_name -rule verilog -hier 

check_timing > ${REPORTS_DIR}/${TOP}_check_timing.rpt
check_design > ${REPORTS_DIR}/${TOP}_check_design.rpt
report_area -hier -nosplit > ${REPORTS_DIR}/${TOP}_area.rpt
report_qor > ${REPORTS_DIR}/${TOP}_qor.rpt
report_constraint -all_violators > ${REPORTS_DIR}/${TOP}_violators.rpt
report_reference -hier -nosplit > ${REPORTS_DIR}/${TOP}_reference.rpt

report_timing -delay max -max_paths 50 > ${REPORTS_DIR}/${TOP}_max_timing.rpt
report_timing -delay min -max_paths 50 > ${REPORTS_DIR}/${TOP}_min_timing.rpt

report_power > ${REPORTS_DIR}/${TOP}_power.rpt
report_clock > ${REPORTS_DIR}/${TOP}_clock.rpt


write_file -f ddc -hier -o ${OUTPUTS_DIR}/${TOP}.ddc
write_file -f verilog -hier -o ${OUTPUTS_DIR}/${TOP}.v
write_sdf -version 1.0 ${OUTPUTS_DIR}/${TOP}.sdf
write_sdc ${OUTPUTS_DIR}/${TOP}.sdc


exit
