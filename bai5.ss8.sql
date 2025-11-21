-- Tạo bảng Sales

CREATE TABLE Sales (

    transaction_id INT,

    transaction_date DATE,

    customer_id INT,

    total_amount DECIMAL(10, 2)

);

 

-- Chèn dữ liệu mẫu

INSERT INTO Sales (transaction_id, transaction_date, customer_id, total_amount) VALUES
(101, '2023-10-02', 21, 75000.00),
(102, '2023-10-02', 35, 120000.00),
(103, '2023-10-03', 42, 350000.00),
(104, '2023-10-05', 21, 55000.00),
(105, '2023-10-07', 50, 210000.00),
(106, '2023-10-10', 35, 85000.00),
(107, '2023-10-11', 61, 450000.00),
(108, '2023-10-15', 21, 150000.00),
(109, '2023-10-18', 73, 95000.00),
(110, '2023-10-20', 42, 25000.00),
(111, '2023-10-22', 50, 320000.00),
(112, '2023-10-25', 21, 110000.00),
(113, '2023-10-27', 88, 180000.00),
(114, '2023-10-29', 35, 65000.00),
(115, '2023-10-30', 91, 295000.00);

SELECT 
    SUM(total_amount) AS Tong_Doanh_Thu
FROM Sales;
SELECT 
    COUNT(transaction_id) AS Tong_So_Giao_Dich
FROM Sales;
SELECT 
    AVG(total_amount) AS Gia_Tri_Giao_Dich_Trung_Binh
FROM Sales;
SELECT 
    MAX(total_amount) AS Gia_Tri_Cao_Nhat,
    MIN(total_amount) AS Gia_Tri_Thap_Nhat
FROM Sales;
SELECT 
    MIN(transaction_date) AS Ngay_Giao_Dich_Dau_Tien,
    MAX(transaction_date) AS Ngay_Giao_Dich_Cuoi_Cung
FROM Sales;
