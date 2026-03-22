-- QuanLyTroSV Database - Full Schema with 10 Sample Records
USE master;
GO
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'QuanLyTroSV_DB')
    DROP DATABASE QuanLyTroSV_DB;
GO
CREATE DATABASE QuanLyTroSV_DB;
GO
USE QuanLyTroSV_DB;
GO

-- Users
CREATE TABLE Users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(50) NOT NULL,
    role VARCHAR(20) NOT NULL
);

INSERT INTO Users (username, password, role) VALUES 
('admin', '123', 'ADMIN'),
('chutro', '123', 'LANDLORD'),
('sinhvien', '123', 'STUDENT'),
('sinhvien2', '123', 'STUDENT'),
('sinhvien3', '123', 'STUDENT');

-- UserInfo
CREATE TABLE UserInfo (
    id INT PRIMARY KEY IDENTITY,
    userId INT,
    fullName NVARCHAR(100),
    phone NVARCHAR(20),
    email NVARCHAR(100),
    address NVARCHAR(255),
    FOREIGN KEY (userId) REFERENCES Users(id)
);

INSERT INTO UserInfo(userId, fullName, phone, email, address)
VALUES 
(1, N'Nguyễn Văn Thịnh', '0123456789', 'thinh@gmail.com', N'Hà Nội'),
(2, N'Trần Thị Linh', '0123456788', 'linh@gmail.com', N'Hà Nội'),
(3, N'Lê Văn Hùng', '0123456787', 'hung@gmail.com', N'Hà Nội'),
(4, N'Phạm Minh Tuấn', '0987654321', 'tuan@gmail.com', N'Hồ Chí Minh'),
(5, N'Hoàng Thu Hà', '0987654322', 'ha@gmail.com', N'Đà Nẵng');

-- Rooms (description: Phòng đơn, Phòng đôi, Phòng ba)
CREATE TABLE Rooms (
    id INT PRIMARY KEY IDENTITY,
    roomNumber NVARCHAR(20),
    price FLOAT,
    status NVARCHAR(20) CHECK (status IN (N'Chưa thuê', N'Đã thuê')), 
    description NVARCHAR(255) CHECK (description IN (N'Phòng đơn', N'Phòng đôi', N'Phòng ba'))
);

INSERT INTO Rooms (roomNumber, price, status, description)
VALUES 
('A101', 1500000, N'Chưa thuê', N'Phòng đơn'),
('A102', 2000000, N'Đã thuê', N'Phòng đôi'),
('A103', 1800000, N'Chưa thuê', N'Phòng đơn'),
('B201', 2500000, N'Đã thuê', N'Phòng đôi'),
('B202', 2200000, N'Đã thuê', N'Phòng đôi'),
('B203', 3000000, N'Chưa thuê', N'Phòng ba'),
('C301', 1600000, N'Đã thuê', N'Phòng đơn'),
('C302', 1900000, N'Chưa thuê', N'Phòng đơn'),
('C303', 2300000, N'Đã thuê', N'Phòng đôi'),
('D401', 2800000, N'Chưa thuê', N'Phòng đôi');

-- Services (Wifi, Gửi xe, ...)
CREATE TABLE Services (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    price FLOAT NOT NULL,
    unit NVARCHAR(20) DEFAULT N'Tháng',
    description NVARCHAR(255)
);

INSERT INTO Services (name, price, unit, description)
VALUES 
(N'Wifi', 50000, N'Tháng', N'Mạng wifi tốc độ cao'),
(N'Gửi xe máy', 100000, N'Tháng', N'Chỗ để xe máy có mái che'),
(N'Gửi xe đạp', 30000, N'Tháng', N'Khu vực gửi xe đạp'),
(N'Giặt ủi', 20000, N'Tháng', N'Dịch vụ giặt ủi chung'),
(N'Dọn phòng', 100000, N'Tháng', N'Dọn vệ sinh phòng 2 lần/tuần'),
(N'Nước uống', 50000, N'Tháng', N'Bình nước 20L miễn phí'),
(N'Truyền hình', 70000, N'Tháng', N'Truyền hình cáp'),
(N'Bảo vệ 24/7', 0, N'Tháng', N'Bảo vệ an ninh 24/7 (tính vào giá phòng)'),
(N'Internet cáp quang', 80000, N'Tháng', N'Internet tốc độ 100Mbps'),
(N'Phòng gym', 150000, N'Tháng', N'Sử dụng phòng gym chung');

