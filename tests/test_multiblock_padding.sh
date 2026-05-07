#!/usr/bin/env bash

set -euo pipefail


PT="1111000011110000111100001111000011110000111100001111000011110000101010101010101010101010101010101010"
KEY="0001001100110100010101110111100110011011101111001101111111110001"

echo "Running Multi-block & Padding Test..."


RESULT=$(echo -e "1\n$PT\n$KEY" | ./des | tail -n 1)


LEN=${#RESULT}

if [ $LEN -eq 128 ]; then
    echo "Padding Test: PASSED (Length is $LEN bits)"
    
    
    DECRYPTED=$(echo -e "2\n$RESULT\n$KEY" | ./des | tail -n 1)
    

    if [[ $DECRYPTED == $PT* ]]; then
        echo "Multi-block Integrity: PASSED"
        exit 0
    else
        echo "Multi-block Integrity: FAILED"
        exit 1
    fi
else
    echo "Padding Test: FAILED (Length is $LEN, expected 128)"
    exit 1
fi
