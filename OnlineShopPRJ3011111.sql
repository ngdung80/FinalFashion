CREATE DATABASE FashionDB1;

--USE PRJ;

--DROP TABLE IF EXISTS [dbo].[OrderDetails];

--DROP TABLE IF EXISTS [dbo].[Orders];

--DROP TABLE IF EXISTS [dbo].[Image];

--DROP TABLE IF EXISTS [dbo].[Product];

--DROP TABLE IF EXISTS [dbo].[Size];

--DROP TABLE IF EXISTS [dbo].[Brand];

--DROP TABLE IF EXISTS [dbo].[Category];

--DROP TABLE IF EXISTS [dbo].[User];

--DROP TABLE IF EXISTS [dbo].[Role];

CREATE TABLE [dbo].[Role] (
    [RoleID] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,        
    [RoleName] NVARCHAR(100) NOT NULL UNIQUE                      
);

CREATE TABLE [dbo].[User] (
    [UserID] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,     
    [UserName] NVARCHAR(50) NOT NULL,
    [Gender] NVARCHAR(15) CHECK (Gender IN ('Male', 'Female')) NOT NULL,
    [Email] NVARCHAR(50) NOT NULL UNIQUE,
    [Password] NVARCHAR(255) NOT NULL,
    [RoleID] INT NOT NULL, 
    FOREIGN KEY (RoleID) REFERENCES [dbo].[Role](RoleID)
);

CREATE TABLE [dbo].[Brand] (
    [BrandID] INT IDENTITY(1,1) NOT NULL,        
    [BrandName] NVARCHAR(100) NOT NULL, 
	[BrandImage] NVARCHAR(100) NULL,
    PRIMARY KEY ([BrandID])                      
);

CREATE TABLE [dbo].[Category] (
    [CategoryID] INT IDENTITY(1,1) NOT NULL,        
    [CategoryName] NVARCHAR(100) NOT NULL, 
	[CategoryImage] NVARCHAR(100) NULL,
    PRIMARY KEY ([CategoryID])                     
);
CREATE TABLE [dbo].[Size] (
    [SizeID] INT IDENTITY(1,1) NOT NULL,
	[SizeName] NVARCHAR(20) NOT NULL,
	PRIMARY KEY ([SizeID]),
);

CREATE TABLE [dbo].[Product] (
    [ProductID] INT IDENTITY(1,1) NOT NULL,        
    [Title] NVARCHAR(255) NOT NULL,                 
    [Description] NVARCHAR(MAX) NULL,             
    [Thumbnail] NVARCHAR(255) NULL,              
    [Price] DECIMAL(18, 0) NOT NULL,
    [Quantity] INT NOT NULL,
    [SizeID] INT NOT NULL,
    [BrandID] INT NOT NULL,   
    [CategoryID]  INT NOT NULL,
    [ProductGender] NVARCHAR(20) CHECK (ProductGender IN ('Male', 'Female')) NOT NULL,
    PRIMARY KEY ([ProductID]),                      
    FOREIGN KEY ([BrandID]) REFERENCES [dbo].[Brand](BrandID),
	FOREIGN KEY ([CategoryID]) REFERENCES [dbo].[Category](CategoryID),
	FOREIGN KEY ([SizeID]) REFERENCES [dbo].[Size](SizeID),
);

CREATE TABLE [dbo].[Image] (
    [ImageID] INT IDENTITY(1,1) NOT NULL,        
    [ProductID] INT NOT NULL, 
    [ImageMore] NVARCHAR(100) NOT NULL,
    PRIMARY KEY ([ImageID]),                      
    FOREIGN KEY ([ProductID]) REFERENCES [dbo].[Product](ProductID)  
);

CREATE TABLE [dbo].[Orders] (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,  
    OrderStatus VARCHAR(50) DEFAULT 'Pending' NOT NULL, 
    SaleNotes VARCHAR(50) DEFAULT NULL,
	OrderDate DATETIME2(0) DEFAULT GETDATE(), 
    FOREIGN KEY (UserID) REFERENCES [dbo].[User](UserID)
);

CREATE TABLE [dbo].[OrderDetails] (
    OrderDetailID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NOT NULL,  
    ProductID INT NOT NULL,  
    Title NVARCHAR(200) NOT NULL,   
    Quantity INT NOT NULL,                      
    Thumbnail NVARCHAR(255) NULL,              
    Price DECIMAL(18, 2) NOT NULL,             
    FOREIGN KEY (OrderID) REFERENCES [dbo].[Orders](OrderID),
    FOREIGN KEY (ProductID) REFERENCES [dbo].[Product](ProductID)
);

GO

SET IDENTITY_INSERT [dbo].[Role] ON; 
INSERT [dbo].[Role] ([RoleID], [RoleName]) VALUES (1, N'Admin');
INSERT [dbo].[Role] ([RoleID], [RoleName]) VALUES (2, N'Marketing');
INSERT [dbo].[Role] ([RoleID], [RoleName]) VALUES (3, N'Sales');
INSERT [dbo].[Role] ([RoleID], [RoleName]) VALUES (4, N'Customer');
SET IDENTITY_INSERT [dbo].[Role] OFF;
GO

INSERT INTO [dbo].[User] ([UserName], [Gender], [Email], [Password], [RoleID]) VALUES
(N'Tuan Anh', N'Male', N'nguyentuananh@gmail.com', N'tuananh', 1), 
(N'Duc Dung', N'Male', N'nguyenducdung@gmail.com', N'ducdung', 1), 
(N'Xuan Cong', N'Male', N'doxuancong@gmail.com', N'xuancong', 1), 
(N'hoho', N'Male', N'hohoho@example.com', N'123', 4), 
(N'hiiii', N'Female', N'hihih@example.com', N'123', 4); 
GO


INSERT INTO [dbo].[Category] ([CategoryName]) VALUES 
(N'Áo khoác'), 
(N'Áo thun'), 
(N'Sweater'), 
(N'Váy-Đầm'),
(N'Quần');
GO

INSERT INTO [dbo].[Brand] ([BrandName]) VALUES 
(N'Gucci'), 
(N'H&M'), 
(N'Ralph Lauren'), 
(N'Uniqlo'), 
(N'Zara');
GO

INSERT INTO [dbo].[Size] ([SizeName]) VALUES 
('S'),('M'),('L'),('XL'),('XXL');

GO


INSERT INTO [dbo].[Product] ([Title], [Description], [Thumbnail], [Price], [Quantity], [SizeID], [BrandID], [CategoryID], [ProductGender]) VALUES
--áo khoác

(N'Áo khoác dạ tweet', N'Đầm vải tweed có cổ tròn và tay áo rộng, được tô điểm bằng những đường viền tương phản ở viền và túi, cùng một chiếc túi cúc đôi màu vàng.', N'Images/Female/aokhoacGC1.jpg', 850, 120, 2, 1, 1, N'Female'), -- Size S

(N'Áo khoác nữ tay dài Gucci GG Ivory and Beige Canvas Bomber Jacket', N'Chất da thật phối canvas đẳng cấp', N'Images/Female/aokhoacGC2.jpg',  190, 356, 3, 1, 1, N'Female'), -- Size M

(N'Áo khoác măng tô dài H&M', N'Chất dạ lì tay dài có đai lưng', N'Images/Female/aokhoacHM_1.jpg', 102, 342, 5, 2, 1, N'Female'), -- Size M

