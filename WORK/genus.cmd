# Cadence Genus(TM) Synthesis Solution, Version 17.22-s017_1, built Apr  1 2018

# Date: Fri Mar 01 00:13:44 2019
# Host: compute-srv2.eda.atme.in (x86_64 w/Linux 3.10.0-1160.49.1.el7.x86_64) (8cores*64cpus*4physical cpus*Intel(R) Xeon(R) CPU E5-4650 0 @ 2.70GHz 20480KB)
# OS:   CentOS Linux release 7.9.2009 (Core)

set _REPORTS_PATH report_1GHz
set _OUTPUTS_PATH outputs_1GHz
set _LOG_PATH logs_1GHz
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
set_db auto_ungroup none
set_db merge_combinational_hier_instances false
set_db map_fancy_names 1
elaborate $DESIGN
check_timing_intent
check_design
read_sdc {../SDC/top_1GHz.sdc}
set_db syn_generic_effort {high}
syn_generic
write_hdl > $_OUTPUTS_PATH/generic.v
write_snapshot -outdir $_REPORTS_PATH -tag generic
report_summary -directory $_REPORTS_PATH
report_gates > $_REPORTS_PATH/generic_gates.rpt
report_area > $_REPORTS_PATH/generic_area.rpt
report_hierarchy > $_REPORTS_PATH/hierarchy_gen.rpt
set_db design_power_effort high
check_design
report_hierarchy
exit
