# ----------------------------------------
# JasperGold Version Info
# tool      : JasperGold 2019.12
# platform  : Linux 3.10.0-1160.119.1.el7.x86_64
# version   : 2019.12p002 64 bits
# build date: 2020.02.27 18:30:54 PST
# ----------------------------------------
# started   : 2023-02-16 07:42:09 IST
# hostname  : compute-srv5.atme.in.eda.atme.in
# pid       : 18749
# arguments : '-label' 'session_0' '-console' '//127.0.0.1:33468' '-style' 'windows' '-data' 'AQAAADx/////AAAAAAAAA3oBAAAAEABMAE0AUgBFAE0ATwBWAEUAAAAAAAAB4A==' '-proj' '/home/sgeuser118/Desktop/pipelining/RTL/jgproject/sessionLogs/session_0' '-init' '-hidden' '/home/sgeuser118/Desktop/pipelining/RTL/jgproject/.tmp/.initCmds.tcl' 'riscv_lint_automation.tcl'
check_superlint -init
clear -all
##################################################################################################################
#setup the rule
 config_rtlds -rule -enable -domain {LINT}
 config_rtlds -rule -disable -domain {AUTO_FORMAL}
 config_rtlds -rule -disable -category {NAMING FILEFORMAT}

##############################RTL_LOAD##############################################
#analyze -verilog -f /home/sgeuser118/Desktop/RISC-V_SCALAR_CYRPTOGRAPHY/Final_folder/RISC-V_SCALAR_CYRPTOGRAPHY/pc_compile.f
##analyze -verilog -f /home/sgeuser118/Desktop/RISC-V_SCALAR_CYRPTOGRAPHY/Final_folder/RISC-V_SCALAR_CYRPTOGRAPHY/lint_compile.f
analyze -verilog -f /home/sgeuser118/Desktop/pipelining/RTL/pc_compile.f

###################################################ELaborate######################################
elaborate
#########################################For the gobal signal##################################################
clock clk
reset rst
###############################################To run LINT ################################################
check_superlint -extract
##############################################INS_NR_INPR#####################################################
check_superlint -waiver -add -category STRUCTURAL -tag INS_NR_INPR -comment {Pure combinational logic by design. Output is intended to change immediately with input changes.No state or storage element is required. No impact on synthesis or functionality.No state or storage element is required. No impact on synthesis or functionality} -force
##############################################INS_NR_INPR#####################################################
check_superlint -waiver -add -category STRUCTURAL -tag MOD_NO_IPRG -comment {its is yop module output its not connect to any ff} -force
##############################################INS_NR_INPR#####################################################
check_superlint -waiver -add -category STRUCTURAL -tag MOD_NS_GLGC -comment {Yes this is a glue logic . why i am using this because of synthesis to find the critical path} -force

############################################MOD_IS_SYAS######################################################
check_superlint -waiver -add -category STRUCTURAL -tag MOD_IS_SYAS -comment {Module intentionally uses synchronous write and asynchronous read memory behavior. Standard memory modeling style with no synthesis or functional impact} -force
#############################################NET_NO_LOAD#####################################################
check_superlint -waiver -add -category STRUCTURAL -tag NET_NO_LOAD -comment {NET_NO_LOAD waived because this signal is driven but intentionally not connected to any consuming logic and has no functional impact.} -force
#############################################OTP_NR_ASYA#####################################################
check_superlint -waiver -add -category CODINGSTYLE -tag OTP_NR_ASYA -comment { OTP_NR_ASYA waived because this output is intentionally driven by pure combinational logic and is not required to be registered; no functional or synthesis impact. } -force
#############################################WIR_NO_READ#####################################################
check_superlint -waiver -add -category CODINGSTYLE -tag WIR_NO_READ -comment { Wire is not used in logical expression. it only used for connect } -force
#############################################INP_NO_USED#####################################################
 check_superlint -waiver -add -category CODINGSTYLE -tag INP_NO_USED -comment { Unused input bits are intentional due to instruction semantics or address slicing; no functional or synthesis impact.} -force
#############################################ARY_MS_DRNG#####################################################
 check_superlint -waiver -add -category CODINGSTYLE -tag ARY_MS_DRNG -comment {ARY_MS_DRNG waived because mixed packed/unpacked range ordering is intentional and legal Verilog; no functional or synthesis impact.} -force
#############################################ASG_MS_RPAD#####################################################
 check_superlint -waiver -add -category CODINGSTYLE -tag ASG_MS_RPAD -comment { Unequal operand width warning waived because operands are intentionally widened for PC increment logic and truncation to XLEN bits is architecturally correct; no functional or synthesis impact. } -force
#############################################CAS_NR_DEFX#####################################################
check_superlint -waiver -add -category CODINGSTYLE -tag CAS_NR_DEFX -comment { CAS_NR_DEFX waived because the default case is intentionally fully specified by prior assignments and outputs are not required to be driven to X; no functional or synthesis impact. } -force
#############################################IDX_NR_DTTY#####################################################
check_superlint -waiver -add -category CODINGSTYLE -tag IDX_NR_DTTY -comment {IDX_NR_DTTY waived because the address used as a memory index is driven from registered control logic and is guaranteed to be a valid 2-state value; no functional or synthesis impact. } -force
#############################################ASG_NR_POVF#####################################################
check_superlint -waiver -add -category CODINGSTYLE -tag ASG_NR_POVF -comment {  ASG_NR_POVF waived because the widened left-shift in rotate logic may trigger conservative overflow detection, but truncation is intentional and functionally correct } -force
#############################################OPR_NR_UEAS#####################################################
check_superlint -waiver -add -category CODINGSTYLE -tag OPR_NR_UEAS -comment {  OPR_NR_UEAS waived because subtraction between XLEN and shamt is intentional for rotate logic and width difference has no functional or synthesis impact.
 } -force
#############################################OTP_UC_INST#####################################################
 check_superlint -waiver -add -category CODINGSTYLE -tag OTP_UC_INST -comment {OTP_UC_INST waived because the unused upper bits of the carry-less multiplication output are intentionally not required for this operation and have no functional or synthesis impact.
 } -force
#############################################RESET#####################################################
check_superlint -waiver -add -category SYNTHESIS -tag MOD_NR_ASLD -comment { resest dont have a constant value } -force
#check_superlint -waiver -add -category STRUCTURAL -tag FLP_NO_ASRT -comment {Memory arrays are intentionally implemented without asynchronous reset; this matches SRAM behavio} -force
###################################################FIRE_FOX########################################################
check_superlint -report -violation -property -order category -file /home/sgeuser118/Desktop/pipelining/RTL/Superlint_report.html -force -html -launch_html_browser -detailed -include_design_build









source riscv_lint_automation.tcl
source riscv_lint_automation.tcl
source riscv_lint_automation.tcl
