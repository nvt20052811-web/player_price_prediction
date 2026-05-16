# ⚽ Dự Án: Dự Đoán Giá Chuyển Nhượng Cầu Thủ (Football Player Value Prediction)

## 📌 Tổng quan dự án (Project Overview)
Dự án này được xây dựng nhằm mục đích phân tích dữ liệu và dự đoán giá trị chuyển nhượng của hàng trăm cầu thủ bóng đá dựa trên các chỉ số phong độ, độ tuổi, vị trí và câu lạc bộ. Dự án kết hợp giữa **SQL** để quản lý, truy vấn dữ liệu và **Python** để xử lý, xây dựng mô hình dự đoán.

## 🛠 Công cụ & Công nghệ sử dụng (Tech Stack)
* **Ngôn ngữ:** Python, SQL
* **Thư viện Python:** Pandas, NumPy, Scikit-learn, Matplotlib, Seaborn , Numpy, 
* **Hệ quản trị CSDL:** SQL Server (SSMS) / SQLite / MySQL *(Chọn hệ quản trị bạn dùng)*
* **Môi trường:** VS Code / Jupyter Notebook

## 📊 Quy trình thực hiện (Workflow)
1. **Thu thập & Lưu trữ:** Nạp dữ liệu từ file CSV gốc vào cơ sở dữ liệu SQL.
2. **Trích xuất dữ liệu (SQL):** Sử dụng các câu lệnh truy vấn (JOIN, GROUP BY, WHERE...) để lọc, làm sạch và chuẩn bị bảng dữ liệu tối ưu nhất cho việc huấn luyện mô hình.
3. **Phân tích dữ liệu (EDA):** Dùng Python để khám phá mối quan hệ giữa các biến (ví dụ: tuổi tác ảnh hưởng thế nào đến giá cầu thủ).
4. **Huấn luyện mô hình (Machine Learning):** Sử dụng các thuật toán (như *Linear Regression, Random Forest, LightGBM...*) để dự đoán giá.
5. **Đánh giá:** Đo lường độ chính xác của mô hình.

## 🚀 Kết quả đạt được (Key Results)
* Xây dựng thành công mô hình dự đoán giá trị cầu thủ với độ chính xác tương đối tốt.
* Tìm ra các yếu tố ảnh hưởng lớn nhất đến giá trị cầu thủ (Ví dụ: Số bàn thắng, Số kiến tạo, Độ tuổi...).