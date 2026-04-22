#!/usr/bin/env bash
# Test kiểm tra xử lý Multi-block và Zero Padding
set -euo pipefail

# Plaintext này có 100 bit (Khối 1: 64 bit, Khối 2: 36 bit)
# Chương trình phải tự bù thêm 28 bit '0' vào khối 2 để đủ 128 bit (2 khối)
PT="1111000011110000111100001111000011110000111100001111000011110000101010101010101010101010101010101010"
KEY="0001001100110100010101110111100110011011101111001101111111110001"

echo "Running Multi-block & Padding Test..."

# Chạy mã hóa
RESULT=$(echo -e "1\n$PT\n$KEY" | ./des | tail -n 1)

# Kiểm tra độ dài kết quả (Bắt buộc phải là bội số của 64, ở đây là 128 bit)
LEN=${#RESULT}

if [ $LEN -eq 128 ]; then
    echo "Padding Test: PASSED (Length is $LEN bits)"
    
    # Thử giải mã ngược lại để xem có ra đúng chuỗi ban đầu (đã được bù 0) không
    DECRYPTED=$(echo -e "2\n$RESULT\n$KEY" | ./des | tail -n 1)
    
    # Vì mình dùng Zero Padding, chuỗi giải mã sẽ có các số 0 ở cuối
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
