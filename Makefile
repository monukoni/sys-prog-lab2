CC     ?= gcc
ARCH   ?= -march=x86-64-v3
COMMON  = -g -fno-omit-frame-pointer -Wall
LDLIBS  = -lm

BUILD = build
ASM   = asm
SRC   = src/bench.c

all: $(BUILD)/bench_O0 $(BUILD)/bench_O3 $(BUILD)/bench_O3_fastmath asm

$(BUILD):
	mkdir -p $(BUILD)

$(BUILD)/bench_O0: $(SRC) | $(BUILD)
	$(CC) -O0 $(COMMON) -o $@ $< $(LDLIBS)

$(BUILD)/bench_O3: $(SRC) | $(BUILD)
	$(CC) -O3 $(ARCH) $(COMMON) -o $@ $< $(LDLIBS)

$(BUILD)/bench_O3_fastmath: $(SRC) | $(BUILD)
	$(CC) -O3 $(ARCH) -ffast-math $(COMMON) -o $@ $< $(LDLIBS)

asm: $(SRC)
	mkdir -p $(ASM)
	rm -f $(ASM)/vectorized.txt $(ASM)/not_vectorized.txt
	$(CC) -O0 -masm=intel -fno-asynchronous-unwind-tables -S -o $(ASM)/bench_O0.s $<
	$(CC) -O3 $(ARCH) -masm=intel -fno-asynchronous-unwind-tables -S -o $(ASM)/bench_O3.s $< \
		-fopt-info-vec-optimized=$(ASM)/vectorized.txt
	$(CC) -O3 $(ARCH) -c -o /dev/null $< -fopt-info-vec-missed 2>&1 | grep '^src/.*vectori' > $(ASM)/not_vectorized.txt
	$(CC) -O3 $(ARCH) -ffast-math -masm=intel -fno-asynchronous-unwind-tables -S -o $(ASM)/bench_O3_fastmath.s $<

clean:
	rm -rf $(BUILD)

.PHONY: all asm clean