(N'Áo khoác lông cừu trắng', N'Chất nỉ kết hợp lông cừu dày dặn màu trắng kem nhẹ nhàng thanh lịch', N'Images/Female/aokhoacHM_2.jpg', 578, 342, 4, 2, 1, N'Female'), -- Size M

(N'Áo khoác da phối cổ lông', N'Chất da lì kết hợp lông cừu phần cổ áo', N'Images/Female/aokhoacHM_3.jpg', 167, 132, 3, 2, 1, N'Female'), -- Size M

(N'Áo khoác phao dáng boxies', N'Chât phao mịn lì cotton, bên trong lót nỉ tay dài', N'Images/Female/aokhoacHM_4.jpg', 751, 121, 4, 2, 1, N'Female'), -- Size M

(N'Áo Khoác Nữ Tay Dài Quilted Jacket', N'Mặt Trước: 100% Nylon/ Lớp Độn: 100% Polyeste/ Mặt Sau: 100% Nylon', N'Images/Female/aokhoacRL_1.jpg', 243, 162, 3, 3, 1, N'Female'), -- Size M

(N'Áo Khoác Nữ Tay Dài Knit Double-Breasted Blazer', N'Chất liệu: 52% Polyester 37% Viscose 8% Wool 3% Elastane ', N'Images/Female/aokhoacRL_2.jpg', 421, 134, 5, 3, 1, N'Female'), -- Size M

(N'Áo khoác nữ Ralph Lauren xanh navy, đính khuy móc kim loại', N'Chất liệu: 100% cotton, Lớp lót trong: 100% cotton', N'Images/Female/aokhoacRL_3.jpg', 341, 123, 1, 3, 1, N'Female'), -- Size M

(N'Áo khoác lông vũ nữ Uniqlo', N'Lông vũ tự nhiên với tỉ lệ kết hợp hoàn hảo giữa 90% Lông Nhung (Down) và 10% Lông thân (Feather).', N'Images/Female/aokhoacUNI_1.jpg', 561, 213, 4, 4, 1, N'Female'), -- Size M

(N'PUFFTECH Relaxed Jacket', N'Lớp đệm hiệu suất cao được làm bằng sợi rỗng giữ không khí để giữ ấm hơn', N'Images/Female/aokhoacUNI_2.jpg', 451, 93, 3, 4, 1, N'Female'), -- Size M

(N'Áo khoác phao dáng dài', N'Nhẹ nhưng giữ ấm ưu việt: do được làm từ chất liệu giữ ấm cao cấp', N'Images/Female/aokhoacUNI_3.jpg', 761, 100, 2, 4, 1, N'Female'), -- Size M

(N'Áo khoác dài có 2 mặt', N'Áo khoác có ve áo và tay áo dài. Túi phía trước, lớp lót giả lông tương phản và nắp cài khuy ở phía trước', N'Images/Female/aokhoacZARA_1.jpg', 512, 97, 1, 5, 1, N'Female'), -- Size M

(N'Áo Khoác Dáng Rộng Mềm Mại Thời Trang Mùa Thu', N'Áo khoác dáng bomber', N'Images/Female/aokhoacZARA_2.jpg', 514, 87, 3, 5, 1, N'Female'), -- Size M

(N'Áo khoác lông thú giả cho nữ', N'Chất liệu lông polime', N'Images/Female/aokhoacZARA_3.jpg', 312, 100, 2, 5, 1, N'Female'), -- Size M



-- áo phông
(N'Áo Phông Unisex Gucci Strawberry Cotton TShirt Màu Be', N'100% Cotton thoáng mát mềm mịn, không xù, không phai màu', N'Images/Female/aophongGC_1.jpg', 342, 342, 1, 1, 2, N'Female'), -- Size M

(N'Áo thun in logo màu trắng', N'100% Cotton thoáng mát mềm mịn, không xù, không phai màu', N'Images/Female/aophongGC_2.jpg', 516, 781, 5, 1, 2, N'Female'),

(N'Áo phông in logo Gucci Kids x Peter Rabbit', N'100% Cotton thoáng mát mềm mịn, không xù, không phai màu', N'Images/Female/aophongGC_3.jpg', 871, 512, 3, 1, 2, N'Female'),

(N'Áo phông in SLOGAN', N'100% Cotton thoáng mát mềm mịn, không xù, không phai màu', N'Images/Female/aophongHM_1.jpg', 451, 913, 2, 2, 2, N'Female'),

(N'Áo thun gân nổi xuyên thấu', N'Áo thun ôm, ngắn bằng jersey gân nổi, xuyên thấu có cổ thuyền mảnh mai và vạt ngang.', N'Images/Female/aophongHM_2.jpg', 234, 873, 1, 2, 2, N'Female'),

(N'Áo tay hến may nhún vải', N'Áo ôm ngắn bằng viscose jersey gân nổi có cổ thuyền tinh tế và tay hến. Đường may nhún vải hai bên tạo hiệu ứng rút vải.', N'Images/Female/aophongHM_3.jpg', 541, 671, 5, 2, 2, N'Female'),

(N'Áo hở một bên vai', N'Áo thun bó sát ngắn làm từ vải thun hai lớp có đường viền cổ bất đối xứng, đường may nhún ở một bên vai và một bên vai trần có tay áo ngắn, xoắn.', N'Images/Female/aophongHM_4.jpg', 235, 609, 3, 2, 2, N'Female'),

(N'Áo thun cotton có logo gấu Polo', N'Vừa vặn, nhắm vào hông.', N'Images/Female/aophongRL_1.jpg', 651, 456, 1, 3, 2, N'Female'),

(N'Áo Thun Nữ Tay Ngắn Logo Jersey Tee', N'57% Cotton 43% Viscose', N'Images/Female/aophongRL_2.jpg', 356, 900, 2, 3, 2, N'Female'),

(N'Áo Len Nữ Tay Ngắn Cable Wool-Cashmere Short-Sleeve Sweater', N'80% Len 20% Cashmere', N'Images/Female/aophongRL_3.jpg', 165, 872, 3, 3, 2, N'Female'),

(N'Áo phông polo Uniqlo nữ', N'Chất liệu vải cao cấp, thấm hút mồ hôi rất hiệu quả, công nghệ Dry nhanh khô độc quyền của Uniqlo', N'Images/Female/aophongUNI_1.jpg', 345, 672, 5, 4, 2, N'Female'),

(N'Áo phông trơn nữ cổ tròn Uniqlo U Crew Neck T-Shirt', N'100% chất liệu cotton, dày dặn, mịn êm', N'Images/Female/aophongUNI_2.jpg', 342, 897, 1, 4, 2, N'Female'),

(N'Áo phông hở tay ngán kẻ rộng', N'100% bông canh tác hữu cơ đạt tiêu chuẩn OCS', N'Images/Female/aophongZARA_1.jpg', 542, 657, 3, 5, 2, N'Female'),

(N'Áo phông in chữ', N'Áo phông cổ tròn, cộc tay. In họa tiết chữ phía trước. Đính nhãn trang trí ở một bên tay áo. Có đường may nổi sau lưng.', N'Images/Female/aophongZARA_2.jpg', 789, 526, 3, 5, 2, N'Female'),

