#!/bin/bash
# bash scripts/stats.sh build/bench_O0 O0
BIN="$1"; NAME="$2"
ARGS="${ARGS:-1024 16777216 50}"
OUT="results/$NAME"
mkdir -p "$OUT"
export LC_ALL=C

/usr/bin/time --verbose "$BIN" $ARGS > "$OUT/program_output.txt" 2> "$OUT/time_verbose.txt"
perf stat -d -r 5 -o "$OUT/perf_stat.txt" -- "$BIN" $ARGS > /dev/null
perf record -g -o "$OUT/perf.data" -- "$BIN" $ARGS > /dev/null
perf report -i "$OUT/perf.data" --stdio --no-children --percent-limit 1 > "$OUT/perf_report.txt" 2>/dev/null
perf annotate -i "$OUT/perf.data" --stdio -s matmul > "$OUT/perf_annotate_matmul.txt" 2>/dev/null

cat "$OUT/time_verbose.txt" "$OUT/perf_stat.txt"