-- RoomService: Gán dịch vụ cho phòng
CREATE TABLE RoomService (
    id INT IDENTITY(1,1) PRIMARY KEY,
    roomId INT NOT NULL,
    serviceId INT NOT NULL,
    FOREIGN KEY (roomId) REFERENCES Rooms(id) ON DELETE CASCADE,
    FOREIGN KEY (serviceId) REFERENCES Services(id) ON DELETE CASCADE,
    UNIQUE(roomId, serviceId)
);

INSERT INTO RoomService (roomId, serviceId)
VALUES 
(1, 1), (1, 2), (1, 3),
(2, 1), (2, 2), (2, 4), (2, 5),
(3, 1), (3, 2),
(4, 1), (4, 2), (4, 4), (4, 5), (4, 6),
(5, 1), (5, 2), (5, 4),
(6, 1), (6, 2), (6, 4), (6, 5), (6, 6), (6, 7),
(7, 1), (7, 3),
(8, 1), (8, 2),
(9, 1), (9, 2), (9, 4),
(10, 1), (10, 2), (10, 4), (10, 5), (10, 6), (10, 9);

-- Contracts
CREATE TABLE Contracts (
    id INT PRIMARY KEY IDENTITY,
    userId INT NOT NULL,
    roomId INT NOT NULL,
    startDate DATE NOT NULL,
    endDate DATE NOT NULL,
    status NVARCHAR(50) NOT NULL CHECK (status IN (N'Còn hạn', N'Hết hạn', N'Hủy hợp đồng')),
    createdAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (userId) REFERENCES Users(id),
    FOREIGN KEY (roomId) REFERENCES Rooms(id)
);

INSERT INTO Contracts (userId, roomId, startDate, endDate, status)
VALUES 
(3, 2, '2026-01-01', '2026-12-31', N'Còn hạn'),
(4, 4, '2026-02-01', '2026-07-31', N'Còn hạn'),
(5, 5, '2026-01-15', '2026-06-15', N'Còn hạn'),
(3, 7, '2025-09-01', '2026-02-28', N'Còn hạn'),
(4, 9, '2026-03-01', '2026-08-31', N'Còn hạn'),
(5, 1, '2025-08-01', '2026-01-31', N'Hết hạn'),
(3, 3, '2025-06-01', '2025-12-31', N'Hết hạn'),
(4, 6, '2026-02-15', '2026-08-15', N'Còn hạn'),
(5, 8, '2026-01-01', '2026-06-30', N'Còn hạn'),
(3, 10, '2025-10-01', '2026-03-31', N'Còn hạn');

-- Electricity & Water meter readings
CREATE TABLE ElectricityWater (
    id INT IDENTITY(1,1) PRIMARY KEY,
    roomId INT NOT NULL,
    month INT NOT NULL,
    year INT NOT NULL,
    electricPrevious INT DEFAULT 0,
    electricCurrent INT NOT NULL,
    waterPrevious INT DEFAULT 0,
    waterCurrent INT NOT NULL,
    electricUnitPrice FLOAT DEFAULT 3500,
    waterUnitPrice FLOAT DEFAULT 20000,
    createdAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (roomId) REFERENCES Rooms(id),
    UNIQUE(roomId, month, year)
);

