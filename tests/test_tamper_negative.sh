
set -euo pipefail


PT="0001001000110100010101100111100010011010101111001101111011110001"
KEY="0001001100110100010101110111100110011011101111001101111111110001"

echo "Running Tamper Negative Test..."

CIPHER=$(echo -e "1\n$PT\n$KEY" | ./des | tail -n 1)


FIRST_BIT=${CIPHER:0:1}
if [ "$FIRST_BIT" == "0" ]; then
    TAMPERED_CIPHER="1${CIPHER:1}"
else
    TAMPERED_CIPHER="0${CIPHER:1}"
fi


TAMPERED_PT=$(echo -e "2\n$TAMPERED_CIPHER\n$KEY" | ./des | tail -n 1)


if [ "$TAMPERED_PT" != "$PT" ]; then
    echo "Tamper Test: PASSED (Decrypted text changed as expected)"
    echo "Original PT: $PT"
    echo "Tampered PT: $TAMPERED_PT"
    exit 0
else
    echo "Tamper Test: FAILED (Decrypted text did not change despite tampering)"
    exit 1
fi
