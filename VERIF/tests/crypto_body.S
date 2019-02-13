#crytpo body
# gpr register: source: x5 and x6


# Zbkb - Bit manipulation instruction
rol     x7,  x5, x6
ror     x8,  x5, x6
andn    x9,  x5, x6
orn     x10, x5, x6
xnor    x11, x5, x6
pack    x12, x5, x6
packh   x13, x5, x6
zip     x14, x5
unzip   x15, x5

# Zbkc - carry less multiply instruction
clmul   x16, x5, x6
clmulh  x17, x5, x6

# Zkne/Zknd - AES Encryption Instruction 
aes32esi    x18, x5, x6, 0
aes32esmi   x19, x5, x6, 0 






