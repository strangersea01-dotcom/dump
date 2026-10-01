set fp [open "structured_fpu_test.S" w]

# Write RISC-V Boot Structure & Enable FPU
puts $fp ".globl _start"
puts $fp ".section .text"
puts $fp "_start:"
puts $fp "    # Enable FPU in mstatus (set FS field to Dirty -> 0x6000)"
puts $fp "    li x1, 0x6000"
puts $fp "    csrs 0x300, x1"
puts $fp "    # Initialize FP registers to zero to prevent X-state propagation"
for {set i 0} {$i < 32} {incr i} {
    puts $fp "    fcvt.s.w f$i, x0"
}
puts $fp "main_fpu_loop:"

# Generate 500 pure, randomized FPU instructions
set r_ops {"fadd.s" "fsub.s" "fmul.s" "fdiv.s"}
set minmax_ops {"fmin.s" "fmax.s"}
set cvt_i2f {"fcvt.s.w" "fcvt.s.wu"}
set cvt_f2i {"fcvt.w.s" "fcvt.wu.s"}

for {set i 0} {$i < 500} {incr i} {
    set type [expr {int(rand() * 5)}]
    set fd "f[expr {int(rand() * 32)}]"
    set fs1 "f[expr {int(rand() * 32)}]"
    set fs2 "f[expr {int(rand() * 32)}]"
    set xd "x[expr {int(rand() * 31) + 1}]"
    set xs "x[expr {int(rand() * 31) + 1}]"

    if {$type == 0} {
        set op [lindex $r_ops [expr {int(rand() * 4)}]]
        puts $fp "    $op $fd, $fs1, $fs2, rne"
    } elseif {$type == 1} {
        set op [lindex $minmax_ops [expr {int(rand() * 2)}]]
        puts $fp "    $op $fd, $fs1, $fs2"
    } elseif {$type == 2} {
        puts $fp "    fsqrt.s $fd, $fs1, rne"
    } elseif {$type == 3} {
        set op [lindex $cvt_i2f [expr {int(rand() * 2)}]]
        puts $fp "    $op $fd, $xs, rne"
    } else {
        set op [lindex $cvt_f2i [expr {int(rand() * 2)}]]
        puts $fp "    $op $xd, $fs1, rne"
    }
}

# Write RISC-V Exit Structure & Data Section
puts $fp "test_done:"
puts $fp "    li gp, 1"
puts $fp "    ecall"
puts $fp "write_tohost:"
puts $fp "    sw gp, tohost, t5"
puts $fp "_exit:"
puts $fp "    j write_tohost"
puts $fp ".section .data"
puts $fp ".align 6; .global tohost; tohost: .dword 0;"
puts $fp ".align 6; .global fromhost; fromhost: .dword 0;"

close $fp
puts "Successfully generated structured_fpu_test.S"
