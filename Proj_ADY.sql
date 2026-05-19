CREATE TABLE footballData (
    sofifa_id INT PRIMARY KEY,
    player_url NVARCHAR(500),
    short_name NVARCHAR(255),
    long_name NVARCHAR(500),
    age INT,
    dob DATE,
    height_cm INT,
    weight_kg INT,
    nationality NVARCHAR(255),
    club_name NVARCHAR(255),
    league_name NVARCHAR(255),
    league_rank INT,
    overall INT,
    potential INT,
    value_eur INT,
    wage_eur INT,
    player_positions NVARCHAR(255),
    preferred_foot NVARCHAR(50),
    international_reputation INT,
    weak_foot INT,
    skill_moves INT,
    work_rate NVARCHAR(100),
    body_type NVARCHAR(255),
    real_face NVARCHAR(10),
    release_clause_eur INT,
    player_tags NVARCHAR(MAX),
    team_position NVARCHAR(50),
    team_jersey_number INT,
    loaned_from NVARCHAR(255),
    joined DATE,
    contract_valid_until INT,
    nation_position NVARCHAR(50),
    nation_jersey_number INT,

    -- Ch? s? chính
    pace INT,
    shooting INT,
    passing INT,
    dribbling INT,
    defending INT,
    physic INT,
    gk_diving INT,
    gk_handling INT,
    gk_kicking INT,
    gk_reflexes INT,
    gk_speed INT,
    gk_positioning INT,

    -- ??c ?i?m (traits) - d?ng v?n b?n
    player_traits NVARCHAR(MAX),

    -- Các ch? s? t?n công/k? n?ng
    attacking_crossing INT,
    attacking_finishing INT,
    attacking_heading_accuracy INT,
    attacking_short_passing INT,
    attacking_volleys INT,
    skill_dribbling INT,
    skill_curve INT,
    skill_fk_accuracy INT,
    skill_long_passing INT,
    skill_ball_control INT,
    movement_acceleration INT,
    movement_sprint_speed INT,
    movement_agility INT,
    movement_reactions INT,
    movement_balance INT,
    power_shot_power INT,
    power_jumping INT,
    power_stamina INT,
    power_strength INT,
    power_long_shots INT,
    mentality_aggression INT,
    mentality_interceptions INT,
    mentality_positioning INT,
    mentality_vision INT,
    mentality_penalties INT,
    mentality_composure INT,
    defending_marking INT,
    defending_standing_tackle INT,
    defending_sliding_tackle INT,

    -- Ch? s? th? môn
    --alkeeping_diving INT,
    --alkeeping_handling INT,
    --alkeeping_kicking INT,
    --alkeeping_positioning INT,
    --alkeeping_reflexes INT,

    -- Các c?t d?ng 'ls, st, rs,...' - ?? ? d?ng v?n b?n vì c?u trúc ph?c t?p
    ls NVARCHAR(50),
    st NVARCHAR(50),
    rs NVARCHAR(50),
    lw NVARCHAR(50),
    lf NVARCHAR(50),
    cf NVARCHAR(50),
    rf NVARCHAR(50),
    rw NVARCHAR(50),
    lam NVARCHAR(50),
    cam NVARCHAR(50),
    ram NVARCHAR(50),
    lm NVARCHAR(50),
    lcm NVARCHAR(50),
    cm NVARCHAR(50),
    rcm NVARCHAR(50),
    rm NVARCHAR(50),
    lwb NVARCHAR(50),
    ldm NVARCHAR(50),
    cdm NVARCHAR(50),
    rdm NVARCHAR(50),
    rwb NVARCHAR(50),
    lb NVARCHAR(50),
    lcb NVARCHAR(50),
    cb NVARCHAR(50),
    rcb NVARCHAR(50),
    rb NVARCHAR(50)
);


SELECT COUNT(*) AS SoLuongCauThu FROM footballData;
SELECT TOP 10 * FROM footballData;


--Visualize data
USE ProjADY;


-- =====================================================
-- I. TỔNG QUAN & SO SÁNH ĐƠN GIẢN
-- =====================================================

