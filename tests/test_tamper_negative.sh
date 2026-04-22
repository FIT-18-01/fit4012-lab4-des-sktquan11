#!/usr/bin/env bash
# Test kiểm tra tính nhạy cảm của bản mã (Bit Flip / Tamper Test)
set -euo pipefail

# Plaintext và Key gốc
PT="0001001000110100010101100111100010011010101111001101111011110001"
KEY="0001001100110100010101110111100110011011101111001101111111110001"

echo "Running Tamper Negative Test..."

# Bước 1: Mã hóa để lấy bản mã chuẩn
CIPHER=$(echo -e "1\n$PT\n$KEY" | ./des | tail -n 1)

# Bước 2: Làm giả bản mã (Tamper) - Đảo ngược bit đầu tiên từ 0 thành 1 hoặc ngược lại
FIRST_BIT=${CIPHER:0:1}
if [ "$FIRST_BIT" == "0" ]; then
    TAMPERED_CIPHER="1${CIPHER:1}"
else
    TAMPERED_CIPHER="0${CIPHER:1}"
fi

# Bước 3: Giải mã bản mã đã bị sửa đổi
TAMPERED_PT=$(echo -e "2\n$TAMPERED_CIPHER\n$KEY" | ./des | tail -n 1)

# Bước 4: Kiểm tra. Kết quả giải mã SAI mới là THÀNH CÔNG cho test này
if [ "$TAMPERED_PT" != "$PT" ]; then
    echo "Tamper Test: PASSED (Decrypted text changed as expected)"
    echo "Original PT: $PT"
    echo "Tampered PT: $TAMPERED_PT"
    exit 0
else
    echo "Tamper Test: FAILED (Decrypted text did not change despite tampering)"
    exit 1
fi
