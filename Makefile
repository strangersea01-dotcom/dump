XLEN ?= 32
TEST ?= fpu_test
SPIKE_RUN ?= 1

# -------------------------------------------------
# Paths
# -------------------------------------------------

ROOT        = /home/vv2trainee25/Desktop/shashank/FPU_work/FP
RTL_DIR     =$(ROOT)/SIM
VERIF_DIR   = $(ROOT)/VERIFICATION
#FW_DIR      = $(VERIF_DIR)/firmware
PROG_DIR = $(VERIF_DIR)/AS
LOG_ROOT = $(ROOT)/sim/LOG_FILES
LOG_DIR  = $(LOG_ROOT)/$(TEST)

#STARTUP     = /home/sgeuser51/Desktop/Jeevan/spike/VERIFICATION/firmware/startup.S
LINKER      =$(VERIF_DIR)/linker.ld
PROGRAM_C = $(PROG_DIR)/$(TEST).c
PROGRAM_S = $(PROG_DIR)/$(TEST).S

PROGRAM = $(shell if [ -f $(PROGRAM_C) ]; then echo $(PROGRAM_C); else echo $(PROGRAM_S); fi)

#INCLUDE_DIR = /home/sgeuser51/ASM/riscvdv.S

ELF     = $(LOG_DIR)/$(TEST).elf
BIN     = $(LOG_DIR)/$(TEST).bin
HEX     = $(LOG_DIR)/$(TEST).hex
OBJDUMP = $(LOG_DIR)/$(TEST).objdump

SPIKE_LOG = $(LOG_DIR)/spike_trace.log
RTL_LOG   = $(LOG_DIR)/rtl_trace.log

#RTL_LOG     = $(RTL_DIR)/rtl_trcae.log
#SPIKE_LOG   = $(PROG_DIR)/spike_trace.log

# -------------------------------------------------

# Toolchain

# -------------------------------------------------

RISCV_PREFIX =/opt/riscv64im/bin/riscv64-unknown-elf

RISCV_GCC     = $(RISCV_PREFIX)-gcc
RISCV_LD             = $(RISCV_PREFIX)-ld
RISCV_READELF        = $(RISCV_PREFIX)-readel
RISCV_OBJDUMP = $(RISCV_PREFIX)-objdump
RISCV_OBJCOPY = $(RISCV_PREFIX)-objcopy
RISCV_AR             = $(RISCV_PREFIX)-ar
PK = /opt/riscv64im/riscv64-unknown-elf/bin/pk

ARCH = -march=rv32if
ABI  = -mabi=ilp32f

CFLAGS = $(ARCH) $(ABI) -I$(INCLUDE_DIR) -Wa,-I$(INCLUDE_DIR) -Wa,-I$(PROG_DIR) -Wall -O -static -nostdlib 

# -------------------------------------------------

# Build

# -------------------------------------------------

all: build rtl spike compare

build:


	@echo "Building program..."

	@echo "Running TEST = $(TEST)"

	mkdir -p $(LOG_DIR)

	$(RISCV_GCC) $(PROGRAM) $(CFLAGS) -T $(LINKER) -o $(ELF)

	$(RISCV_OBJDUMP) -d $(ELF) >  $(OBJDUMP)	

	$(RISCV_OBJCOPY) -O binary $(ELF) $(BIN)

	hexdump -v -e '1/4 "%08x\n"' $(BIN) > $(HEX)

	cp $(HEX) $(RTL_DIR)/program.hex


# -------------------------------------------------

# Run RTL

# -------------------------------------------------

rtl:


	@echo "Running RTL simulation..."

	cd $(RTL_DIR) && \
	irun -access +rwc -f pinaka_fp_flist.f

#	cp $(ROOT)/SIM/irun.log
#	cp $(RTL_LOG) /home/sgeuser51/Desktop/Jeevan/spike/VERIFICATION/firmware/rtl_trace.log
# -------------------------------------------------

# Run Spike

# -------------------------------------------------

spike:


	@echo "Running Spike..."
	env LD_LIBRARY_PATH=/home/vv2trainee19/spike/lib:$$LD_LIBRARY_PATH \
	/home/vv2trainee19/spike/bin/spike --log-commits --isa=RV32IF $(ELF) > $(SPIKE_LOG) 2>&1
	
#	cp $(SPIKE_LOG) $(LOG_DIR)/spike_trace.log

#	cp $(SPIKE_LOG) /home/sgeuser51/Desktop/Jeevan/spike/VERIFICATION/firmware/spike_trace.log
	@echo "Run completed Spike..."
# -------------------------------------------------

# Compare logs

# -------------------------------------------------


compare:
	@echo "Running Spike vs RTL comparison..."
	@python compare.py $(TEST)
# -------------------------------------------------

# Clean

# -------------------------------------------------

clean:

	rm -rf $(LOG_DIR)