-- 1. Top 10 cầu thủ có chỉ số Overall cao nhất
PRINT '=== 1. TOP 10 CẦU THỦ OVERALL CAO NHẤT ===';
SELECT TOP 10
    long_name AS TenCauThu,
    overall AS ChiSoOverall,
    club_name AS CauLacBo,
    nationality AS QuocTich
FROM footballData
WHERE overall IS NOT NULL
ORDER BY overall DESC;


-- 2. Top 10 cầu thủ có giá trị (Value) lớn nhất
PRINT '=== 2. TOP 10 CẦU THỦ ĐẮT GIÁ NHẤT ===';
SELECT TOP 10
    long_name AS TenCauThu,
    FORMAT(value_eur / 1000000, 'N2') + ' M' AS GiaTri_TrieuEuro,
    wage_eur AS LuongTuan,
    overall AS ChiSoOverall,
    age AS Tuoi,
    club_name AS CauLacBo
FROM footballData
WHERE value_eur IS NOT NULL
ORDER BY value_eur DESC;


-- 2b. So sánh giá trị và lương
PRINT '=== 2b. SO SÁNH GIÁ TRỊ VÀ LƯƠNG ===';
SELECT TOP 10
    long_name AS TenCauThu,
    FORMAT(value_eur / 1000000, 'N2') + ' M' AS GiaTri,
    FORMAT(wage_eur / 1000, 'N0') + ' K' AS Luong,
    CAST(ROUND(value_eur * 1.0 / NULLIF(wage_eur, 0), 0) AS INT) AS SoNamLuongDeTra
FROM footballData
WHERE value_eur IS NOT NULL AND wage_eur > 0
ORDER BY value_eur DESC;


-- 3. Phân bố cầu thủ theo quốc gia
PRINT '=== 3. TOP 10 QUỐC GIA CÓ NHIỀU CẦU THỦ NHẤT ===';
SELECT TOP 10
    nationality AS QuocGia,
    COUNT(*) AS SoLuongCauThu,
    AVG(overall) AS OverallTrungBinh,
    MAX(overall) AS OverallCaoNhat
FROM footballData
WHERE nationality IS NOT NULL
GROUP BY nationality
ORDER BY SoLuongCauThu DESC;
--

-- 4. Phân bố cầu thủ theo giải đấu
PRINT '=== 4. TOP 10 GIẢI ĐẤU CÓ NHIỀU CẦU THỦ NHẤT ===';
SELECT TOP 10
    league_name AS GiaiDau,
    COUNT(*) AS SoLuongCauThu,
    AVG(overall) AS OverallTrungBinh,
    SUM(value_eur) / 1000000000 AS TongGiaTri_TyEuro
FROM footballData
WHERE league_name IS NOT NULL
GROUP BY league_name
ORDER BY SoLuongCauThu DESC;
--

-- 5. Thống kê chân thuận
PRINT '=== 5. THỐNG KÊ CHÂN THUẬN ===';
SELECT 
    preferred_foot AS ChanThuan,
    COUNT(*) AS SoLuong,
    CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() AS DECIMAL(5,2)) AS TyLePhanTram
FROM footballData
WHERE preferred_foot IS NOT NULL
GROUP BY preferred_foot
ORDER BY SoLuong DESC;
--

-- =====================================================
-- II. MỐI QUAN HỆ & XU HƯỚNG
-- =====================================================

-- 6. Tuổi tác và Chỉ số (Age vs Overall)
PRINT '=== 6. PHÂN TÍCH OVERALL THEO ĐỘ TUỔI ===';
SELECT 
    age AS Tuoi,
    COUNT(*) AS SoLuong,
    AVG(overall) AS OverallTrungBinh,
    MIN(overall) AS OverallThapNhat,
    MAX(overall) AS OverallCaoNhat
FROM footballData
WHERE age BETWEEN 16 AND 45 AND overall IS NOT NULL
GROUP BY age
ORDER BY age;
--

-- 6b. Dữ liệu cho scatter plot Age vs Overall
PRINT '=== 6b. DỮ LIỆU SCATTER PLOT TUỔI VS OVERALL ===';
SELECT TOP 200
    age AS Tuoi,
    overall AS ChiSo,
    long_name AS Ten,
    CASE 
        WHEN overall >= 85 THEN 'Sao sieu hang'
        WHEN overall >= 80 THEN 'Sao hang A'
        WHEN overall >= 75 THEN 'Cau thu tot'
        ELSE 'Cau thu trung binh'
    END AS PhanLoai
