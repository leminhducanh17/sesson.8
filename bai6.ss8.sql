-- Tạo bảng DangKyGoi

CREATE TABLE DangKyGoi (
ma_dang_ky INT,
ma_khach_hang INT,
ten_goi VARCHAR(50), -- 'Cơ Bản', 'Tiêu Chuẩn', 'Cao Cấp'
phi_hang_thang DECIMAL(10, 2),
ngay_bat_dau DATE
);

-- Chèn dữ liệu mẫu

INSERT INTO DangKyGoi (ma_dang_ky, ma_khach_hang, ten_goi, phi_hang_thang, ngay_bat_dau) VALUES
(1, 101, 'Cơ Bản', 99000.00, '2022-01-15'),
(2, 102, 'Cao Cấp', 259000.00, '2021-06-20'),
(3, 103, 'Tiêu Chuẩn', 179000.00, '2023-03-10'),
(4, 101, 'Tiêu Chuẩn', 179000.00, '2023-05-20'),
(5, 104, 'Cao Cấp', 259000.00, '2021-11-01'),
(6, 102, 'Tiêu Chuẩn', 179000.00, '2023-01-30'),
(7, 105, 'Cơ Bản', 99000.00, '2023-08-12'),
(8, 104, 'Cao Cấp', 259000.00, '2022-11-01'),
(9, 102, 'Cơ Bản', 99000.00, '2023-09-05'),
(10, 104, 'Tiêu Chuẩn', 179000.00, '2023-02-15'),
(11, 101, 'Cao Cấp', 259000.00, '2023-10-01');

SELECT 
    ten_goi,
    COUNT(ma_dang_ky) AS so_luot_dang_ky,
    SUM(phi_hang_thang) AS tong_doanh_thu
FROM DangKyGoi
GROUP BY ten_goi;
SELECT 
    ma_khach_hang,
    SUM(phi_hang_thang) AS tong_chi_tieu,
    COUNT(ma_dang_ky) AS so_goi_da_mua,
    MIN(ngay_bat_dau) AS ngay_tham_gia_dau_tien
FROM DangKyGoi
GROUP BY ma_khach_hang;
SELECT 
    ma_khach_hang,
    SUM(phi_hang_thang) AS tong_chi_tieu,
    COUNT(ma_dang_ky) AS so_goi_da_mua,
    MIN(ngay_bat_dau) AS ngay_tham_gia_dau_tien
FROM DangKyGoi
GROUP BY ma_khach_hang
HAVING 
    SUM(phi_hang_thang) > 500000
    AND COUNT(ma_dang_ky) >= 3
    AND MIN(ngay_bat_dau) < '2023-01-01';