(N'Áo nhún bèo', N'Áo phông cổ tròn, tay ngắn. Có họa tiết xếp nếp trên tay áo.', N'Images/Female/aophongZARA_3.jpg', 324, 918, 5, 5, 2, N'Female'),

(N'Áo phông vải gân phối dải trang trí và đính nơ', N'95% vải cotton 5% elastane', N'Images/Female/aophongZARA_4.jpg', 287, 1645, 3, 5, 2, N'Female'),


-- áo sweater
(N'Áo nỉ gucci với hình họa nai', N'Phía trước áo in hình họa nai bambi, phía sau áo in hoa lá đầy màu sắc tuyệt đẹp.', N'Images/Female/aolenGC_1.jpg', 647, 546, 5, 1, 3, N'Female'),

(N'Áo nỉ gucci với in hình logo gấu teddy bear.', N'Họa tiết chú gấu in trước áo tinh tế. chất liệu 100% cotton cao cấp.', N'Images/Female/aolenGC_2.jpg', 738, 627, 1, 1, 3, N'Female'),

(N'Áo Len Nữ Gucci Grey With GG Logo Printed', N'Áo thiết kế cổ tròn, tay dài mang lại cảm giác năng động, trẻ trung', N'Images/Female/aolenGC_3.jpg', 849, 627, 2, 1, 3, N'Female'),

(N'Áo len cardigan thêu họa tiết', N'Áo len cardigan làm từ chất liệu len mềm mại có họa tiết thêu ở ngực.', N'Images/Female/aolenHM_1.jpg', 647, 8754, 1, 2, 3, N'Female'),

(N'Áo nỉ', N'Áo bằng vải nỉ mềm làm từ cotton pha', N'Images/Female/aolenHM_2.jpg', 849, 627, 3, 2, 3, N'Female'),

(N'Áo nỉ kẻ ngang', N'Áo bằng vải nỉ mềm làm từ cotton pha', N'Images/Female/aolenHM_3.jpg', 671, 3732, 2, 2, 3, N'Female'),

(N'Áo Len Nữ Tay Dài Striped Cable-Knit Wool-Cashmere Sweater', N'80% Wool 20% Cashmere', N'Images/Female/aolenRL_1.jpg', 633, 928, 5, 3, 3, N'Female'),

(N'Áo len cổ chữ V dệt kim bằng len cashmere', N'Kiểu dáng hộp, hơi rộng', N'Images/Female/aolenRL_2.jpg', 736, 716, 3, 3, 3, N'Female'),

(N'Áo len lông cừu nữ 3d knit jacquard sweater.', N'Làm từ chất liệu len mềm mại', N'Images/Female/aolenUNI_1.jpg', 928, 1221, 1, 4, 3, N'Female'),

(N'Áo len nỉ mix dạ.', N'Làm từ chất len tổng hợp', N'Images/Female/aolenUNI_2.jpg', 1271, 828, 2, 4, 3, N'Female'),

(N'Áo len dệt jacquard quá cỡ.', N'Len dệt sơi đính đá dọc cánh tay', N'Images/Female/aolenZARA_1.jpg', 8921, 5261, 3, 5, 3, N'Female'),

(N'Áo len dệt kim cao cấp alpaca và len.', N'Áo len dệt kim mịn với lông alpaca và len. Có cổ Peter Pan, tay dài và viền bèo nhún.', N'Images/Female/aolenZARA_2.jpg', 621, 1111, 4, 5, 3, N'Female'),

(N'Áo len dệt mỏng có nơ tương phản.', N'Áo len cổ tròn tay dài. Chi tiết mở phía sau có nơ tương phản.', N'Images/Female/aolenZARA_3.jpg', 6151, 981, 5, 5, 3, N'Female'),


--Váy-Đầm
(N'Váy gucci xuông cải viền.', N'Váy xuông kẻ thời thượng và hiện đại', N'Images/Female/vayGC_1.jpg', 1231, 827, 3, 1, 4, N'Female'),

(N'Chân váy xuông dài.', N'Chất liệu jean 100% kết hợp với độ dài vừa phải', N'Images/Female/vayGC_2.jpg', 1831, 644, 3, 1, 4, N'Female'),

(N'Váy tunic viscose', N'Váy lanh mềm mại, thoáng mát cho mùa hè.', N'Images/Female/vayHM_1.jpg', 415, 890, 2, 2, 4, N'Female'),

(N'Váy sơ my họa tiết', N'Chất vải lanh tự nhiên, mang lại cảm giác dễ chịu', N'Images/Female/vayHM_2.jpg', 718, 1129, 1, 2, 4, N'Female'),

(N'Váy ôm body nhún eo dài', N'Nhẹ nhàng, phù hợp cho các buổi tiệc.', N'Images/Female/vayHM_3.jpg', 1562, 1230, 4, 2, 4, N'Female'),

(N'Đầm ngắn polo', N'Trẻ trung năng động', N'Images/Female/vayRL_1.jpg', 351, 912, 4, 3, 4, N'Female'),

(N'Đầm cổ chữ V có đai lưng', N'Chất vải kaki không nhăn không bai xù', N'Images/Female/vayRL_2.jpg', 7163, 918, 1, 3, 4, N'Female'),

(N'Đầm jean cổ gấp', N'Chất jean pha kaki', N'Images/Female/vayRL_3.jpg', 1652, 172, 4, 3, 4, N'Female'),

(N'Chân váy xếp ly cạp chun', N'Chân váy lanh thoáng mát, lý tưởng cho mùa hè.', N'Images/Female/vayUNI_1.jpg', 721, 3221, 5, 4, 4, N'Female'),

(N'Chân váy hoa nhí', N'Chất vải lanh mềm mại, tạo sự thoải mái khi mặc.',  N'Images/Female/vayUNI_2.jpg', 451, 718, 3, 4, 4, N'Female'),

(N'Đầm dài uniqlo', N'Phong cách thanh lịch và trẻ trung',  N'Images/Female/vayUNI_3.jpg', 1733, 1232, 2, 4, 4, N'Female'),

(N'Đầm sơ mi in họa tiết', N'Phong cách cổ điển', N'Images/Female/vayZARA_1.jpg', 726, 1111, 3, 5, 4, N'Female'),

(N'Đầm jean demi', N'Chất demi không nhăn', N'Images/Female/vayZARA_2.jpg', 721, 871, 2, 5, 4, N'Female'),

(N'Váy không tay viền', N'Chất tuyết mưa không dãn, cổ tròn', N'Images/Female/vayZARA_3.jpg', 817, 1621, 3, 5, 4, N'Female'),

(N'Đầm jean 2 dây', N'Chất jean demi min và lì, cổ vuông rộng', N'Images/Female/vayZARA_4.jpg', 1772, 1983, 1, 5, 4, N'Female'),

-- Male 
--ao phong
(N'Áo thun cotton in hình', N'Chiếc áo phông cotton thường ngày được tái hiện với họa tiết Gucci University tạo cảm giác thoải mái.', N'Images/Male/aophongnam1.jpg', 450, 100, 1, 5, 2, N'Male'),
(N'Áo thun cotton jersey', N'Chiếc áo phông vừa vặn này được làm từ vải thun cotton vừa phải và để lộ họa tiết bóng G Interlocking ở mặt trước và họa tiết ô chữ Gucci ở mặt sau.', N'Images/Male/aophongnam2.jpg', 400, 130, 3, 5, 2, N'Male'),
(N'Áo thun cotton jersey thêu', N'Chiếc áo phông oversize này xuất hiện trong chất liệu vải thun cotton nỉ dày màu trắng, trong khi phần ngực được thêu họa tiết Gucci.', N'Images/Male/aophongnam3.jpg', 390, 94, 2, 5, 2, N'Male'),