FROM footballData
WHERE age IS NOT NULL AND overall IS NOT NULL
ORDER BY overall DESC;
--

-- 7. Giá trị và Chỉ số theo độ tuổi
PRINT '=== 7. GIÁ TRỊ VS CHỈ SỐ THEO ĐỘ TUỔI ===';
SELECT TOP 200
    overall AS ChiSo,
    value_eur AS GiaTri,
    age AS Tuoi,
    long_name AS Ten,
    CASE 
        WHEN age <= 22 THEN 'Tre (<=22)'
        WHEN age <= 28 THEN 'Chin muoi (23-28)'
        WHEN age <= 33 THEN 'Kinh nghiem (29-33)'
        ELSE 'Gia (>=34)'
    END AS NhomTuoi
FROM footballData
WHERE overall >= 70 AND value_eur > 0
ORDER BY value_eur DESC;
--

-- 8. Chiều cao và Sức mạnh
PRINT '=== 8. CHIỀU CAO VS SỨC MẠNH ===';
SELECT TOP 200
    height_cm AS ChieuCao_cm,
    physic AS SucManh,
    weight_kg AS CanNang,
    long_name AS Ten,
    CASE 
        WHEN height_cm >= 190 THEN 'Rat cao'
        WHEN height_cm >= 185 THEN 'Cao'
        WHEN height_cm >= 175 THEN 'Trung binh'
        ELSE 'Thap'
    END AS PhanLoaiChieuCao
FROM footballData
WHERE height_cm IS NOT NULL AND physic IS NOT NULL
ORDER BY height_cm DESC;
--

-- =====================================================
-- III. SO SÁNH THEO NHÓM
-- =====================================================

-- 9. So sánh chỉ số trung bình theo vị trí
PRINT '=== 9. CHỈ SỐ TRUNG BÌNH THEO VỊ TRÍ ===';
WITH ViTri AS (
    SELECT 
        long_name,
        player_positions,
        pace, shooting, passing, dribbling, defending, physic,
        CASE 
            WHEN player_positions LIKE '%ST%' OR player_positions LIKE '%CF%' THEN 'Tien dao'
            WHEN player_positions LIKE '%LW%' OR player_positions LIKE '%RW%' OR player_positions LIKE '%LM%' OR player_positions LIKE '%RM%' THEN 'Chay canh'
            WHEN player_positions LIKE '%CAM%' OR player_positions LIKE '%CM%' THEN 'Tien ve trung tam'
            WHEN player_positions LIKE '%CDM%' THEN 'Tien ve phong ngu'
            WHEN player_positions LIKE '%CB%' THEN 'Trung ve'
            WHEN player_positions LIKE '%LB%' OR player_positions LIKE '%RB%' OR player_positions LIKE '%LWB%' OR player_positions LIKE '%RWB%' THEN 'Hau ve bien'
            WHEN player_positions LIKE '%GK%' THEN 'Thu mon'
            ELSE 'Khac'
        END AS NhomViTri
    FROM footballData
)
SELECT 
    NhomViTri,
    COUNT(*) AS SoLuong,
    AVG(pace) AS TocDo_TB,
    AVG(shooting) AS Sut_TB,
    AVG(passing) AS Chuyen_TB,
    AVG(dribbling) AS ReKet_TB,
    AVG(defending) AS PhongNgu_TB,
    AVG(physic) AS TheLuc_TB
FROM ViTri
WHERE NhomViTri != 'Khac'
GROUP BY NhomViTri
ORDER BY SoLuong DESC;
--

-- 10. "Chiếc giày vàng" - Top tiền đạo
PRINT '=== 10. TOP TIỀN ĐẠO CÓ KHẢ NĂNG GHI BÀN TỐT NHẤT ===';
SELECT TOP 20
    long_name AS TenCauThu,
    club_name AS CauLacBo,
    attacking_finishing AS DutDiem,
    power_shot_power AS LucSut,
    (attacking_finishing + power_shot_power) AS TongChiSoSut,
    overall AS Overall,
    player_positions AS ViTri
