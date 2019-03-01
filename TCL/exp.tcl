############################################################
# Project : RISC-V Scalar Cryptography Processor
# Tool    : Cadence Genus
# Flow    : Multi-Effort (Medium / High / Extreme)
# Target  : 1 GHz
############################################################

############################
# Paths
############################
set REPORTS_PATH   reports_1GHz
set OUTPUTS_PATH   outputs_1GHz
set LOG_PATH       logs_1GHz

file mkdir $REPORTS_PATH
file mkdir $OUTPUTS_PATH
file mkdir $LOG_PATH

############################
# Library & RTL paths
############################
set_db / .init_lib_search_path {/home/sgeuser118/Desktop/forward/LIB}
set_db / .init_hdl_search_path {/home/sgeuser118/Desktop/forward/RTL}

############################
# Design Name
############################
set DESIGN riscv_scalar_cryptography_proscessor
############################
# Read Libraries
############################
read_libs { fast.lib slow.lib }

############################
# Read RTL
############################
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

############################
# Elaborate
############################
elaborate $DESIGN
check_timing_intent
check_design

############################
# Constraints
############################
read_sdc ../SDC/top_1GHz.sdc

############################
# Global switches
############################
set_db / .information_level 10
set_db / .auto_ungroup both
set_db / .merge_combinational_hier_instances true
set_db / .map_fancy_names 1

################################################################
# GENERIC SYNTHESIS – MEDIUM / HIGH / EXTREME
################################################################

foreach effort {medium high} {

    puts "===== GENERIC SYNTHESIS : $effort ====="

    set_db syn_generic_effort $effort
    syn_generic

    write_hdl > $OUTPUTS_PATH/${DESIGN}_generic_${effort}.v
    write_snapshot -outdir $REPORTS_PATH -tag generic_${effort}

    report_summary -directory $REPORTS_PATH
    report_gates  > $REPORTS_PATH/generic_${effort}_gates.rpt
    report_area   > $REPORTS_PATH/generic_${effort}_area.rpt
    report_hierarchy > $REPORTS_PATH/hierarchy_generic_${effort}.rpt

    check_design
}

################################################################
# TECHNOLOGY MAPPING – MEDIUM / HIGH / EXTREME
################################################################

foreach effort {medium high extreme} {

    puts "===== MAPPING : $effort ====="

    set_db syn_map_effort $effort
   ## set_db / .map_timing_driven true

    syn_map

    write_hdl > $OUTPUTS_PATH/${DESIGN}_map_${effort}.v
    write_snapshot -outdir $REPORTS_PATH -tag map_${effort}

    report_summary -directory $REPORTS_PATH
    report_hierarchy > $REPORTS_PATH/hierarchy_map_${effort}.rpt

    check_design
}

################################################################
# FINAL OPTIMIZATION – MEDIUM / HIGH / EXTREME
################################################################

foreach effort {medium high extreme} {

    puts "===== OPTIMIZATION : $effort ====="

    set_db syn_opt_effort $effort
    set_db / .opt_retime true
    set_db / .opt_clock_gating true
    set_db / .opt_area_effort high
    set_db / .opt_power_effort high

    syn_opt

    write_hdl > $OUTPUTS_PATH/${DESIGN}_opt_${effort}.v
    write_snapshot -outdir $REPORTS_PATH -tag opt_${effort}

    report_summary -directory $REPORTS_PATH
    report_timing > $REPORTS_PATH/final_timing_${effort}.rpt
    report_power  > $REPORTS_PATH/final_power_${effort}.rpt
    report_hierarchy > $REPORTS_PATH/hierarchy_opt_${effort}.rpt

    check_design
}

############################################################
# Finish
############################################################
puts "========================================="
puts " Multi-Effort Synthesis Completed "
puts " Generic / Map / Opt : Medium ? Extreme "
puts " Target Frequency   : 1 GHz "
puts "========================================="

check_design*/