(N'Áo thun in', N'Áo phông bằng vải thun cotton dày dặn có họa tiết in ở mặt trước và các chi tiết trông như được phun sơn. Cổ tròn có gân, vai trễ và đường may bên hông tương phản.', N'Images/Male/aophongnamHM1.jpg', 450, 100, 1, 1, 2, N'Male'),
(N'Áo thun Regular Fit', N'Áo thun cotton jersey nhẹ có cổ tròn, viền gân nổi và vạt ngang. Dáng vừa để mặc thoải mái và có kiểu dáng cổ điển.', N'Images/Male/aophongnamHM2.jpg', 300, 86, 1, 1, 2, N'Male'),
(N'Áo thun đảo ngược', N'Áo phông hai mặt làm từ vải thun cotton dày dặn với đường may viền thô lộ rõ. Cổ tròn có gân, vai trễ và đường may bên hông màu nổi bật. Họa tiết in ở mặt trước và mặt sau.', N'Images/Male/aophongnamHM3.jpg', 500, 130, 1, 1, 2, N'Male'),

(N'Áo thun Jersey Logo Classic Fit', N'Kiểu dáng cổ điển: Ôm trọn phần ngực, eo và tay áo, có lỗ khoét tay áo thấp hơn, dài đến khuỷu tay.', N'Images/Male/aophongnamRL1.jpg', 700, 95, 4, 4, 2, N'Male'),
(N'Áo thun Polo Bear cổ điển vừa vặn', N'Kiểu dáng cổ điển: Ôm trọn phần ngực, eo và tay áo, có lỗ khoét tay áo thấp hơn, dài đến khuỷu tay.', N'Images/Male/aophongnamRL2.jpg', 450, 45, 4, 4, 2, N'Male'),
(N'Áo thun cổ tròn Jersey - Phù hợp với mọi vóc dáng', N'Kiểu dáng Slim Fit: vừa vặn ở phần ngực và eo.', N'Images/Male/aophongnamRL3.jpg', 800, 100, 1, 4, 2, N'Male'),

(N'Áo thun cotton oversized AIRism tay lỡ', N'Vải AIRism mịn màng với vẻ ngoài giống như cotton.', N'Images/Male/aophongnamUNI1.jpg', 350, 39, 3, 2, 2, N'Male'),
(N'Áo thun cổ tròn DRY-EX', N'Vải lưới giúp tăng khả năng thoáng khí.', N'Images/Male/aophongnamUNI2.jpg', 300, 59, 1, 2, 2, N'Male'),
(N'Áo thun cotton SUPIMA', N'Được làm từ 100% sợi SUPIMA® cotton - chất liệu siêu hiếm với tiêu chuẩn cao đến mức chỉ 1% bông trên thế giới có thể đáp ứng được, cho màu sắc rực rỡ, kết cấu vải mềm mại và mịn màng.', N'Images/Male/aophongnamUNI3.jpg', 430, 97, 2, 2, 2, N'Male'),

(N'ÁO PHÔNG CƠ BẢN CÓ TRỌNG LƯỢNG NẶNG', N'Áo phông vải cotton co giãn, dáng regular fit. Cổ tròn, cộc tay.', N'Images/Male/aophongnamZR1.jpg', 500, 130, 2, 3, 2, N'Male'),
(N'ÁO PHÔNG DỆT KẾT CẤU BOUCLÉ', N'Áo thun dệt kim làm từ hỗn hợp cotton se sợi. Có cổ tròn, tay ngắn và viền gân.', N'Images/Male/aophongnamZR2.jpg', 450, 96, 1, 3, 2, N'Male'),
(N'ÁO PHÔNG IN SLOGAN', N'Áo phông dáng relaxed fit. Cổ tròn, cộc tay. Phía trước in họa tiết chữ khác màu.', N'Images/Male/aophongnamZR3.jpg', 550, 82, 4, 3, 2, N'Male'),

--ao khoac
(N'Áo nỉ vải thun viscose thêu', N'Ở đây, họa tiết thêu Gucci làm phong phú thêm chiếc áo nỉ vải thun viscose liên kết màu xám này.', N'Images/Male/aokhoacnam1.jpg', 500, 95, 1, 5, 1, N'Male'),
(N'Áo khoác len và da của trường đại học', N'Họa tiết thêu Gucci và đường viền sọc làm tăng thêm nét đẹp cho kiểu dáng.', N'Images/Male/aokhoacnam2.jpg', 550, 122, 2, 5, 1, N'Male'),
(N'Áo khoác len với GG Shadow', N'Chiếc áo khoác này có biểu tượng GG với hiệu ứng quang học gợi nhớ đến di sản của Nhà.', N'Images/Male/aokhoacnam3.jpg', 399, 100, 3, 5, 1, N'Male'),

(N'Áo khoác rộng rãi', N'Áo sơ mi khoác nhẹ bằng vải dệt thoi với bề mặt chải xù. Dáng rộng, có cổ, khuy dọc thân trước và cầu vai phía sau. Vai ráp hơi trễ, tay dài với măng sét cài khuy và túi ngực mở. Vạt hơi tròn. Có lớp lót.', N'Images/Male/aokhoacnamHM1.jpg', 1100, 50, 3, 1, 1, N'Male'),
(N'Áo khoác phao oversized fit', N'Áo khoác oversize bằng vải dệt chần bông. Mũ trùm đầu có thể tháo rời, cổ đứng và khóa kéo ở phía trước. Túi bên hông có khóa kéo và túi trong có khóa bấm. Tay dài, có chun ở cổ tay và dây rút chun ở gấu áo. Có lót.', N'Images/Male/aokhoacnamHM2.jpg', 769, 113, 1, 1, 1, N'Male'),
(N'Áo khoác Regular Fit', N'Áo khoác có cổ, khóa kéo phía trước, túi viền chéo ở hai bên có khuy bấm và túi bên trong. Tay dài có nút ở cổ tay áo. Dáng ôm vừa vặn thoải mái khi mặc và kiểu dáng cổ điển. Có lót.', N'Images/Male/aokhoacnamHM3.jpg', 880, 120, 2, 1, 1, N'Male'),

(N'Áo khoác Bi-Swing', N'Áo Khoác Nam Tay Dài Bi-Swing Jacket', N'Images/Male/aokhoacnamRL1.jpg', 900, 49, 4, 4, 1, N'Male'),
(N'Áo khoác chần bông Beaton', N'Áo khoác chần bông chống thấm nước Polo Ralph Lauren – nam', N'Images/Male/aokhoacnamRL2.jpg', 950, 120, 3, 4, 1, N'Male'),
(N'Áo khoác đóng gói Colden', N'Dây rút ở gấu áo để điều chỉnh kích thước, Logo thêu ở phía trước', N'Images/Male/aokhoacnamRL3.jpg', 1200, 32, 3, 4, 1, N'Male'),

