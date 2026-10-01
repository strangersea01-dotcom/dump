.globl _start
.section .text
_start:
    # Enable FPU in mstatus (set FS field to Dirty -> 0x6000)
    li x1, 0x6000
    csrs 0x300, x1
    # Initialize FP registers to zero to prevent X-state propagation
    fcvt.s.w f0, x0
    fcvt.s.w f1, x0
    fcvt.s.w f2, x0
    fcvt.s.w f3, x0
    fcvt.s.w f4, x0
    fcvt.s.w f5, x0
    fcvt.s.w f6, x0
    fcvt.s.w f7, x0
    fcvt.s.w f8, x0
    fcvt.s.w f9, x0
    fcvt.s.w f10, x0
    fcvt.s.w f11, x0
    fcvt.s.w f12, x0
    fcvt.s.w f13, x0
    fcvt.s.w f14, x0
    fcvt.s.w f15, x0
    fcvt.s.w f16, x0
    fcvt.s.w f17, x0
    fcvt.s.w f18, x0
    fcvt.s.w f19, x0
    fcvt.s.w f20, x0
    fcvt.s.w f21, x0
    fcvt.s.w f22, x0
    fcvt.s.w f23, x0
    fcvt.s.w f24, x0
    fcvt.s.w f25, x0
    fcvt.s.w f26, x0
    fcvt.s.w f27, x0
    fcvt.s.w f28, x0
    fcvt.s.w f29, x0
    fcvt.s.w f30, x0
    fcvt.s.w f31, x0
