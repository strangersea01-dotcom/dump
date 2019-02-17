.section .text
.global _start

_start:

    # ============================================================
    # INTEGER SETUP
    # ============================================================
    # These are only used to provide memory addresses / conversion
    # operands. The actual test workload is F-extension instructions.
    # ============================================================

    #li      t0, 1
    #li      t1, 2
    #li      t2, 3
    #li      t3, 4
    #li      t4, 5
    
    la      t5, test_data
 /*   
    fsw     f0,   0(t5)
    fsw     f1,   4(t5)
    fsw     f2,   8(t5)
    fsw     f3,  12(t5)
    fsw     f4,  16(t5)
    fsw     f5,  20(t5)
    fsw     f6,  24(t5)
    fsw     f7,  28(t5)

    fsw     f8,  32(t5)
    fsw     f9,  36(t5)
    fsw     f10, 40(t5)
    fsw     f11, 44(t5)
    fsw     f12, 48(t5)
    fsw     f13, 52(t5)
    fsw     f14, 56(t5)
    fsw     f15, 60(t5)

    fsw     f16, 64(t5)
    fsw     f17, 68(t5)
    fsw     f18, 72(t5)
    fsw     f19, 76(t5)
    fsw     f20, 80(t5)
    fsw     f21, 84(t5)
    fsw     f22, 88(t5)
    fsw     f23, 92(t5)

    fsw     f24, 96(t5)
    fsw     f25, 100(t5)
    fsw     f26, 104(t5)
    fsw     f27, 108(t5)
    fsw     f28, 112(t5)
    fsw     f29, 116(t5)
    fsw     f30, 120(t5)
    fsw     f31, 124(t5)
    */
    # ============================================================
    # FLOATING-POINT LOAD
    # ============================================================
    flw     f0,   0(t5)      # fdata[0]  = 40400000
    flw     f1,   4(t5)      # fdata[1]  = 43C80000
    flw     f2,   8(t5)      # fdata[2]  = 40A00000
    flw     f3,  12(t5)      # fdata[3]  = 43DC8000
    flw     f4,  16(t5)      # fdata[4]  = 40400000
    flw     f5,  20(t5)      # fdata[5]  = 43F20000
    flw     f6,  24(t5)      # fdata[6]  = C0000000
    flw     f7,  28(t5)      # fdata[7]  = 44044000

    flw     f8,  32(t5)      # fdata[8]  = 40A00000
    flw     f9,  36(t5)      # fdata[9]  = 44100000
    flw     f10, 40(t5)      # fdata[10] = 40100000
    flw     f11, 44(t5)      # fdata[11] = 441C4000
    flw     f12, 48(t5)      # fdata[12] = 40400000
    flw     f13, 52(t5)      # fdata[13] = 44290000
    flw     f14, 56(t5)      # fdata[14] = 42100000
    flw     f15, 60(t5)      # fdata[15] = 44364000

    flw     f16, 64(t5)      # fdata[16] = 42840000
    flw     f17, 68(t5)      # fdata[17] = 43B04000
    flw     f18, 72(t5)      # fdata[18] = 40400000
    flw     f19, 76(t5)      # fdata[19] = 44524000
    flw     f20, 80(t5)      # fdata[20] = 40100000
    flw     f21, 84(t5)      # fdata[21] = BF800000
    flw     f22, 88(t5)      # fdata[22] = 40A00000
    flw     f23, 92(t5)      # fdata[23] = C0000000

    flw     f24, 96(t5)      # fdata[24] = 40A00000
    flw     f25, 100(t5)     # fdata[25] = 40A00000
    flw     f26, 104(t5)     # fdata[26] = 7F7FFFFF
    flw     f27, 108(t5)     # fdata[27] = 40B00000
    flw     f28, 112(t5)     # fdata[28] = 4111999A
    flw     f29, 116(t5)     # fdata[29] = 40A00000
    flw     f30, 120(t5)     # fdata[30] = 40400000
    flw     f31, 124(t5)     # fdata[31] = C0000000

    # ============================================================
    # FADD.S
    # ============================================================

    fadd.s   f9,  f1, f2, rne
    fadd.s  f10,  f3, f4, rne
    fadd.s  f11,  f5, f6, rne
    fadd.s  f12,  f7, f8, rne
    fadd.s  f13,  f1, f3, rne
    fadd.s  f14,  f2, f4, rne
    fadd.s  f15,  f5, f7, rne
    fadd.s  f16,  f6, f8, rne

    # ============================================================
    # FSUB.S
    # ============================================================

    fsub.s   f17, f1, f2, rne
    fsub.s   f18, f3, f4, rne
    fsub.s   f19, f5, f6, rne
    fsub.s   f20, f7, f8, rne
    fsub.s   f21, f1, f3, rne
    fsub.s   f22, f2, f4, rne
    fsub.s   f23, f5, f7, rne
    fsub.s   f24, f6, f8, rne

    # ============================================================
    # FMUL.S
    # ============================================================

    fmul.s   f25, f1, f2, rne
    fmul.s   f26, f3, f4, rne
    fmul.s   f27, f5, f6, rne
    fmul.s   f28, f7, f8, rne
    fmul.s   f29, f1, f4, rne
    fmul.s   f30, f2, f5, rne
    fmul.s   f31, f3, f6, rne
    fmul.s   f1,  f4, f7, rne

    # ============================================================
    # FDIV.S
    # ============================================================

    fdiv.s   f2,  f1, f3, rne
    fdiv.s   f3,  f4, f5, rne
    fdiv.s   f4,  f6, f7, rne
    fdiv.s   f5,  f8, f1, rne
    fdiv.s   f6,  f2, f4, rne
    fdiv.s   f7,  f3, f5, rne
    fdiv.s   f8,  f6, f1, rne
    fdiv.s   f9,  f7, f2, rne

    # ============================================================
    # FSQRT.S
    # ============================================================

    fsqrt.s  f10, f1, rne
    fsqrt.s  f11, f2, rne
    fsqrt.s  f12, f3, rne
    fsqrt.s  f13, f4, rne
    fsqrt.s  f14, f5, rne
    fsqrt.s  f15, f6, rne
    fsqrt.s  f16, f7, rne
    fsqrt.s  f17, f8, rne

    # ============================================================
    # FMIN.S
    # ============================================================

    fmin.s   f18, f1, f2
    fmin.s   f19, f3, f4
    fmin.s   f20, f5, f6
    fmin.s   f21, f7, f8
    fmin.s   f22, f1, f4
    fmin.s   f23, f2, f5

    # ============================================================
    # FMAX.S
    # ============================================================

    fmax.s   f24, f1, f2
    fmax.s   f25, f3, f4
    fmax.s   f26, f5, f6
    fmax.s   f27, f7, f8
    fmax.s   f28, f1, f4
    fmax.s   f29, f2, f5

    # ============================================================
    # FEQ.S
    # ============================================================

    feq.s    t6, f1, f2
    feq.s    t6, f3, f4
    feq.s    t6, f5, f6
    feq.s    t6, f7, f8
    feq.s    t6, f1, f1
    feq.s    t6, f3, f3

    # ============================================================
    # FLT.S
    # ============================================================

    flt.s    t6, f1, f2
    flt.s    t6, f3, f4
    flt.s    t6, f5, f6
    flt.s    t6, f7, f8
    flt.s    t6, f2, f1
    flt.s    t6, f4, f3

    # ============================================================
    # FLE.S  (LESS THAN OR EQUAL)
    # ============================================================

    fle.s    t6, f1, f2
    fle.s    t6, f3, f4
    fle.s    t6, f5, f6
    fle.s    t6, f7, f8
    fle.s    t6, f1, f1
    fle.s    t6, f4, f3

    # ============================================================
    # FMV.S  (FLOATING-POINT MOVE)
    # ============================================================

    fmv.s    f30, f1
    fmv.s    f31, f2
    fmv.s    f1,  f3
    fmv.s    f2,  f4
    fmv.s    f3,  f5
    fmv.s    f4,  f6

    # ============================================================
    # INTEGER -> FLOAT CONVERSION
    # ============================================================

    fcvt.s.w    f5,  t0
    fcvt.s.w    f6,  t1
    fcvt.s.w    f7,  t2
    fcvt.s.w    f8,  t3
    fcvt.s.w    f9,  t4

    # ============================================================
    # FLOAT -> INTEGER CONVERSION
    # ============================================================

    fcvt.w.s    t0, f1, rtz
    fcvt.w.s    t1, f2, rtz
    fcvt.w.s    t2, f3, rtz
    fcvt.w.s    t3, f4, rtz
    fcvt.w.s    t4, f5, rtz

    # ============================================================
    # MORE FLOATING-POINT ARITHMETIC
    # ============================================================

    fadd.s   f10, f1, f5
    fsub.s   f11, f2, f6
    fmul.s   f12, f3, f7
    fdiv.s   f13, f4, f8

    fadd.s   f14, f10, f11
    fsub.s   f15, f12, f13
    fmul.s   f16, f14, f15
    fdiv.s   f17, f16, f10

    fsqrt.s  f18, f10
    fsqrt.s  f19, f11
    fsqrt.s  f20, f12
    fsqrt.s  f21, f13

    fmin.s   f22, f18, f19
    fmax.s   f23, f20, f21

    feq.s    t6, f22, f23
    flt.s    t6, f22, f23
    fle.s    t6, f22, f23

    # ============================================================
    # MORE MOVE / CONVERSION
    # ============================================================

    fmv.s       f24, f22
    fmv.s       f25, f23

    fcvt.s.w    f26, t0
    fcvt.s.w    f27, t1
    fcvt.s.w    f28, t2

    fcvt.w.s    t0, f26, rtz
    fcvt.w.s    t1, f27, rtz
    fcvt.w.s    t2, f28, rtz

    # ============================================================
    # FLOATING-POINT STORE
    # ============================================================

    fsw     f1,  32(t5)
    fsw     f2,  36(t5)
    fsw     f3,  40(t5)
    fsw     f4,  44(t5)
    fsw     f5,  48(t5)
    fsw     f6,  52(t5)
    fsw     f7,  56(t5)
    fsw     f8,  60(t5)

    fsw     f10, 64(t5)
    fsw     f11, 68(t5)
    fsw     f12, 72(t5)
    fsw     f13, 76(t5)

    # ============================================================
    # FINAL MIX OF F INSTRUCTIONS
    # ============================================================

    fadd.s   f29, f1, f2
    fsub.s   f30, f3, f4
    fmul.s   f31, f5, f6
    fdiv.s   f1,  f7, f8

    fsqrt.s  f2, f29

    fmin.s   f3, f30, f31
    fmax.s   f4, f29, f1

    feq.s    t6, f3, f4
    flt.s    t6, f3, f4
    fle.s    t6, f3, f4

    fmv.s    f5, f3
    fmv.s    f6, f4

    # Store final results
    fsw      f29, 80(t5)
    fsw      f30, 84(t5)
    fsw      f31, 88(t5)
    fsw      f1,  92(t5)
    fsw      f2,  96(t5)
    fsw      f3, 100(t5)
    fsw      f4, 104(t5)
    fsw      f5, 108(t5)
    fsw      f6, 112(t5)

    # ============================================================
    # END
    # ============================================================

    li      t0, 1
    la      t1, tohost
    sw      t0, 0(t1)
    