(N'Áo khoác lông cừu lót lông cừu có khóa kéo toàn phần', N'Cổ tay áo co giãn. Đường viền giống như áo khoác ngoài và phù hợp với nhiều hoàn cảnh khác nhau.', N'Images/Male/aokhoacnamUNI1.jpg', 1100, 69, 4, 2, 1, N'Male'),
(N'Áo khoác Parka chống tia UV bỏ túi thiết kế NANO', N'Vải co giãn chống thấm nước được sản xuất theo công nghệ NANODESIGN™ của Toray.', N'Images/Male/aokhoacnamUNI2.jpg', 959, 74, 2, 2, 1, N'Male'),
(N'Áo khoác parka lông vũ liền mạch', N'Lớp lông vũ hiệu suất cao chống gió, bền, chống thấm nước với lớp lông vũ cao cấp có chỉ số làm đầy là 750+*. *Đo theo phương pháp IDFB', N'Images/Male/aokhoacnamUNI3.jpg', 843, 83, 4, 2, 1, N'Male'),

(N'ÁO KHOÁC BÔNG 100% LÔNG VŨ', N'Áo khoác đệm làm bằng vải kỹ thuật bóng', N'Images/Male/aokhoacZR1.jpg', 1000, 59, 2, 3, 1, N'Male'),
(N'ÁO KHOÁC DENIM CHỒN', N'Cổ ve áo và tay dài. Túi bên hông. Viền chun. Khóa kéo phía trước.', N'Images/Male/aokhoacZR2.jpg', 934, 53, 4, 3, 1, N'Male'),
(N'ÁO KHOÁC CÓ KHÓA KÉO', N'Áo khoác vải dày vừa vặn. Cổ cao và tay dài. Túi viền ở hông. Khóa kéo phía trước tương phản.', N'Images/Male/aokhoacZR3.jpg', 890, 45, 1, 3, 1, N'Male'),

--quan
(N'quần denim rộng', N'Nhãn hiệu Gucci Rosso Ancora naplak hoàn thiện phong cách rộng thùng thình này.', N'Images/Male/quannam1.jpg', 600, 100, 2, 5, 5, N'Male'),
(N'quần nylon', N'Kiểu dáng được đệm nhẹ tạo cảm giác thoải mái khi mặc.', N'Images/Male/quannam2.jpg', 749, 88, 1, 5, 5, N'Male'),
(N'quần len', N'Quần này được làm từ len màu xanh đậm sáng bóng tinh tế, được thêu họa tiết Gucci nổi bật.', N'Images/Male/quannam3.jpg', 450, 100, 4, 5, 5, N'Male'),

(N'Quần nỉ Regular Fit', N'Co giãn và dây rút ở eo, túi ở đường may bên hông và viền có gân. Dáng ôm vừa vặn tạo cảm giác thoải mái khi mặc và kiểu dáng cổ điển.', N'Images/Male/quannamHM1.jpg', 550, 78, 1, 1, 5, N'Male'),
(N'Quần âu vải len Relaxed Fit', N'Túi chéo bên hông và túi có nắp phía sau. Ống quần thẳng có nếp gấp.', N'Images/Male/quannamHM2.jpg', 450, 100, 1, 1, 5, N'Male'),
(N'Quần Jeans Rộng Đính Đá', N'Eo thường, khuy cài, túi sau cắt rời và đường may bên trong màu sắc nổi bật. Ống quần cực dài được thiết kế để phủ lên bàn chân với hiệu ứng xếp chồng.', N'Images/Male/quannamHM3.jpg', 300, 54, 4, 1, 5, N'Male'),

(N'Quần Chino Co Giãn', N'Dáng ôm gọn các đường cong trên cơ thể tạo dáng vừa vặn.', N'Images/Male/quannamRL1.jpg', 439, 79, 1, 4, 5, N'Male'),
(N'Quần Jeans Co Giãn Ôm Sullivan', N'Quần Jeans Nam Sullivan Slim Stretch Jean', N'Images/Male/quannamRL2.jpg', 431, 123, 3, 4, 5, N'Male'),
(N'Quần Chino Co Giãn Đã Giặt', N'Túi chìm hai bên, một túi sau giả và ống côn.', N'Images/Male/quannamRL3.jpg', 945, 29, 2, 4, 5, N'Male'),

(N'Quần Flannel dễ mặc', N'Vải cotton flannel ấm áp với độ chải vừa phải, pha trộn với rayon tạo nên kết cấu mềm mại.', N'Images/Male/quannamUNI1.jpg', 1100, 69, 4, 2, 5, N'Male'),
(N'Quần nỉ', N'Chất liệu vải cao cấp với kết cấu mịn ở cả hai mặt tạo cảm giác mịn màng khi tiếp xúc với da.', N'Images/Male/quannamUNI2.jpg', 678, 92, 1, 2, 5, N'Male'),
(N'Quần Jeans Màu Rộng Vừa Vặn', N'Vải chéo cotton là loại vải chắc chắn mang lại vẻ ngoài giản dị. Lớp hoàn thiện nhuộm vải tạo hiệu ứng phai màu.', N'Images/Male/quannamUNI3.jpg', 832, 86, 2, 2, 5, N'Male'),

(N'QUẦN JEANS BAGGY FIT', N'Quần jeans dáng baggy fit. Cạp có thắt lưng cùng chất liệu. Có 5 túi. Kiểu bạc màu. Cài khóa kéo và khuy.', N'Images/Male/quannamZR1.jpg', 500, 49, 1, 3, 5, N'Male'),
(N'QUẦN DENIM CARGO POCKET', N'Hiệu ứng giặt. Viền có thể điều chỉnh bằng dây đai. Khóa kéo phía trước và nút đóng.', N'Images/Male/quannamZR2.jpg', 650, 23, 4, 3, 5, N'Male'),
(N'QUẦN CARGO CÓ TÚI', N'Quần cạp co giãn, có dây rút để điều chỉnh.', N'Images/Male/quannamZR3.jpg', 700, 49, 2, 3, 5, N'Male'),

--sweater
(N'Áo kỹ thuật', N'Chiếc áo phông cổ lọ hợp thời trang này được làm từ chất liệu vải jersey kỹ thuật nhẹ với họa tiết Gucci dạng điểm ảnh khắp áo.', N'Images/Male/sweater1.jpg', 700, 140, 1, 5, 3, N'Male'),
(N'Áo len dệt kim Gucci', N'Được làm từ len xám, chiếc áo len dáng vừa này được thiết kế với họa tiết khảm Gucci tương phản.', N'Images/Male/sweater2.jpg', 1000, 74, 4, 5, 3, N'Male'),
(N'áo len', N'Chiếc áo len này có chất liệu len dệt jacquard GG màu xám đậm và đen gợi nhớ đến di sản của Nhà.', N'Images/Male/sweater3.jpg', 800, 112, 3, 5, 3, N'Male'),

