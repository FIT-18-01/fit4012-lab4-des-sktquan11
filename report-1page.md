# Report 1 page - Lab 4 DES / TripleDES

## Mục tiêu

Tìm hiểu và cài đặt thành công thuật toán mã hóa đối xứng DES và TripleDES (3DES).

## Cách làm / Method

Ngôn ngữ: Sử dụng C++ để triển khai các lớp xử lý chính.

Cấu trúc chương trình:

Lớp KeyGenerator: Thực hiện sinh 16 khóa vòng (Round Keys) từ khóa chính 64-bit thông qua các bảng hoán vị PC1, PC2 và phép dịch bit trái (Left Shift).

Lớp DES: Cài đặt quy trình mã hóa chuẩn gồm Hoán vị khởi tạo (IP), 16 vòng lặp Feistel (mở rộng Expansion, XOR khóa vòng, thay thế S-box, hoán vị P-box) và Hoán vị nghịch đảo (IP-1).

Bổ sung chức năng:

Cài đặt cơ chế giải mã (Decryption) bằng cách sử dụng các khóa vòng theo thứ tự đảo ngược.

Thêm hàm apply_padding để thực hiện Zero Padding cho các khối dữ liệu không đủ 64-bit.

Hỗ trợ xử lý đa khối (Multi-block) cho các chuỗi nhị phân dài.

Triển khai TripleDES theo mô hình E-D-E (Encrypt-Decrypt-Encrypt) với 3 khóa độc lập.

## Kết quả / Result

Chương trình biên dịch thành công bằng g++ và chạy ổn định trên môi trường PowerShell.

Ví dụ kiểm thử DES (Mode 1):

Plaintext: 0001001000110100010101100111100010011010101111001101111011110001

Key: 0001001100110100010101110111100110011011101111001101111111110001

Ciphertext thu được: 0111111010111110100010010010011010001111111101011111101011111000

## Kết luận / Conclusion

Điều học được: Hiểu sâu về quy trình biến đổi dữ liệu trong mã hóa khối và tầm quan trọng của việc hoán vị khóa.

Hạn chế: Hiện tại chương trình mới chỉ xử lý dữ liệu đầu vào ở dạng chuỗi ký tự nhị phân (0/1).

Hướng mở rộng: Phát triển thêm khả năng mã hóa cho các định dạng văn bản (ASCII/UTF-8) và hỗ trợ các chế độ mã hóa khối nâng cao như CBC hoặc CTR.
