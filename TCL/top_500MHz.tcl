set _REPORTS_PATH report_500MHz
set _OUTPUTS_PATH outputs_500MHz
set _LOG_PATH logs_500MHz
set_db / .init_lib_search_path {../LIB}

set_db / .init_hdl_search_path {../CORE}
 
set DESIGN riscv_scalar_cryptography_proscessor

read_libs { fast.lib slow.lib }

read_hdl {riscv_scalar_cryptography_processor.v
    pc.v
    pc_top.v
    pc_adder.v
    im_mem0.v
    im_mem1.v
    im_mem2.v
    im_mem3.v
    im_mem_top.v
    Fetch_cycle.v
    riscv_control_unit.v
    sign_extend.v
    register_file.v
    decoder_cycle.v
    mux_21.v
    bit_rol.v
    bit_zip.v
    bit_unzip.v
    bit_ror.v
    bit_rori.v
    bit_orn.v
    bit_xnor.v
    bit_pack.v
    bit_packh.v
    bit_brev.v
    bit_rev8.v
    bit_andn.v
    bitmanipulation.v
    carry_less_multiplication.v
    carry_less_engine.v
    sbox_values.v
    mix_op.v
    aes32esi.v
    aes32esmi.v
    aes_engine.v
    sha256_msg_datapath.v
    sha256_round.v
    sha_engine.v
    crypto_engine.v
    mux_31.v
    execute_cycle.v
    data_memory.v
    data_memory_top.v
    write_back_cycle.v
    hazard_unit.v
    mux31.v
}


set_db information_level 10
set_db auto_ungroup both
set_db merge_combinational_hier_instances true
set_db map_fancy_names 1
elaborate $DESIGN
check_timing_intent
check_design 

read_sdc {../SDC/top_500MHz.sdc}
#set_db / .lp_insert_clock_gating true

set_db syn_generic_effort {medium}
syn_generic
write_hdl > $_OUTPUTS_PATH/generic.v
write_snapshot -outdir $_REPORTS_PATH -tag generic
report_summary -directory $_REPORTS_PATH
report_gates > $_REPORTS_PATH/generic_gates.rpt
report_area > $_REPORTS_PATH/generic_area.rpt
report_hierarchy > $_REPORTS_PATH/hierarchy_gen.rpt
set_db design_power_effort high
check_design

set_db syn_map_effort {medium}
syn_map
write_hdl > $_OUTPUTS_PATH/syn_map.v
write_snapshot -outdir $_REPORTS_PATH -tag map
report_summary -directory $_REPORTS_PATH
report_hierarchy > $_REPORTS_PATH/hierarchy_map.rpt
check_design

set_db syn_opt_effort {medium}
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
check_design
