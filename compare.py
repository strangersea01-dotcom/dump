import sys
import os
import re

def hex_to_int(x):
    return int(x.replace("(", "").replace(")", ""), 16)


# ================= Parse SPIKE LOG =================
def parse_spike_line(line):
    parts = line.strip().split()

    if len(parts) < 4:
        return None

    try:
        # -------- PC --------
        pc = None
        for p in parts:
            if p.startswith("0x"):
                pc = p.replace(":", "").lower()
                break

        if pc is None:
            return None

        # -------- MEM / LOAD --------
        if "mem" in parts:
            mem_idx = parts.index("mem")

            # LOAD
            if mem_idx >= 2 and parts[mem_idx - 2].startswith("x"):
                rd = parts[mem_idx - 2]
                data = parts[mem_idx - 1]
                addr = parts[mem_idx + 1]
                return ("LOAD", pc, rd, data.lower(), addr.lower())

            # STORE
            addr = parts[mem_idx + 1]
            data = parts[mem_idx + 2]
            return ("MEM", pc, addr.lower(), data.lower())

         # -------- FPU REG --------
        if "c768_mstatus" in parts:
            f_match = re.search(
                r'\b(f(?:[0-9]|[12][0-9]|3[01]))\s+(0x[0-9a-fA-F]+)\b',
                line
            )

            if f_match:
                fd = f_match.group(1)
                data = f_match.group(2)

                if fd == "f0":
                    return None

                return ("FREG", pc, fd, data.lower())
            
        # -------- REG --------
        for i in range(len(parts)):
            if parts[i].startswith("x") and i + 1 < len(parts):
                rd = parts[i]
                data = parts[i + 1]
                return ("REG", pc, rd, data.lower())

    except:
        return None


# ================= Parse RTL LOG =================
def parse_rtl_line(line):

    if "PC=" not in line:
        return None

    try:
        pc = re.search(r'PC=([0-9a-fA-F]+)', line).group(1)
        pc = "0x" + pc.lower()

        # ---------------- FPU REGISTER ----------------
        if "FREG" in line:
            rd = re.search(r'RD=(f\d+)', line).group(1)

            if rd == "f0":
                return None

            data = re.search(r'DATA=([0-9a-fA-F]+)', line).group(1)

            return ("FREG", pc, rd, "0x" + data.lower())

        # ---------------- INTEGER REGISTER ----------------
        if "REG" in line:
            rd = re.search(r'RD=(x\d+)', line).group(1)

            if rd == "x0":
                return None

            data = re.search(r'DATA=([0-9a-fA-F]+)', line).group(1)

            return ("REG", pc, rd, "0x" + data.lower())

        # ---------------- MEMORY ----------------
        elif "MEM" in line:
            addr = re.search(r'ADDR=([0-9a-fA-F]+)', line).group(1)
            data = re.search(r'DATA=([0-9a-fA-F]+)', line).group(1)

            return (
                "MEM",
                pc,
                "0x" + addr.lower(),
                "0x" + data.lower()
            )

    except:
        return None


# ================= MAIN =================
if len(sys.argv) < 2:
    print("Usage: python compare.py <TEST>")
    sys.exit(1)

TEST = sys.argv[1]

LOG_DIR = os.path.join("../sim/LOG_FILES", TEST)

SPIKE_LOG = os.path.join(LOG_DIR, "spike_trace.log")
RTL_LOG   = os.path.join(LOG_DIR, "rtl_trace.log")
OUT_LOG   = os.path.join(LOG_DIR, "compare_result.log")


# ================= Read files =================
spike_lines = open(SPIKE_LOG).readlines()
rtl_lines   = open(RTL_LOG).readlines()

spike = []
rtl = []

# SPIKE
for l in spike_lines:
    parsed = parse_spike_line(l)
    if parsed:
        pc_val = int(parsed[1], 16)
        if pc_val >= 0x80000000 and parsed[0] == "FREG":
            spike.append(parsed)

# RTL
for l in rtl_lines:
    parsed = parse_rtl_line(l)
    if parsed:
        rtl.append(parsed)

print("Spike entries:", len(spike))   
print("RTL entries  :", len(rtl))
print("\n========== SPIKE PARSED ENTRIES ==========")
for i, entry in enumerate(spike):
    print(i, entry)

# ================= Pipeline offset =================
OFFSET = 0   #defualt
rtl = rtl[OFFSET:]


# ================= Compare =================
print("\n===== Spike vs RTL Comparison =====\n")

fail_count = 0
pass_count = 0

log_file = open(OUT_LOG, "w")

MAX_DESYNC = 0   # pipeline

i = 0
j = 0

while i < len(spike) and j < len(rtl):

    entry_s = spike[i]
    entry_r = rtl[j]

    type_s, pc_s = entry_s[0], entry_s[1]
    type_r, pc_r = entry_r[0], entry_r[1]

    # -------- TYPE CHECK --------
    if not (type_s == type_r or (type_s == "LOAD" and type_r == "REG")):
        print("TYPE MISMATCH:", type_s, type_r, "PC:", pc_s, pc_r)
        log_file.write("TYPE MISMATCH {} {} {} {}\n".format(type_s, type_r, pc_s, pc_r))
        fail_count += 1
        i += 1
        j += 1
        continue

    # -------- PC MATCH --------
    if pc_s != pc_r:

        print("\nPC mismatch  DETECTED")
        print("SPIKE PC:", pc_s, " RTL PC:", pc_r)

        fail_count += 1
        i += 1
        j += 1

        continue

    # -------- UNPACK --------
    if type_s in ["REG", "MEM"]:
        op_s, data_s = entry_s[2], entry_s[3]
    else:
        op_s, data_s = entry_s[2], entry_s[3]

    op_r, data_r = entry_r[2], entry_r[3]

    # -------- OPERAND CHECK --------
    if op_s != op_r:
        print("FAIL(OP):", pc_s, op_s, op_r)
        log_file.write("FAIL(OP) {} {} {}\n".format(pc_s, op_s, op_r))
        fail_count += 1
        i += 1
        j += 1
        continue

    # -------- DATA CHECK --------
    if hex_to_int(data_s) != hex_to_int(data_r):
        print("RTL   : PC={} RD={} DATA={}".format(pc_r, op_r, data_r))
        print("SPIKE : PC={} RD={} DATA={}".format(pc_s, op_s, data_s))
        #print("RESULT: {}".format(status))
        print("-" * 50)
        log_file.write("FAIL(DATA) {} {} {}\n".format(pc_s, data_s, data_r))
        fail_count += 1
    else:
        pass_count += 1

        rtl_str   = "PC={} RD={} DATA={}".format(pc_r, op_r, data_r)
        spike_str = "PC={} RD={} DATA={}".format(pc_s, op_s, data_s)

        print("RTL   : {}".format(rtl_str))
        print("SPIKE : {}".format(spike_str))
        print("RESULT: PASS")
        print("-" * 50)

        log_file.write("RTL   : {}\n".format(rtl_str))
        log_file.write("SPIKE : {}\n".format(spike_str))
        log_file.write("RESULT: PASS\n")
        log_file.write("-" * 50 + "\n")

    i += 1
    j += 1


# ================= SUMMARY =================
print("\n" + "=" * 60)
print("Total  :", pass_count + fail_count)
print("Passed :", pass_count)
print("Failed :", fail_count)

log_file.write("\nTotal {}\nPassed {}\nFailed {}\n".format(
    pass_count + fail_count, pass_count, fail_count))

if fail_count == 0:
    print("\nALL MATCHED SUCCESSFULLY")
else:
    print("\nMISMATCH FOUND")

log_file.close()
