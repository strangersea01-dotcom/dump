##set DATE [clock format  [clock seconds] -format "%b%b-%T"]
set _REPORTS_PATH report_900MHz
set _OUTPUTS_PATH outputs_900MHz
set _LOG_PATH logs_900_MHz
set_db / .init_lib_search_path {../lib}

set_db / .init_hdl_search_path {../RTL }
 
set DESIGN atomic_32_top

read_libs { fast.lib slow.lib }

read_hdl { atomic_32_top.v alu_add.v alu_and.v alu_or.v alu_xor.v min_max_signed.v min_max_unsigned.v alu_top.v data_memory_top.v data_memory_B0.v data_memory_B1.v data_memory_B2.v data_memory_B3.v instruction_decoder.v register_file.v reservation_address_register.v reservation_valid_register.v combinational_logic.v IF_ID_pipeline.v ID_MR_pipeline.v MR_EXE_pipeline.v EXE_WR_pipeline.v mux_21_32.v program_counter.v pc_adder.v instruction_memory_top.v instruction_mem_B0.v instruction_mem_B1.v instruction_mem_B2.v instruction_mem_B3.v data_forwarding_block.v }


set_db information_level 10
set_db auto_ungroup none
set_db merge_combinational_hier_instances false
set_db map_fancy_names 1
elaborate $DESIGN

read_sdc top_900MHz.sdc

set_db syn_generic_effort {high}
syn_generic
write_hdl > $_OUTPUTS_PATH/generic.v
write_snapshot -outdir $_REPORTS_PATH -tag generic
report_summary -directory $_REPORTS_PATH
report_gates > $_REPORTS_PATH/generic_gates.rpt
report_area > $_REPORTS_PATH/generic_area.rpt
report_hierarchy > $_REPORTS_PATH/hierarchy_gen.rpt
set_db design_power_effort high


set_db syn_map_effort {high}
syn_map
write_hdl > $_OUTPUTS_PATH/syn_map.v
write_snapshot -outdir $_REPORTS_PATH -tag map
report_summary -directory $_REPORTS_PATH
report_hierarchy > $_REPORTS_PATH/hierarchy_map.rpt


set_db syn_opt_effort {extreme}
syn_opt
write_hdl > $_OUTPUTS_PATH/optimized.v
write_snapshot -outdir $_REPORTS_PATH -tag optimized
report_summary -directory $_REPORTS_PATH
report_messages > $_REPORTS_PATH/final_message.rpt
report_power > $_REPORTS_PATH/final_power.rpt
report_hierarchy > $_REPORTS_PATH/hierarchy_opt.rpt


write_do_lec -golden_design fv_map -revised_design ${_OUTPUTS_PATH}/${DESIGN}_m_1.v -logfile  ${_LOG_PATH}/intermediate2final.lec.log > ${_OUTPUTS_PATH}/intermediate2final.lec.do
##Uncomment if the RTL is to be compared with the final netlist..
write_do_lec -revised_design ${_OUTPUTS_PATH}/${DESIGN}_m_2.v -logfile ${_LOG_PATH}/rtl2final.lec.log > ${_OUTPUTS_PATH}/rtl2final.lec.do


puts "==============================="
puts "Synthesis Finished ............"
puts "==============================="


