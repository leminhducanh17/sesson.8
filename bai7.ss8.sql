/* ============================================
   BÁO CÁO PHÂN TÍCH HIỆU SUẤT SẢN PHẨM
   Chuỗi cà phê: GÓC CÀ PHÊ
   ============================================ */
-- NHIỆM VỤ 1: Báo cáo hiệu suất từng sản phẩm
SELECT 
    ten_san_pham,
    SUM(so_luong) AS tong_so_ly_ban,
    SUM(thanh_tien) AS tong_doanh_thu,
    COUNT(DISTINCT ma_don_hang) AS so_don_hang_chua_sp,
    AVG(thanh_tien) AS doanh_thu_trung_binh_moi_don
FROM ChiTietDonHang
GROUP BY ten_san_pham
ORDER BY tong_doanh_thu DESC;
/*
====================================================
NHIỆM VỤ 2: PHÂN TÍCH & ĐỀ XUẤT CHIẾN LƯỢC KINH DOANH
====================================================
1. PHÂN LOẠI SẢN PHẨM
Dựa trên:
- Tổng doanh thu
- Tổng số ly bán
- Số đơn hàng chứa sản phẩm (độ phổ biến)
Sau khi xem kết quả truy vấn:
A. 2 SẢN PHẨM "NGÔI SAO"
1. Cà Phê Sữa
   - Tổng số ly bán: cao nhất
   - Xuất hiện trong nhiều đơn hàng nhất
   - Doanh thu ổn định và bền vững
   -> Là sản phẩm chủ lực, bán chạy đều đặn.
2. Trà Sữa Trân Châu Đường Đen
   - Doanh thu cao do giá cao
   - Số lượng bán ít hơn Cà Phê Sữa nhưng giá trị đơn lớn
   -> Là sản phẩm premium, mang lại lợi nhuận cao.
--------------------------------------------
B. 2 SẢN PHẨM "CẦN XEM XÉT"

1. Trà Chanh Gừng Mật Ong
   - Số lượng bán thấp
   - Số đơn hàng chứa thấp
   - Doanh thu thấp hơn mặt bằng chung
2. Bạc Xỉu
   - Doanh thu thấp hơn các sản phẩm chủ lực
   - Mức độ phổ biến trung bình nhưng không nổi trội
=> Hai sản phẩm này không tạo ra nhiều đóng góp rõ rệt về doanh thu cũng như độ phủ.
--------------------------------------------
2. LẬP LUẬN PHÂN LOẠI
- Sản phẩm "Ngôi sao" được chọn vì:
  + Có tổng doanh thu cao
  + Xuất hiện trong nhiều đơn hàng
  + Mang lại dòng tiền ổn định hoặc giá trị cao

- Sản phẩm "Cần xem xét" có:
  + Doanh thu thấp
  + Tần suất xuất hiện trong đơn hàng thấp
  + Ít đóng góp vào tổng hiệu quả kinh doanh
--------------------------------------------
3. ĐỀ XUẤT CHIẾN LƯỢC KINH DOANH
A. Với sản phẩm "Ngôi sao": Cà Phê Sữa
Chiến lược:
- Tạo combo "Cà Phê Sữa + Bánh ngọt" giảm 10%
- Áp dụng khung giờ vàng: 7h - 9h sáng giảm 5%
=> Mục tiêu: tăng doanh thu trên mỗi khách hàng mà vẫn giữ được sản phẩm chủ lực.
--------------------------------------------
B. Với sản phẩm "Cần xem xét": Trà Chanh Gừng Mật Ong
Chiến lược:
1. Chạy chương trình dùng thử:
   - Mua 1 tặng 1 cho đơn đầu tiên trong 2 tuần.
2. Điều chỉnh công thức:
   - Giảm độ gắt của gừng
   - Tăng độ ngọt dễ uống cho phân khúc sinh viên.
3. Nếu sau 1 tháng vẫn không cải thiện:
   -> Cân nhắc loại khỏi thực đơn để tối ưu chi phí vận hành.
--------------------------------------------
KẾT LUẬN:
Việc kết hợp dữ liệu doanh thu + sản lượng + độ phổ biến giúp
xây dựng chiến lược kinh doanh dựa trên số liệu thực tế thay vì cảm tính.
====================================================
*/
