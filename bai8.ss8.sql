-- BƯỚC 1: BẢNG DỮ LIỆU PHÂN TÍCH KHÁCH HÀNG (tổng hợp từ DonHang)
SELECT
    ma_khach_hang,
    SUM(tong_gia_tri) AS tong_chi_tieu,
    COUNT(ma_don_hang) AS tong_so_don_hang,
    AVG(tong_gia_tri) AS chi_tieu_trung_binh,
    MIN(ngay_dat_hang) AS ngay_dau_tien,
    MAX(ngay_dat_hang) AS ngay_gan_nhat
FROM DonHang
GROUP BY ma_khach_hang
ORDER BY tong_chi_tieu DESC;


 /*
 ============================================================================
 BƯỚC 2: THIẾT KẾ HỆ THỐNG PHÂN HẠNG KHÁCH HÀNG (BẠC / VÀNG / BẠCH KIM)
 ============================================================================
 
 TÓM TẮT PHÂN BỔ DỮ LIỆU (dẫn chứng từ kết quả Bước 1 với dữ liệu mẫu):
 - ma_khach_hang 102: tong_chi_tieu = 6.230.000 (5 đơn)
 - ma_khach_hang 104: tong_chi_tieu = 2.800.000 (3 đơn)
 - ma_khach_hang 106: tong_chi_tieu = 2.800.000 (1 đơn)
 - ma_khach_hang 101: tong_chi_tieu = 1.820.000 (5 đơn)
 - ma_khach_hang 103: tong_chi_tieu =   750.000 (3 đơn)
 - ma_khach_hang 105: tong_chi_tieu =   250.000 (1 đơn)

 Mục tiêu thiết kế:
 - Ngưỡng phải phản ánh phân bố thực tế (không quá nhiều người ở hạng cao),
 - Kết hợp hai chiều: "tổng chi tiêu" (primary) + "số đơn hàng" (secondary) để tách khách có chi tiêu lớn do 1 đơn khác với khách chi tiêu lớn và mua lặp lại.

 ---------------------------
 QUY ƯỚC PHÂN HẠNG (định lượng rõ ràng)
 ---------------------------

 1) Hạng BẠCH KIM (Platinum)
    - Tiêu chí (chỉ cần 1 trong 2 điều kiện):
      a) tong_chi_tieu >= 2_500_000
      OR
      b) tong_chi_tieu >= 2_000_000 AND tong_so_don_hang >= 3
    - Quyền lợi (tăng dần, ưu đãi mạnh nhất):
      • Giảm 15% cho mọi đơn hàng (không áp dụng cùng khuyến mãi khác).
      • Miễn phí vận chuyển cho đơn trên 200.000.
      • Quyền truy cập ưu tiên/early-access cho sách mới + quà sinh nhật giá trị.
    - Lý do:
      • Ngưỡng 2.5M tách được top 3 khách trong dữ liệu mẫu (102,104,106).
      • Điều kiện thay thế (2.0M + >=3 đơn) bảo đảm khách "chi tiêu lớn & trung thành" cũng được công nhận.

 2) Hạng VÀNG (Gold)
    - Tiêu chí:
      • 750_000 <= tong_chi_tieu < 2_500_000
      OR
      • (tong_so_don_hang >= 3 AND tong_chi_tieu >= 500_000)
    - Quyền lợi:
      • Giảm 10% cho 1–2 sản phẩm chọn lọc mỗi tháng.
      • Miễn phí một lần vận chuyển cho đơn > 300.000 mỗi quý.
      • Quà tặng sinh nhật/phiếu ưu đãi 50k.
    - Lý do:
      • Ngưỡng 750k đặt vừa đủ để lọc nhóm trung bình-cao (ví dụ: 101: 1.82M → Vàng).
      • Điều kiện phụ cho phép công nhận khách thường xuyên mua (>=3 đơn) dù tổng chi tiêu hơi thấp.

 3) Hạng BẠC (Silver)
    - Tiêu chí:
      • tong_chi_tieu < 750_000
      OR
      • khách không thỏa các điều kiện trên
    - Quyền lợi:
      • Giảm 5% cho ưu đãi định kỳ (chỉ một số sản phẩm).
      • Phiếu thử nghiệm 20k cho lần mua tiếp theo khi đạt ngưỡng tối thiểu.
    - Lý do:
      • Giữ lợi ích nhỏ để khuyến khích tái mua nhưng không làm xói mòn lợi nhuận.

 ---------------------------
 CÁC GHI CHÚ THÊM (các biến thể & an toàn)
 ---------------------------
 - Recency (hoạt động gần đây) có thể thêm làm điều kiện 'active' (ví dụ MAX(ngay_dat_hang) trong 12 tháng gần nhất) để tránh khen thưởng khách đã không mua trong 1 năm.
 - Nếu tỷ lệ khách Bạch Kim quá cao trong dữ liệu thực tế, nâng ngưỡng tổng chi tiêu  (ví dụ 3_000_000) để bảo toàn chi phí ưu đãi.
 - Cân nhắc thử nghiệm A/B cho từng quyền lợi trong 2 quý để đo tác động lên tần suất mua và CLV.
 
 LẬP LUẬN CHUNG:
 - Ngưỡng chọn theo phân bố mẫu nhằm tạo ra khoảng phân bổ hợp lý: top ~3 khách thành Bạch Kim, 1–2 khách Vàng, phần còn lại Bạc.
 - Kết hợp tổng chi tiêu (độ lớn) và số đơn (độ trung thành) giúp tránh trường hợp một đơn duy nhất rất lớn (ví dụ 2.8M của 106) bị xử lý tương tự khách mua lặp lại — do đó có điều kiện thứ hai cho khách bạch kim để công nhận trung thành.
 ============================================================================
 */

-- (TÙY CHỌN) BÁN TỰ ĐỘNG: Truy vấn phân loại khách theo ngưỡng đã thiết kế
-- (Bạn có thể chạy truy vấn này sau khi tạo bảng phân tích ở Bước 1)
SELECT
    ma_khach_hang,
    tong_chi_tieu,
    tong_so_don_hang,
    chi_tieu_trung_binh,
    ngay_dau_tien,
    ngay_gan_nhat,
    CASE
        WHEN tong_chi_tieu >= 2500000 OR (tong_chi_tieu >= 2000000 AND tong_so_don_hang >= 3) THEN 'BachKim'
        WHEN tong_chi_tieu >= 750000 OR (tong_so_don_hang >= 3 AND tong_chi_tieu >= 500000) THEN 'Vang'
        ELSE 'Bac'
    END AS hang_khach_hang
FROM (
    SELECT
        ma_khach_hang,
        SUM(tong_gia_tri) AS tong_chi_tieu,
        COUNT(ma_don_hang) AS tong_so_don_hang,
        AVG(tong_gia_tri) AS chi_tieu_trung_binh,
        MIN(ngay_dat_hang) AS ngay_dau_tien,
        MAX(ngay_dat_hang) AS ngay_gan_nhat
    FROM DonHang
    GROUP BY ma_khach_hang
) AS sub
ORDER BY tong_chi_tieu DESC;