(N'Áo len mịn Regular Fit', N'Kiểu dáng vừa vặn tạo cảm giác thoải mái khi mặc và có kiểu dáng cổ điển.', N'Images/Male/sweaternamHM1.jpg', 349, 100, 2, 1, 3, N'Male'),
(N'Áo len dệt kim vừa vặn', N'Áo len dáng vừa vặn làm từ chất liệu dệt kim mềm mại, mịn màng với cổ tròn, viền bo, tay dài và bo ở cổ tay và gấu áo.', N'Images/Male/sweaternamHM2.jpg', 549, 49, 3, 1, 3, N'Male'),
(N'Áo len cổ lọ dệt kim mỏng vừa vặn', N'Áo len làm từ vải cotton dệt kim mềm mại, cổ bẻ, tay dài và bo gân ở cổ tay và viền áo.', N'Images/Male/sweaternamHM3.jpg', 649, 88, 1, 1, 3, N'Male'),

(N'Áo chui đầu Estate-Rib Quarter-Zip', N'Lớp trang phục sang trọng này giúp bạn cảm thấy thoải mái và hợp thời trang dù bạn đang vào thành phố để gặp gỡ bạn bè hay tận hưởng chuyến đi bộ trong rừng khi thời tiết trở lạnh.', N'Images/Male/sweaternamRL1.jpg', 900, 20, 2, 4, 3, N'Male'),
(N'Áo len cổ tròn cotton có họa tiết', N'Kiểu dáng Regular Fit: rộng hơn ở phần ngực nhưng vẫn giữ được kiểu dáng hiện đại.', N'Images/Male/sweaternamRL2.jpg', 990, 79, 3, 4, 3, N'Male'),
(N'Áo len Cashmere dệt kim dạng cáp mang tính biểu tượng', N'Tay dài, bo gấu tay áo bằng vải dệt kim.', N'Images/Male/sweaternamRL3.jpg', 1100, 29, 1, 4, 3, N'Male'),

(N'Áo len dài tay cổ tròn Merino siêu mịn', N'Có thể giặt bằng máy, dễ dàng chăm sóc. *Chúng tôi khuyên bạn nên giặt mặt hàng này bằng cách lật mặt trái và bỏ vào túi giặt. *Định hình sản phẩm sau khi giặt', N'Images/Male/sweaternamUNI1.jpg', 456, 130, 2, 2, 3, N'Male'),
(N'Áo len cổ tròn Souffle Yarn', N'Mẫu áo len cổ tròn này có chất liệu vải mềm mại, co giãn tốt và không gây kích ứng da (ngứa da).', N'Images/Male/sweaternamUNI2.jpg', 650, 83, 1, 2, 3, N'Male'),
(N'Áo len khóa kéo nửa Souffle Yarn', N'Neck designed for an optimal fit even when fastened up to the very top.', N'Images/Male/sweaternamUNI3.jpg', 700, 70, 4, 2, 3, N'Male'),

(N'ÁO NỈ CÓ KHÓA KÉO', N'Áo nỉ vải nhẹ có lớp lót bên trong chải mềm', N'Images/Male/sweaterZR1.jpg', 600, 49, 1, 3, 3, N'Male'),
(N'ÁO NỈ CÓ MIẾNG VẢI TƯƠNG PHẢN', N'Cũng giống như áo thun, áo len nam không chỉ đơn thuần là trang phục cơ bản.', N'Images/Male/sweaterZR2.jpg', 549, 100, 2, 3, 3, N'Male'),
(N'ÁO NỈ CỔ TRÒN ĐÃ GIẶT', N'Áo nỉ cổ tròn, dài tay. Bo viền bằng vải gân. Có các đường may ráp.', N'Images/Male/sweaterZR3.jpg', 340, 87, 1, 3, 3, N'Male');

GO

INSERT INTO [dbo].[Image] ([ProductID], [ImageMore]) VALUES
(1,N'Images/Female/aokhoacGC1a.jpg'),(1,N'Images/Female/aokhoacGC1b.jpg'),(1,N'Images/Female/aokhoacGC1c.jpg'),
(2,N'Images/Female/aokhoacGC2a.jpg'),(2,N'Images/Female/aokhoacGC2b.jpg'),

(3,N'Images/Female/aokhoacHM_1a.jpg'),
(4,N'Images/Female/aokhoacHM_2a.jpg'),
(5,N'Images/Female/aokhoacHM_3a.jpg'),(5,N'Images/Female/aokhoacHM_3b.jpg'),(5,N'Images/Female/aokhoacHM_3c.jpg'),(5,N'Images/Female/aokhoacHM_3d.jpg'),
(6,N'Images/Female/aokhoacHM_4a.jpg'),(6,N'Images/Female/aokhoacHM_4b.jpg'),(6,N'Images/Female/aokhoacHM_4c.jpg'),

(7,N'Images/Female/aokhoacRL_1a.jpg'),(7,N'Images/Female/aokhoacRL_1b.jpg'),
(8,N'Images/Female/aokhoacRL_2a.jpg'),(8,N'Images/Female/aokhoacRL_2b.jpg'),
(9,N'Images/Female/aokhoacRL_3a.jpg'),

(10,N'Images/Female/aokhoacUNI_1a.jpg'),(10,N'Images/Female/aokhoacUNI_1b.jpg'),(10,N'Images/Female/aokhoacUNI_1c.jpg'),(10,N'Images/Female/aokhoacUNI_1d.jpg'),
(11,N'Images/Female/aokhoacUNI_2a.jpg'),(11,N'Images/Female/aokhoacUNI_2b.jpg'),(11,N'Images/Female/aokhoacUNI_2c.jpg'),
(12,N'Images/Female/aokhoacUNI_3a.jpg'),(12,N'Images/Female/aokhoacUNI_3b.jpg'),

(13,N'Images/Female/aokhoacZARA_1a.jpg'),
(14,N'Images/Female/aokhoacZARA_2a.jpg'),
(15,N'Images/Female/aokhoacZARA_3a.jpg'),(15,N'Images/Female/aokhoacZARA_3b.jpg'),(15,N'Images/Female/aokhoacZARA_3c.jpg'),

-- ao phong
(16,N'Images/Female/aophongGC_1a.jpg'),(16,N'Images/Female/aophongGC_1b.jpg'),
(17,N'Images/Female/aophongGC_2a.jpg'),(17,N'Images/Female/aophongGC_2b.jpg'),
(18,N'Images/Female/aophongGC_3a.jpg'),

(19,N'Images/Female/aophongHM_1a.jpg'),(19,N'Images/Female/aophongHM_1b.jpg'),(19,N'Images/Female/aophongHM_1c.jpg'),(19,N'Images/Female/aophongHM_1d.jpg'),(19,N'Images/Female/aophongHM_1e.jpg'),
(20,N'Images/Female/aophongHM_2a.jpg'),(20,N'Images/Female/aophongHM_2b.jpg'),(20,N'Images/Female/aophongHM_2c.jpg'),(20,N'Images/Female/aophongHM_2d.jpg'),
(21,N'Images/Female/aophongHM_3a.jpg'),
(22,N'Images/Female/aophongHM_4a.jpg'),(22,N'Images/Female/aophongHM_4b.jpg'),(22,N'Images/Female/aophongHM_4c.jpg'),

(23,N'Images/Female/aophongRL_1a.jpg'),(23,N'Images/Female/aophongRL_1b.jpg'),
(24,N'Images/Female/aophongRL_2a.jpg'),(23,N'Images/Female/aophongRL_2b.jpg'),
(25,N'Images/Female/aophongRL_3a.jpg'),(25,N'Images/Female/aophongRL_3b.jpg'),

