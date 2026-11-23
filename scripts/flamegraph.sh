#!/bin/bash
# bash scripts/flamegraph.sh build/bench_O0 O0 [system]
BIN="$1"; NAME="$2"; MODE="$3"
ARGS="${ARGS:-1024 16777216 50}"
FG="${FLAMEGRAPH:-FlameGraph}"
OUT="results/$NAME"
mkdir -p "$OUT"

if [ "$MODE" = system ]; then
    F="$OUT/system"; ALL=-a
else
    F="$OUT/flame"; ALL=
fi

perf record -e cycles -F 999 $ALL -g -o "$F.data" -- "$BIN" $ARGS > /dev/null
perf script -i "$F.data" -F comm,pid,tid,time,event,ip,sym,dso > "$F.perf"
"$FG/stackcollapse-perf.pl" "$F.perf" > "$F.folded"
"$FG/flamegraph.pl" --title "$NAME $MODE" "$F.folded" > "$F.svg"
echo "$F.svg"