end:
    ebreak

# ================================================================
# DATA
# ================================================================

.section .data
.align 3
test_data:
    .word   0x40400000      # fdata[0]
    .word   0x43C80000      # fdata[1]
    .word   0x40A00000      # fdata[2]
    .word   0x43DC8000      # fdata[3]
    .word   0x40400000      # fdata[4]
    .word   0x43F20000      # fdata[5]
    .word   0xC0000000      # fdata[6]
    .word   0x44044000      # fdata[7]

    .word   0x40A00000      # fdata[8]
    .word   0x44100000      # fdata[9]
    .word   0x40100000      # fdata[10]
    .word   0x441C4000      # fdata[11]
    .word   0x40400000      # fdata[12]
    .word   0x44290000      # fdata[13]
    .word   0x42100000      # fdata[14]
    .word   0x44364000      # fdata[15]

    .word   0x42840000      # fdata[16]
    .word   0x43B04000      # fdata[17]
    .word   0x40400000      # fdata[18]
    .word   0x44524000      # fdata[19]
    .word   0x40100000      # fdata[20]
    .word   0xBF800000      # fdata[21]
    .word   0x40A00000      # fdata[22]
    .word   0xC0000000      # fdata[23]

    .word   0x40A00000      # fdata[24]
    .word   0x40A00000      # fdata[25]
    .word   0x7F7FFFFF      # fdata[26]
    .word   0x40B00000      # fdata[27]
    .word   0x4111999A      # fdata[28]
    .word   0x40A00000      # fdata[29]
    .word   0x40400000      # fdata[30]
    .word   0xC0000000      # fdata[31]


.section .data
.align 3
.globl tohost
tohost:
  .word 0

.globl fromhost
fromhost:
  .word 0 