(26,N'Images/Female/aophongUNI_1a.jpg'),
(27,N'Images/Female/aophongUNI_2a.jpg'),(27,N'Images/Female/aophongUNI_2b.jpg'),

(28,N'Images/Female/aophongZARA_1a.jpg'),
(29,N'Images/Female/aophongZARA_2a.jpg'),(29,N'Images/Female/aophongZARA_2b.jpg'),
(30,N'Images/Female/aophongZARA_3a.jpg'),(30,N'Images/Female/aophongZARA_3b.jpg'),
(31,N'Images/Female/aophongZARA_4a.jpg'),(31,N'Images/Female/aophongZARA_4b.jpg'),

-- ao len
(32,N'Images/Female/aolenGC_1a.jpg'),
(33,N'Images/Female/aolenGC_2a.jpg'),(33,N'Images/Female/aolenGC_2b.jpg'),
(34,N'Images/Female/aolenGC_3a.jpg'),(34,N'Images/Female/aolenGC_3b.jpg'),

(35,N'Images/Female/aolenHM_1a.jpg'),
(36,N'Images/Female/aolenHM_2a.jpg'),(36,N'Images/Female/aolenHM_2b.jpg'),(36,N'Images/Female/aolenHM_2c.jpg'),
(37,N'Images/Female/aolenHM_3a.jpg'),(37,N'Images/Female/aolenHM_3b.jpg'),

(38,N'Images/Female/aolenRL_1a.jpg'),
(39,N'Images/Female/aolenRL_2a.jpg'),(39,N'Images/Female/aolenRL_2b.jpg'),

(40,N'Images/Female/aolenUNI_1a.jpg'),(40,N'Images/Female/aolenUNI_1b.jpg'),(40,N'Images/Female/aolenUNI_1c.jpg'),
(41,N'Images/Female/aolenUNI_2a.jpg'),(41,N'Images/Female/aolenUNI_2b.jpg'),

(42,N'Images/Female/aolenZARA_1a.jpg'),(42,N'Images/Female/aolenZARA_1b.jpg'),
(43,N'Images/Female/aolenZARA_2a.jpg'),
(44,N'Images/Female/aolenZARA_3a.jpg'),(44,N'Images/Female/aolenZARA_3b.jpg'),(44,N'Images/Female/aolenZARA_3c.jpg'),

-- vay 
(45,N'Images/Female/vayGC_1a.jpg'),
(46,N'Images/Female/vayGC_2a.jpg'),(46,N'Images/Female/vayGC_2b.jpg'),

(47,N'Images/Female/vayHM_1a.jpg'),(47,N'Images/Female/vayHM_1b.jpg'),(47,N'Images/Female/vayHM_1c.jpg'),
(48,N'Images/Female/vayHM_2a.jpg'),(48,N'Images/Female/vayHM_2b.jpg'),(48,N'Images/Female/vayHM_2c.jpg'),
(49,N'Images/Female/vayHM_3a.jpg'),(49,N'Images/Female/vayHM_3b.jpg'),(49,N'Images/Female/vayHM_3c.jpg'),(49,N'Images/Female/vayHM_3d.jpg'),(49,N'Images/Female/vayHM_3e.jpg'),

(50,N'Images/Female/vayRL_1a.jpg'),(50,N'Images/Female/vayRL_1b.jpg'),(50,N'Images/Female/vayRL_1c.jpg'),
(51,N'Images/Female/vayRL_2a.jpg'),(51,N'Images/Female/vayRL_2b.jpg'),
(52,N'Images/Female/vayRL_3a.jpg'),(52,N'Images/Female/vayRL_3b.jpg'),

(53,N'Images/Female/vayUNI_1a.jpg'),
(54,N'Images/Female/vayUNI_2a.jpg'),(54,N'Images/Female/vayUNI_2b.jpg'),(54,N'Images/Female/vayUNI_2c.jpg'),
(55,N'Images/Female/vayUNI_3a.jpg'),

(56,N'Images/Female/vayZARA_1a.jpg'),(56,N'Images/Female/vayZARA_1b.jpg'),
(57,N'Images/Female/vayZARA_2a.jpg'),(57,N'Images/Female/vayZARA_2b.jpg'),
(58,N'Images/Female/vayZARA_3a.jpg'),(58,N'Images/Female/vayZARA_3b.jpg'),(58,N'Images/Female/vayZARA_3c.jpg'),(58,N'Images/Female/vayZARA_3d.jpg'),(58,N'Images/Female/vayZARA_3e.jpg'),
(59,N'Images/Female/vayZARA_4a.jpg'),(59,N'Images/Female/vayZARA_4b.jpg'),

-- Male 
(60, N'Images/Male/aokhoacnam1a.jpg'), (60, N'Images/Male/aokhoacnam1b.jpg'),
(61, N'Images/Male/aokhoacnam2a.jpg'), (61, N'Images/Male/aokhoacnam2b.jpg'),
(62, N'Images/Male/aokhoacnam3a.jpg'), (62, N'Images/Male/aokhoacnam3b.jpg'),

(63, N'Images/Male/aokhoacnamHM1a.jpg'),
(64, N'Images/Male/aokhoacnamHM2a.jpg'),
(65, N'Images/Male/aokhoacnamHM3a.jpg'), (65, N'Images/Male/aokhoacnamHM3b.jpg'),

(66, N'Images/Male/aokhoacnamRL1a.jpg'), (66, N'Images/Male/aokhoacnamRL1b.jpg'),
(67, N'Images/Male/aokhoacnamRL2a.jpg'), (67, N'Images/Male/aokhoacnamRL2b.jpg'),
(68, N'Images/Male/aokhoacnamRL3a.jpg'), (68, N'Images/Male/aokhoacnamRL3b.jpg'),

(69, N'Images/Male/aokhoacnamUNI1a.jpg'), (69, N'Images/Male/aokhoacnamUNI1b.jpg'),(69, N'Images/Male/aokhoacnamUNI1c.jpg'), (69, N'Images/Male/aokhoacnamUNI1d.jpg'), (69, N'Images/Male/aokhoacnamUNI1e.jpg'),
(70, N'Images/Male/aokhoacnamUNI2a.jpg'), (70, N'Images/Male/aokhoacnamUNI2b.jpg'),(70, N'Images/Male/aokhoacnamUNI2c.jpg'), (70, N'Images/Male/aokhoacnamUNI2d.jpg'),
(71, N'Images/Male/aokhoacnamUNI3a.jpg'), (71, N'Images/Male/aokhoacnamUNI3b.jpg'),(71, N'Images/Male/aokhoacnamUNI3c.jpg'), (71, N'Images/Male/aokhoacnamUNI3d.jpg'),

(72, N'Images/Male/aokhoacZR1a.jpg'), (72, N'Images/Male/aokhoacZR1b.jpg'),
(73, N'Images/Male/aokhoacZR2a.jpg'), (73, N'Images/Male/aokhoacZR2b.jpg'),
(74, N'Images/Male/aokhoacZR3a.jpg'), (74, N'Images/Male/aokhoacZR3b.jpg'),

-- aophongnam
(75, N'Images/Male/aophongnam1a.jpg'), (75, N'Images/Male/aophongnam1b.jpg'),
(76, N'Images/Male/aophongnam2a.jpg'), (76, N'Images/Male/aophongnam2b.jpg'),
(77, N'Images/Male/aophongnam3a.jpg'), (77, N'Images/Male/aophongnam3b.jpg'),

