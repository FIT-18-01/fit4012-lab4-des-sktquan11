
set -euo pipefail


PT="0001001000110100010101100111100010011010101111001101111011110001"
CORRECT_KEY="0001001100110100010101110111100110011011101111001101111111110001"

echo "Running Wrong Key Negative Test..."


CIPHER=$(echo -e "1\n$PT\n$CORRECT_KEY" | ./des | tail -n 1)


LAST_BIT_KEY=${CORRECT_KEY:63:1}
if [ "$LAST_BIT_KEY" == "0" ]; then
    WRONG_KEY="${CORRECT_KEY:0:63}1"
else
    WRONG_KEY="${CORRECT_KEY:0:63}0"
fi


WRONG_PT=$(echo -e "2\n$CIPHER\n$WRONG_KEY" | ./des | tail -n 1)


if [ "$WRONG_PT" != "$PT" ]; then
    echo "Wrong Key Test: PASSED (Decryption failed with incorrect key as expected)"
    echo "Correct PT: $PT"
    echo "Wrong PT  : $WRONG_PT"
    exit 0
else
    echo "Wrong Key Test: FAILED (Decryption should not work with a wrong key)"
    exit 1
fi