INSERT INTO ElectricityWater (roomId, month, year, electricPrevious, electricCurrent, waterPrevious, waterCurrent, electricUnitPrice, waterUnitPrice)
VALUES 
(2, 1, 2026, 100, 150, 10, 15, 3500, 20000),
(2, 2, 2026, 150, 210, 15, 22, 3500, 20000),
(4, 1, 2026, 200, 280, 20, 28, 3500, 20000),
(4, 2, 2026, 280, 350, 28, 35, 3500, 20000),
(5, 1, 2026, 50, 95, 5, 12, 3500, 20000),
(7, 1, 2026, 120, 165, 12, 18, 3500, 20000),
(7, 2, 2026, 165, 220, 18, 24, 3500, 20000),
(9, 1, 2026, 80, 130, 8, 14, 3500, 20000),
(10, 1, 2026, 150, 205, 15, 20, 3500, 20000),
(1, 3, 2026, 0, 80, 0, 8, 3500, 20000);

-- Payment (contractId links to Contracts.id, paymentType: Tiền trọ, Tiền điện nước, Tiền dịch vụ)
CREATE TABLE Payment (
    id INT IDENTITY(1,1) PRIMARY KEY,
    contractId INT NULL,
    contract_id VARCHAR(50) NULL,
    amount FLOAT NOT NULL,
    payment_date DATE NOT NULL,
    status NVARCHAR(20) NULL,
    paymentType NVARCHAR(50) DEFAULT N'Tiền trọ',
    description NVARCHAR(255) NULL,
    FOREIGN KEY (contractId) REFERENCES Contracts(id) ON DELETE SET NULL
);

INSERT INTO Payment (contractId, contract_id, amount, payment_date, status, paymentType)
VALUES 
(1, '1', 2050000, '2026-01-05', N'Đã thu', N'Tiền trọ'),
(1, '1', 350000, '2026-01-10', N'Đã thu', N'Tiền điện nước'),
(2, '2', 2650000, '2026-02-05', N'Đã thu', N'Tiền trọ'),
(3, '3', 2320000, '2026-01-20', N'Đã thu', N'Tiền trọ'),
(4, '4', 1685000, '2026-01-08', N'Đã thu', N'Tiền trọ'),
(5, '5', 2380000, '2026-03-01', N'Đã thu', N'Tiền trọ'),
(6, '6', 1500000, '2025-08-05', N'Đã thu', N'Tiền trọ'),
(7, '7', 1800000, '2025-06-10', N'Đã thu', N'Tiền trọ'),
(8, '8', 3150000, '2026-02-20', N'Chưa thu', N'Tiền trọ'),
(9, '9', 1990000, '2026-01-03', N'Đã thu', N'Tiền trọ'),
(10, '10', 2880000, '2025-10-05', N'Đã thu', N'Tiền trọ');

-- Notifications
CREATE TABLE Notifications (
    id INT IDENTITY(1,1) PRIMARY KEY,
    title NVARCHAR(200) NOT NULL,
    content NVARCHAR(MAX),
    userId INT NULL,
    createdAt DATETIME DEFAULT GETDATE(),
    isRead BIT DEFAULT 0,
    FOREIGN KEY (userId) REFERENCES Users(id) ON DELETE CASCADE
);

INSERT INTO Notifications (title, content, userId)
VALUES 
(N'Thông báo tăng giá điện', N'Từ tháng 4/2026, giá điện sẽ điều chỉnh theo quy định mới. Vui lòng theo dõi hóa đơn.', NULL),
(N'Bảo trì hệ thống nước', N'Ngày 25/3/2026 sẽ bảo trì hệ thống nước từ 8h-12h. Xin lỗi vì sự bất tiện.', NULL),
(N'Hóa đơn tháng 3', N'Hóa đơn tháng 3 đã được gửi. Vui lòng thanh toán trước ngày 10/4.', 3),
(N'Nhắc nhở gia hạn hợp đồng', N'Hợp đồng của bạn sắp hết hạn. Vui lòng liên hệ quản lý để gia hạn.', 4),
(N'Cập nhật wifi', N'Hệ thống wifi đã được nâng cấp. Mật khẩu mới: dorm2026', NULL),
(N'Lịch thu tiền', N'Ngày thu tiền tháng 4: 5-10/4/2026. Vui lòng chuẩn bị.', NULL),
(N'Khuyến mãi tháng 4', N'Đóng tiền trước ngày 5 được giảm 2% phí dịch vụ.', NULL),
(N'Thông báo bảo vệ', N'Khu vực để xe đã lắp camera. Giữ gìn tài sản cá nhân.', NULL),
(N'Nhắc nhở', N'Vui lòng đóng cửa cẩn thận khi ra ngoài.', 5),
(N'Cảm ơn', N'Cảm ơn bạn đã sử dụng dịch vụ. Chúc bạn học tập tốt!', NULL);