(78, N'Images/Male/aophongnamHM1a.jpg'), (78, N'Images/Male/aophongnamHM1b.jpg'),
(79, N'Images/Male/aophongnamHM2a.jpg'), (79, N'Images/Male/aophongnamHM2b.jpg'),
(80, N'Images/Male/aophongnamHM3a.jpg'), (80, N'Images/Male/aophongnamHM3b.jpg'),

(81, N'Images/Male/aophongnamRL1a.jpg'), (81, N'Images/Male/aophongnamRL1b.jpg'),
(82, N'Images/Male/aophongnamRL2a.jpg'), (82, N'Images/Male/aophongnamRL2b.jpg'),
(83, N'Images/Male/aophongnamRL3a.jpg'), (83, N'Images/Male/aophongnamRL3b.jpg'),

(84, N'Images/Male/aophongnamUNI1a.jpg'), (84, N'Images/Male/aophongnamUNI1b.jpg'),(84, N'Images/Male/aophongnamUNI1c.jpg'), (84, N'Images/Male/aophongnamUNI1d.jpg'), (84, N'Images/Male/aophongnamUNI1e.jpg'),
(85, N'Images/Male/aophongnamUNI2a.jpg'), (85, N'Images/Male/aophongnamUNI2b.jpg'),
(86, N'Images/Male/aophongnamUNI3a.jpg'), (86, N'Images/Male/aophongnamUNI3b.jpg'),(86, N'Images/Male/aophongnamUNI3c.jpg'),

(87, N'Images/Male/aophongnamZR1a.jpg'), (87, N'Images/Male/aophongnamZR1b.jpg'),
(88, N'Images/Male/aophongnamZR2a.jpg'), (88, N'Images/Male/aophongnamZR2b.jpg'),
(89, N'Images/Male/aophongnamZR3a.jpg'), (89, N'Images/Male/aophongnamZR3b.jpg'),

-- quannam
(90, N'Images/Male/quannam1a.jpg'), (90, N'Images/Male/quannam1b.jpg'),
(91, N'Images/Male/quannam2a.jpg'), (91, N'Images/Male/quannam2b.jpg'),
(92, N'Images/Male/quannam3a.jpg'), (92, N'Images/Male/quannam3b.jpg'),

(93, N'Images/Male/quannamHM1a.jpg'), (93, N'Images/Male/quannamHM1b.jpg'),
(94, N'Images/Male/quannamHM2a.jpg'), (94, N'Images/Male/quannamHM2b.jpg'),
(95, N'Images/Male/quannamHM3a.jpg'), (95, N'Images/Male/quannamHM3b.jpg'),

(96, N'Images/Male/quannamRL1a.jpg'), (96, N'Images/Male/quannamRL1b.jpg'),
(97, N'Images/Male/quannamRL2a.jpg'), (97, N'Images/Male/quannamRL2b.jpg'),
(98, N'Images/Male/quannamRL3a.jpg'), (98, N'Images/Male/quannamRL3b.jpg'),

(99, N'Images/Male/quannamUNI1a.jpg'), (99, N'Images/Male/quannamUNI1b.jpg'),
(100, N'Images/Male/quannamUNI2a.jpg'), (100, N'Images/Male/quannamUNI2b.jpg'),
(101, N'Images/Male/quannamUNI3a.jpg'), (101, N'Images/Male/quannamUNI3b.jpg'),

(102, N'Images/Male/quannamZR1a.jpg'), (102, N'Images/Male/quannamZR1b.jpg'),
(103, N'Images/Male/quannamZR2a.jpg'), (103, N'Images/Male/quannamZR2b.jpg'),
(104, N'Images/Male/quannamZR3a.jpg'), (104, N'Images/Male/quannamZR3b.jpg'),

-- sweaternam
(105, N'Images/Male/sweater1a.jpg'), (105, N'Images/Male/sweater1b.jpg'),
(106, N'Images/Male/sweater2a.jpg'), (106, N'Images/Male/sweater2b.jpg'),
(107, N'Images/Male/sweater3a.jpg'), (107, N'Images/Male/sweater3b.jpg'),

(108, N'Images/Male/sweaternamHM1a.jpg'), (108, N'Images/Male/sweaternamHM1b.jpg'),
(109, N'Images/Male/sweaternamHM2a.jpg'),
(110, N'Images/Male/sweaternamHM3a.jpg'),

(111, N'Images/Male/sweaternamRL1a.jpg'), (111, N'Images/Male/sweaternamRL1b.jpg'),
(112, N'Images/Male/sweaternamRL2a.jpg'), (112, N'Images/Male/sweaternamRL2b.jpg'),
(113, N'Images/Male/sweaternamRL3a.jpg'), (113, N'Images/Male/sweaternamRL3b.jpg'),

(114, N'Images/Male/sweaternamUNI1a.jpg'), (114, N'Images/Male/sweaternamUNI1b.jpg'),(114, N'Images/Male/sweaternamUNI1c.jpg'), (114, N'Images/Male/sweaternamUNI1d.jpg'), (114, N'Images/Male/sweaternamUNI1e.jpg'),
(115, N'Images/Male/sweaternamUNI2a.jpg'), (115, N'Images/Male/sweaternamUNI2b.jpg'),(115, N'Images/Male/sweaternamUNI2c.jpg'), (115, N'Images/Male/sweaternamUNI2d.jpg'),
(116, N'Images/Male/sweaternamUNI3a.jpg'), (116, N'Images/Male/sweaternamUNI3b.jpg'),(116, N'Images/Male/sweaternamUNI3c.jpg'),


(117, N'Images/Male/sweaterZR1a.jpg'), (117, N'Images/Male/sweaterZR1b.jpg'),
(118, N'Images/Male/sweaterZR2a.jpg'), (118, N'Images/Male/sweaterZR2b.jpg'),
(119, N'Images/Male/sweaterZR3a.jpg'), (119, N'Images/Male/sweaterZR3b.jpg');

GO
 
UPDATE Product
SET Price = Price * 1000;
select * from Product

--B1 chạy lệnh này để biết mã tên chính xác
SELECT name 
FROM sys.foreign_keys 
WHERE parent_object_id = OBJECT_ID('dbo.Product');

--B2 nó hiện ra có SizeID thì xóa theo 
ALTER TABLE [dbo].[Product] DROP CONSTRAINT FK__Product__SizeID__59FA5E80;

--B3 Xóa cột SizeID trong Product
ALTER TABLE [dbo].[Product] DROP COLUMN SizeID;

--B4 Tạo bảng trung gian Product_Size

CREATE TABLE [dbo].[Product_Size] (
    [ProductID] INT NOT NULL,
    [SizeID] INT NOT NULL,
    PRIMARY KEY ([ProductID], [SizeID]),
    FOREIGN KEY ([ProductID]) REFERENCES [dbo].[Product]([ProductID]) ON DELETE CASCADE,
    FOREIGN KEY ([SizeID]) REFERENCES [dbo].[Size]([SizeID]) ON DELETE CASCADE
);
ALTER TABLE [dbo].[Orders]
ADD Email NVARCHAR(50) NOT NULL,
    Mobile NVARCHAR(15) NOT NULL,
    Address NVARCHAR(255) NOT NULL;






