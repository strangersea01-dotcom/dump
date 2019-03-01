############################################################
# Project : RISC-V Scalar Cryptography Processor
# Tool    : Cadence Genus
# Flow    : FULL Multi-Effort (Generic + Map + Opt)
# Target  : 1 GHz
############################################################

############################
# Paths
############################
set REPORTS reports_1GHz
set OUTPUTS outputs_1GHz
set SNAP snapshots_1GHz

file mkdir $REPORTS
file mkdir $OUTPUTS
file mkdir $SNAP

############################
# Library & RTL paths
############################
set_db / .init_lib_search_path {/home/sgeuser118/Desktop/forward/LIB}
set_db / .init_hdl_search_path {/home/sgeuser118/Desktop/forward/RTL}

############################
# Design name
############################
set DESIGN riscv_scalar_cryptography_proscessor 

############################
# RTL files
############################
set RTL_FILES {
    riscv_scalar_cryptography_processor.v
    pc.v pc_top.v pc_adder.v
    im_mem0.v im_mem1.v im_mem2.v im_mem3.v im_mem_top.v
    Fetch_cycle.v riscv_control_unit.v sign_extend.v
    register_file.v decoder_cycle.v mux_21.v
    bit_rol.v bit_zip.v bit_unzip.v bit_ror.v bit_rori.v
    bit_orn.v bit_xnor.v bit_pack.v bit_packh.v
    bit_brev.v bit_rev8.v bit_andn.v bitmanipulation.v
    carry_less_multiplication.v carry_less_engine.v
    sbox_values.v mix_op.v aes32esi.v
    sha256_round.v sha_engine.v crypto_engine.v
    mux_31.v execute_cycle.v
    data_memory.v data_memory_top.v
    write_back_cycle.v hazard_unit.v mux31.v
}

############################################################
# INITIAL READ & ELABORATE (ONCE)
############################################################
read_libs { fast.lib slow.lib }
read_hdl  $RTL_FILES
elaborate $DESIGN
check_design
read_sdc ../SDC/top_1GHz.sdc

############################################################
# GENERIC SYNTHESIS — MULTI EFFORT
############################################################
foreach geff {medium high extreme} {

    puts "===== GENERIC : $geff ====="

    set_db syn_generic_effort $geff
    syn_generic

    write_snapshot -outdir $SNAP -tag generic_${geff}
    write_hdl > $OUTPUTS/${DESIGN}_generic_${geff}.v

    report_area  > $REPORTS/generic_${geff}_area.rpt
    report_gates > $REPORTS/generic_${geff}_gates.rpt

    # Restore RTL for next effort
    read_snapshot $SNAP/generic_${geff}.snap -replace
}

############################################################
# MAP SYNTHESIS — MULTI EFFORT
############################################################
foreach geff {medium high extreme} {

    read_snapshot $SNAP/generic_${geff}.snap -replace

    foreach meff {medium high extreme} {

        puts "===== MAP : generic=$geff map=$meff ====="

        set_db syn_map_effort $meff
        syn_map

        write_snapshot -outdir $SNAP -tag map_${geff}_${meff}
        write_hdl > $OUTPUTS/${DESIGN}_map_${geff}_${meff}.v

        report_area > $REPORTS/map_${geff}_${meff}_area.rpt
    }
}

############################################################
# OPT SYNTHESIS — MULTI EFFORT
############################################################
foreach geff {medium high extreme} {
    foreach meff {medium high extreme} {

        read_snapshot $SNAP/map_${geff}_${meff}.snap -replace

        foreach oeff {medium high extreme} {

            puts "===== OPT : g=$geff m=$meff o=$oeff ====="

            set_db syn_opt_effort $oeff
            set_db / .opt_retime true
            set_db / .opt_clock_gating true

            syn_opt

            write_hdl > $OUTPUTS/${DESIGN}_opt_${geff}_${meff}_${oeff}.v
            report_timing > $REPORTS/timing_${geff}_${meff}_${oeff}.rpt
            report_power  > $REPORTS/power_${geff}_${meff}_${oeff}.rpt
        }
    }
}

############################################################
# FINISH
############################################################
puts "==============================================="
puts " FULL MULTI-EFFORT SYNTHESIS COMPLETED          "
puts " Generic + Map + Opt : medium/high/extreme     "
puts "==============================================="

