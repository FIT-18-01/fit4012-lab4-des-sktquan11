
set -euo pipefail


ORIGINAL_PT="1100110011001100110011001100110011001100110011001100110011001100"
KEY="0001001100110100010101110111100110011011101111001101111111110001"

echo "Running Round-trip Test..."


CIPHER=$(echo -e "1\n$ORIGINAL_PT\n$KEY" | ./des | tail -n 1)


FINAL_PT=$(echo -e "2\n$CIPHER\n$KEY" | ./des | tail -n 1)


if [ "$FINAL_PT" == "$ORIGINAL_PT" ]; then
    echo "Round-trip Test: PASSED"
    echo "Original: $ORIGINAL_PT"
    echo "Final   : $FINAL_PT"
    exit 0
else
    echo "Round-trip Test: FAILED"
    echo "Mismatch found!"
    exit 1
fi