main_fpu_loop:
    fmax.s f6, f14, f23
    fmax.s f12, f3, f5
    fmin.s f16, f24, f4
    fmin.s f0, f8, f6
    fmin.s f1, f15, f16
    fmax.s f21, f13, f18
    fcvt.wu.s x29, f14, rne
    fcvt.s.wu f25, x22, rne
    fcvt.w.s x22, f5, rne
    fsqrt.s f23, f11, rne
    fcvt.s.w f29, x21, rne
    fmul.s f27, f10, f11, rne
    fcvt.wu.s x5, f26, rne
    fcvt.s.wu f4, x28, rne
    fcvt.wu.s x8, f5, rne
    fsub.s f19, f10, f11, rne
    fdiv.s f20, f10, f11, rne
    fmul.s f10, f21, f13, rne
    fcvt.s.wu f29, x27, rne
    fcvt.s.w f4, x17, rne
    fmin.s f24, f26, f23
    fsqrt.s f28, f22, rne
    fsqrt.s f4, f19, rne
    fdiv.s f15, f1, f21, rne
    fcvt.wu.s x31, f22, rne
    fmax.s f17, f26, f22
    fsub.s f20, f5, f25, rne
    fsqrt.s f10, f14, rne
    fdiv.s f8, f19, f22, rne
    fsqrt.s f15, f27, rne
    fdiv.s f18, f19, f30, rne
    fmax.s f17, f27, f1
    fcvt.wu.s x24, f11, rne
    fsqrt.s f10, f30, rne
    fcvt.w.s x20, f14, rne
    fsqrt.s f2, f11, rne
    fdiv.s f4, f22, f29, rne
    fmin.s f27, f31, f26
    fsub.s f4, f16, f9, rne
    fadd.s f17, f13, f7, rne
    fcvt.wu.s x21, f3, rne
    fcvt.s.w f4, x21, rne
    fmax.s f1, f6, f11
    fmin.s f9, f26, f10
    fsub.s f1, f11, f17, rne
    fcvt.s.wu f27, x25, rne
    fcvt.w.s x18, f12, rne
    fmax.s f16, f12, f19
    fmax.s f3, f22, f10
    fsqrt.s f23, f14, rne
    fcvt.wu.s x1, f26, rne
    fsub.s f31, f7, f16, rne
    fcvt.s.w f2, x27, rne
    fmul.s f4, f11, f31, rne
    fcvt.w.s x29, f18, rne
    fcvt.s.w f29, x21, rne
    fcvt.s.wu f28, x2, rne
    fcvt.s.w f3, x18, rne
    fcvt.wu.s x12, f6, rne
    fcvt.wu.s x28, f1, rne
    fmin.s f27, f17, f21
    fcvt.s.wu f5, x5, rne
    fmul.s f25, f12, f0, rne
    fsqrt.s f16, f20, rne
    fcvt.s.wu f13, x26, rne
    fsqrt.s f19, f27, rne
    fsub.s f22, f13, f4, rne
    fdiv.s f9, f28, f18, rne
    fcvt.s.w f22, x11, rne
    fsqrt.s f5, f21, rne
    fsqrt.s f24, f16, rne
    fsqrt.s f13, f7, rne
    fcvt.s.wu f9, x29, rne
    fadd.s f14, f6, f23, rne
    fcvt.wu.s x9, f12, rne
    fsqrt.s f31, f20, rne
    fcvt.s.wu f22, x17, rne
    fcvt.s.wu f0, x9, rne
    fsqrt.s f15, f14, rne
    fcvt.wu.s x14, f16, rne
    fmax.s f26, f13, f20
    fmax.s f24, f13, f7
    fsqrt.s f4, f30, rne
    fadd.s f16, f27, f27, rne
    fsqrt.s f23, f30, rne
    fsqrt.s f27, f14, rne
    fcvt.s.w f25, x8, rne
    fsqrt.s f2, f16, rne
    fmin.s f25, f1, f11
    fsqrt.s f8, f14, rne
    fadd.s f29, f24, f20, rne
    fsqrt.s f25, f7, rne
    fadd.s f5, f17, f9, rne
    fsqrt.s f26, f9, rne
    fdiv.s f7, f13, f27, rne
    fadd.s f4, f4, f31, rne
    fadd.s f29, f2, f25, rne
    fmax.s f30, f21, f21
    fcvt.wu.s x24, f9, rne
    fcvt.s.wu f4, x3, rne
    fmul.s f12, f1, f13, rne
    fmin.s f10, f2, f15
    fsqrt.s f6, f17, rne
    fmax.s f16, f29, f16
    fmax.s f26, f28, f4
    fcvt.s.wu f14, x7, rne
    fcvt.s.w f1, x9, rne
    fmax.s f17, f5, f13
    fdiv.s f10, f7, f28, rne
    fcvt.w.s x25, f5, rne
    fsub.s f7, f1, f18, rne
    fcvt.wu.s x21, f17, rne
    fmin.s f2, f7, f17
    fcvt.w.s x14, f6, rne
    fsqrt.s f4, f29, rne
    fcvt.w.s x13, f27, rne
    fmin.s f20, f27, f7
    fcvt.s.w f0, x17, rne
    fmax.s f6, f30, f7
    fsqrt.s f23, f26, rne
    fcvt.s.w f11, x23, rne
    fsqrt.s f10, f13, rne
    fsqrt.s f26, f27, rne
    fsqrt.s f8, f30, rne
    fcvt.s.w f27, x20, rne
    fsub.s f8, f19, f31, rne
    fcvt.w.s x10, f22, rne
    fcvt.s.w f3, x8, rne
    fsub.s f30, f18, f23, rne
    fcvt.wu.s x31, f0, rne
    fcvt.w.s x16, f20, rne
    fcvt.w.s x30, f6, rne
    fcvt.s.w f10, x30, rne
    fmax.s f30, f1, f10
    fcvt.s.wu f20, x28, rne
    fdiv.s f13, f7, f1, rne
    fmin.s f15, f10, f24
    fsqrt.s f3, f24, rne
    fcvt.s.w f6, x11, rne
    fcvt.wu.s x17, f8, rne
    fcvt.w.s x1, f3, rne
    fcvt.w.s x5, f7, rne
    fcvt.s.w f17, x9, rne
    fsqrt.s f1, f11, rne
    fcvt.s.wu f19, x11, rne
    fcvt.s.wu f9, x13, rne
    fsqrt.s f17, f15, rne
    fcvt.wu.s x21, f24, rne
    fcvt.s.wu f7, x24, rne
    fcvt.s.wu f5, x16, rne
    fsqrt.s f31, f6, rne
    fcvt.w.s x31, f18, rne
    fsub.s f7, f13, f30, rne
    fsqrt.s f15, f26, rne
    fcvt.s.wu f19, x26, rne
    fadd.s f2, f8, f25, rne
    fcvt.wu.s x6, f14, rne
    fsqrt.s f18, f25, rne
    fsqrt.s f31, f24, rne
    fcvt.wu.s x28, f17, rne
    fcvt.wu.s x25, f0, rne
    fsqrt.s f5, f25, rne
    fcvt.s.wu f20, x26, rne
    fcvt.s.w f1, x23, rne
    fadd.s f18, f6, f7, rne
    fcvt.s.w f31, x16, rne
    fsqrt.s f31, f14, rne
    fcvt.w.s x27, f8, rne
    fsqrt.s f29, f8, rne
    fmax.s f1, f27, f25
    fdiv.s f15, f29, f13, rne
    fsqrt.s f3, f27, rne
    fcvt.s.wu f2, x17, rne
    fcvt.s.w f22, x16, rne
    fcvt.s.wu f15, x24, rne
    fcvt.w.s x26, f4, rne
    fcvt.wu.s x15, f6, rne
    fsqrt.s f10, f7, rne
    fmin.s f13, f19, f26
    fcvt.s.wu f25, x30, rne
    fcvt.s.wu f19, x26, rne
    fmax.s f7, f5, f13
    fsqrt.s f14, f26, rne
    fsqrt.s f13, f3, rne
    fsub.s f22, f13, f10, rne
    fcvt.s.w f4, x29, rne
    fcvt.s.w f27, x29, rne
    fcvt.wu.s x22, f15, rne
    fcvt.s.w f25, x24, rne
    fmul.s f28, f14, f18, rne
    fmin.s f30, f2, f20
    fcvt.wu.s x18, f23, rne
    fsub.s f19, f6, f17, rne
    fsqrt.s f25, f3, rne
    fsqrt.s f23, f28, rne
    fcvt.w.s x10, f22, rne
    fcvt.w.s x21, f1, rne
    fcvt.wu.s x23, f29, rne
    fsqrt.s f25, f4, rne
    fsub.s f1, f16, f4, rne
    fcvt.w.s x3, f31, rne
    fadd.s f5, f15, f18, rne
    fcvt.w.s x29, f12, rne
    fmax.s f18, f8, f25
    fsqrt.s f25, f28, rne
    fcvt.s.wu f29, x2, rne
    fcvt.wu.s x18, f22, rne
    fcvt.s.wu f25, x11, rne
    fcvt.w.s x9, f19, rne
    fmin.s f6, f9, f9
    fsqrt.s f23, f15, rne
    fadd.s f6, f18, f16, rne
    fdiv.s f9, f6, f3, rne
    fsqrt.s f2, f6, rne
    fcvt.s.wu f23, x2, rne
    fcvt.s.wu f27, x30, rne
    fmax.s f5, f15, f27
    fcvt.w.s x2, f16, rne
    fmin.s f23, f19, f15
    fcvt.s.wu f31, x25, rne
    fcvt.w.s x14, f19, rne
    fmax.s f29, f5, f23
    fsqrt.s f23, f7, rne
    fcvt.wu.s x21, f13, rne
    fadd.s f9, f23, f14, rne
    fcvt.w.s x8, f26, rne
    fcvt.w.s x27, f12, rne
    fcvt.s.w f20, x3, rne
    fsqrt.s f1, f3, rne
    fmax.s f2, f21, f20
    fcvt.s.w f24, x4, rne
    fcvt.s.wu f1, x4, rne
    fmax.s f24, f17, f14
    fcvt.s.wu f4, x19, rne
    fcvt.w.s x21, f24, rne
    fsqrt.s f26, f30, rne
    fcvt.wu.s x27, f25, rne
    fmin.s f3, f8, f29
    fdiv.s f12, f12, f14, rne
    fsub.s f18, f15, f15, rne
    fsqrt.s f19, f21, rne
    fsqrt.s f28, f21, rne
    fcvt.s.wu f19, x4, rne
    fmin.s f20, f10, f30
    fmax.s f27, f25, f0
    fcvt.w.s x17, f7, rne
    fsqrt.s f1, f8, rne
    fadd.s f20, f17, f27, rne
    fsqrt.s f27, f12, rne
    fmax.s f28, f6, f10
    fmin.s f23, f4, f26
    fadd.s f17, f1, f8, rne
    fcvt.s.wu f3, x24, rne
    fsqrt.s f2, f3, rne
    fmax.s f9, f0, f3
    fcvt.s.w f11, x3, rne
    fmin.s f23, f13, f3
    fsqrt.s f21, f11, rne
    fcvt.s.wu f24, x26, rne
    fmin.s f26, f15, f19
    fcvt.s.wu f7, x28, rne
    fadd.s f5, f26, f31, rne
    fdiv.s f20, f29, f23, rne
    fcvt.s.wu f11, x7, rne
    fcvt.w.s x26, f23, rne
    fsub.s f30, f14, f27, rne
    fsub.s f12, f31, f10, rne
    fdiv.s f14, f10, f2, rne
    fmin.s f0, f27, f23
    fsqrt.s f0, f4, rne
    fmax.s f2, f5, f13
    fcvt.wu.s x7, f24, rne
    fmin.s f30, f21, f5
    fsqrt.s f18, f31, rne
    fsqrt.s f19, f4, rne
    fmax.s f13, f18, f19
    fmin.s f8, f5, f3
    fcvt.s.wu f2, x29, rne
    fcvt.s.w f30, x8, rne
    fmax.s f1, f22, f13
    fcvt.w.s x25, f1, rne
    fcvt.w.s x11, f11, rne
    fmul.s f20, f5, f17, rne
    fcvt.wu.s x28, f24, rne
    fmin.s f11, f1, f7
    fsqrt.s f27, f21, rne
    fmin.s f3, f12, f17
    fcvt.s.wu f6, x5, rne
    fmul.s f14, f1, f24, rne
    fcvt.wu.s x26, f31, rne
    fmax.s f17, f21, f12
    fmin.s f27, f19, f9
    fsqrt.s f27, f16, rne
    fsqrt.s f15, f0, rne
    fsqrt.s f9, f29, rne
    fcvt.wu.s x21, f14, rne
    fcvt.s.w f29, x1, rne
    fcvt.w.s x25, f4, rne
    fmax.s f12, f24, f13
    fcvt.s.wu f19, x2, rne
    fcvt.s.wu f26, x23, rne
    fmin.s f3, f23, f30
    fmax.s f31, f27, f9
    fsqrt.s f2, f18, rne
    fmax.s f1, f18, f15
    fsqrt.s f2, f16, rne
    fcvt.wu.s x28, f2, rne
    fmin.s f1, f18, f1
    fcvt.wu.s x3, f25, rne
    fsqrt.s f12, f0, rne
    fmax.s f10, f16, f16
    fmax.s f28, f3, f8
    fmin.s f9, f14, f15
    fmul.s f8, f1, f9, rne
    fsqrt.s f26, f24, rne
    fcvt.s.w f4, x23, rne
    fsub.s f20, f15, f16, rne
    fmax.s f7, f16, f7
    fmin.s f1, f19, f19
    fcvt.s.wu f23, x3, rne
    fmul.s f29, f12, f3, rne
    fsqrt.s f18, f10, rne
    fmax.s f2, f18, f17
    fcvt.wu.s x14, f20, rne
    fsub.s f13, f23, f22, rne
    fmul.s f18, f15, f25, rne
    fadd.s f12, f16, f28, rne
    fsqrt.s f24, f0, rne
    fsqrt.s f16, f29, rne
    fsqrt.s f1, f28, rne
    fsub.s f20, f11, f9, rne
    fsqrt.s f28, f7, rne
    fcvt.w.s x4, f4, rne
    fcvt.wu.s x26, f4, rne
    fadd.s f23, f14, f8, rne
    fmin.s f29, f5, f11
    fsqrt.s f5, f31, rne
    fsqrt.s f19, f15, rne
    fmax.s f25, f12, f26
    fcvt.s.wu f7, x25, rne
    fcvt.s.w f4, x26, rne
    fcvt.w.s x23, f26, rne
    fsqrt.s f31, f22, rne
    fmax.s f5, f13, f6
    fcvt.wu.s x9, f15, rne
    fcvt.s.wu f19, x28, rne
    fmax.s f23, f24, f17
    fcvt.w.s x25, f30, rne
    fsqrt.s f4, f15, rne
    fsqrt.s f15, f5, rne
    fadd.s f2, f30, f15, rne
    fsub.s f11, f24, f6, rne
    fsub.s f24, f19, f23, rne
    fcvt.wu.s x19, f9, rne
    fcvt.wu.s x15, f19, rne
    fadd.s f22, f14, f10, rne
    fdiv.s f9, f31, f26, rne
    fmul.s f22, f5, f10, rne
    fmax.s f16, f23, f30
    fmax.s f6, f31, f7
    fcvt.w.s x20, f26, rne
    fmax.s f5, f2, f28
    fsqrt.s f31, f3, rne
    fmin.s f31, f21, f18
    fadd.s f16, f18, f19, rne
    fmin.s f21, f18, f24
    fdiv.s f23, f11, f28, rne
    fcvt.s.w f22, x1, rne
    fcvt.s.w f1, x24, rne
    fmin.s f16, f3, f19
    fdiv.s f19, f5, f15, rne
    fdiv.s f11, f11, f24, rne
    fdiv.s f18, f14, f26, rne
    fsqrt.s f22, f27, rne
    fcvt.w.s x1, f18, rne
    fsqrt.s f26, f19, rne
    fmin.s f9, f24, f30
    fcvt.s.w f13, x28, rne
    fcvt.s.w f12, x15, rne
    fmax.s f4, f31, f29
    fsqrt.s f16, f0, rne
    fsub.s f0, f1, f6, rne
    fcvt.s.w f27, x1, rne
    fcvt.s.w f22, x29, rne
    fcvt.w.s x5, f7, rne
    fcvt.wu.s x10, f25, rne
    fcvt.s.w f29, x21, rne
    fcvt.wu.s x23, f0, rne
    fsqrt.s f12, f6, rne
    fcvt.w.s x15, f7, rne
    fcvt.w.s x11, f16, rne
    fmul.s f2, f6, f17, rne
    fmin.s f15, f8, f15
    fmax.s f22, f20, f6
    fsqrt.s f18, f22, rne
    fmax.s f8, f23, f29
    fsqrt.s f17, f12, rne
    fcvt.w.s x25, f10, rne
    fdiv.s f16, f17, f31, rne
    fmax.s f23, f29, f7
    fsub.s f12, f9, f5, rne
    fmax.s f16, f7, f20
    fcvt.wu.s x7, f30, rne
    fcvt.s.wu f30, x27, rne
    fmin.s f8, f23, f22
    fcvt.s.w f5, x25, rne
    fmin.s f6, f7, f27
    fmax.s f7, f1, f15
    fcvt.s.w f15, x7, rne
    fmax.s f15, f19, f18
    fmax.s f21, f26, f14
    fcvt.w.s x4, f20, rne
    fmax.s f24, f19, f0
    fsqrt.s f19, f8, rne
    fmul.s f26, f17, f14, rne
    fsqrt.s f23, f10, rne
    fsqrt.s f29, f11, rne
    fcvt.wu.s x26, f30, rne
    fcvt.wu.s x5, f26, rne
    fdiv.s f1, f3, f0, rne
    fadd.s f15, f25, f1, rne
    fadd.s f26, f10, f0, rne
    fsqrt.s f1, f10, rne
    fsqrt.s f26, f0, rne
    fadd.s f25, f28, f9, rne
    fcvt.wu.s x25, f30, rne
    fsqrt.s f19, f12, rne
    fcvt.w.s x25, f20, rne
    fsqrt.s f27, f0, rne
    fmin.s f19, f25, f10
    fcvt.s.wu f20, x9, rne
    fmin.s f22, f0, f8
    fmin.s f16, f15, f24
    fcvt.s.w f14, x10, rne
    fmax.s f0, f21, f27
    fcvt.w.s x26, f30, rne
    fsqrt.s f23, f31, rne
    fcvt.s.wu f24, x21, rne
    fcvt.wu.s x19, f24, rne
    fsub.s f4, f26, f8, rne
    fsqrt.s f29, f22, rne
    fmin.s f1, f31, f1
    fcvt.s.wu f6, x18, rne
    fsqrt.s f13, f20, rne
    fmin.s f31, f25, f18
    fcvt.wu.s x8, f29, rne
    fdiv.s f15, f23, f20, rne
    fmul.s f28, f5, f26, rne
    fdiv.s f15, f10, f12, rne
    fmax.s f22, f3, f28
    fdiv.s f23, f28, f26, rne
    fcvt.w.s x19, f11, rne
    fcvt.s.w f16, x5, rne
    fsqrt.s f23, f16, rne
    fsub.s f19, f25, f19, rne
    fmul.s f16, f5, f15, rne
    fsqrt.s f20, f10, rne
    fsqrt.s f5, f17, rne
    fcvt.w.s x3, f4, rne
    fdiv.s f28, f21, f29, rne
    fsqrt.s f9, f16, rne
    fcvt.w.s x26, f3, rne
    fcvt.s.wu f27, x12, rne
    fcvt.w.s x30, f12, rne
    fcvt.s.w f22, x26, rne
    fdiv.s f24, f21, f17, rne
    fsqrt.s f1, f22, rne
    fsqrt.s f31, f21, rne
    fcvt.w.s x19, f7, rne
    fcvt.wu.s x11, f24, rne
    fcvt.wu.s x1, f13, rne
    fdiv.s f5, f20, f0, rne
    fmin.s f18, f29, f20
    fadd.s f26, f14, f15, rne
    fsqrt.s f1, f21, rne
    fsub.s f31, f7, f17, rne
    fcvt.s.w f15, x12, rne
    fcvt.s.w f16, x15, rne
    fcvt.wu.s x5, f15, rne
    fcvt.s.w f1, x3, rne
    fmin.s f5, f27, f2
    fsub.s f10, f11, f20, rne
    fmin.s f2, f8, f16
    fsqrt.s f15, f8, rne
    fcvt.s.w f28, x19, rne
    fsqrt.s f29, f17, rne
    fcvt.s.wu f24, x9, rne
    fmin.s f29, f11, f12
    fcvt.wu.s x9, f4, rne
    fmin.s f2, f24, f31
    fmax.s f22, f0, f3
    fdiv.s f26, f19, f6, rne
    fmul.s f11, f31, f26, rne
    fadd.s f18, f26, f16, rne
    fcvt.w.s x9, f26, rne
    fmin.s f9, f10, f31
    fcvt.s.wu f15, x27, rne
    fcvt.s.w f7, x26, rne
    fmax.s f29, f30, f27
    fmax.s f10, f15, f11
test_done:
    li gp, 1
    ecall
write_tohost:
    sw gp, tohost, t5
_exit:
    j write_tohost
.section .data
.align 6; .global tohost; tohost: .dword 0;
.align 6; .global fromhost; fromhost: .dword 0;
