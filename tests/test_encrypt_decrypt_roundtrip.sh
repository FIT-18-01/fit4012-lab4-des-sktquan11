#!/usr/bin/env bash
# Test kiểm tra tính toàn vẹn: Plaintext -> Encrypt -> Decrypt -> Plaintext
set -euo pipefail

# Chuỗi gốc ban đầu
ORIGINAL_PT="1100110011001100110011001100110011001100110011001100110011001100"
KEY="0001001100110100010101110111100110011011101111001101111111110001"

echo "Running Round-trip Test..."

# Bước 1: Mã hóa (Mode 1)
CIPHER=$(echo -e "1\n$ORIGINAL_PT\n$KEY" | ./des | tail -n 1)

# Bước 2: Giải mã kết quả vừa nhận được (Mode 2)
FINAL_PT=$(echo -e "2\n$CIPHER\n$KEY" | ./des | tail -n 1)

# Bước 3: So sánh chuỗi sau cùng với chuỗi gốc
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