-- Feedback / Complaints / Support
CREATE TABLE Feedback (
    id INT IDENTITY(1,1) PRIMARY KEY,
    userId INT NOT NULL,
    contractId INT NULL,
    type NVARCHAR(50) NOT NULL CHECK (type IN (N'Phản hồi', N'Khiếu nại', N'Hỗ trợ')),
    subject NVARCHAR(200),
    content NVARCHAR(MAX) NOT NULL,
    status NVARCHAR(50) DEFAULT N'Chờ xử lý' CHECK (status IN (N'Chờ xử lý', N'Đang xử lý', N'Đã xử lý')),
    createdAt DATETIME DEFAULT GETDATE(),
    response NVARCHAR(MAX) NULL,
    respondedAt DATETIME NULL,
    FOREIGN KEY (userId) REFERENCES Users(id),
    FOREIGN KEY (contractId) REFERENCES Contracts(id) ON DELETE SET NULL
);

INSERT INTO Feedback (userId, contractId, type, subject, content, status)
VALUES 
(3, 1, N'Hỗ trợ', N'Wifi chập chờn', N'Wifi phòng A102 thường xuyên mất kết nối vào buổi tối. Mong được hỗ trợ kiểm tra.', N'Đã xử lý'),
(4, 2, N'Khiếu nại', N'Nước chảy yếu', N'Nước trong phòng chảy rất yếu, ảnh hưởng sinh hoạt. Cần sửa gấp.', N'Đang xử lý'),
(5, 3, N'Phản hồi', N'Dịch vụ tốt', N'Dịch vụ giặt ủi rất tiện, nhân viên thân thiện. Cảm ơn!', N'Đã xử lý'),
(3, 4, N'Hỗ trợ', N'Đăng ký thêm dịch vụ', N'Tôi muốn đăng ký thêm dịch vụ gym cho phòng. Hướng dẫn giúp tôi.', N'Chờ xử lý'),
(4, NULL, N'Khiếu nại', N'Tiếng ồn hàng xóm', N'Hàng xóm phòng bên cạnh thường xuyên mở nhạc to sau 22h.', N'Chờ xử lý'),
(5, 5, N'Phản hồi', N'Góp ý cải thiện', N'Đề xuất thêm tủ lạnh mini cho phòng. Sẵn sàng trả thêm phí.', N'Chờ xử lý'),
(3, 7, N'Hỗ trợ', N'Quên mật khẩu wifi', N'Tôi quên mật khẩu wifi. Gửi lại giúp qua email.', N'Đã xử lý'),
(4, 8, N'Khiếu nại', N'Vệ sinh khu chung', N'Khu vệ sinh chung chưa được dọn sạch sẽ.', N'Đang xử lý'),
(5, 9, N'Hỗ trợ', N'Hướng dẫn thanh toán', N'Tôi muốn thanh toán qua chuyển khoản. Cho tôi số tài khoản.', N'Đã xử lý'),
(3, 10, N'Phản hồi', N'Gửi xe tiện lợi', N'Khu gửi xe có mái che rất tiện. Cảm ơn!', N'Đã xử lý');