FROM footballData
WHERE (player_positions LIKE '%ST%' OR player_positions LIKE '%CF%')
    AND attacking_finishing IS NOT NULL
    AND power_shot_power IS NOT NULL
ORDER BY TongChiSoSut DESC;
--

-- =====================================================
-- IV. PHÂN TÍCH NÂNG CAO
-- =====================================================

-- 11. Top đặc điểm (traits) phổ biến nhất
PRINT '=== 11. TOP 10 ĐẶC ĐIỂM CẦU THỦ PHỔ BIẾN NHẤT ===';
IF EXISTS (SELECT * FROM sys.objects WHERE name = 'SplitTraits' AND type = 'TF')
    DROP FUNCTION SplitTraits;
--

CREATE FUNCTION SplitTraits(@traits NVARCHAR(MAX))
RETURNS TABLE
AS
RETURN
    SELECT LTRIM(RTRIM(value)) AS Trait
    FROM STRING_SPLIT(@traits, ',')
    WHERE value != '';
--

SELECT TOP 10
    t.Trait,
    COUNT(*) AS SoLanXuatHien
FROM footballData c
CROSS APPLY SplitTraits(c.player_traits) t
WHERE c.player_traits IS NOT NULL AND c.player_traits != ''
GROUP BY t.Trait
ORDER BY SoLanXuatHien DESC;
--

-- 12. Cầu thủ đa năng nhất (nhiều vị trí)
PRINT '=== 12. TOP 15 CẦU THỦ ĐA NĂNG NHẤT ===';
SELECT TOP 15
    long_name AS TenCauThu,
    player_positions AS CacViTri,
    LEN(player_positions) - LEN(REPLACE(player_positions, ',', '')) + 1 AS SoViTri,
    overall AS ChiSoOverall,
    club_name AS CauLacBo
FROM footballData
WHERE player_positions IS NOT NULL
ORDER BY SoViTri DESC, overall DESC;
--

-- =====================================================
-- V. BẢNG TỔNG HỢP CHO DASHBOARD
-- =====================================================

PRINT '=== V. TẠO VIEW TỔNG HỢP CHO DASHBOARD ===';
IF EXISTS (SELECT * FROM sys.views WHERE name = 'vw_Dashboard_FIFA')
    DROP VIEW vw_Dashboard_FIFA;
--

CREATE VIEW vw_Dashboard_FIFA AS
SELECT 
    sofifa_id,
    long_name AS TenCauThu,
    short_name AS TenVietTat,
    age AS Tuoi,
    nationality AS QuocTich,
    club_name AS CauLacBo,
    league_name AS GiaiDau,
    overall AS Overall,
    potential AS TiemNang,
    value_eur AS GiaTri,
    wage_eur AS Luong,
    player_positions AS ViTri,
    preferred_foot AS ChanThuan,
    pace AS TocDo,
    shooting AS Sut,
    passing AS Chuyen,
    dribbling AS ReKet,
    defending AS PhongNgu,
    physic AS TheLuc,
    CASE 
        WHEN age <= 22 AND potential - overall >= 5 THEN 'Sao mai tiem nang'
        WHEN overall >= 85 THEN 'N--i sao'
        WHEN overall >= 80 THEN 'Cau thu chinh'
        ELSE 'Cau thu binh thuong'
    END AS PhanLoai
FROM footballData;
--

-- Kiểm tra view
PRINT '=== KIỂM TRA VIEW (10 DÒNG ĐẦU) ===';
SELECT TOP 10 * FROM vw_Dashboard_FIFA;
--

-- =====================================================
-- VI. THỐNG KÊ NHANH
-- =====================================================

PRINT '=== VI. THỐNG KÊ TỔNG QUAN ===';
SELECT 
    COUNT(*) AS TongSoCauThu,
    AVG(overall) AS OverallTrungBinh,
    MIN(overall) AS OverallThapNhat,
    MAX(overall) AS OverallCaoNhat,
    AVG(age) AS TuoiTrungBinh,
    SUM(value_eur) / 1000000000 AS TongGiaTri_TyEuro,
    AVG(value_eur) AS GiaTriTrungBinh
FROM footballData;
--

PRINT '=== PHÂN TÍCH HOÀN TẤT ===';


