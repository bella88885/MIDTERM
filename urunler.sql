DROP DATABASE IF EXISTS urunler;
CREATE DATABASE IF NOT EXISTS urunler;
USE urunler;

CREATE TABLE products (
    product_no INT AUTO_INCREMENT PRIMARY KEY,
    product_name TEXT,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    category_id INT,
    rating_num INT,
    marka TEXT

);

CREATE TABLE satici_info(
  id INT AUTO_INCREMENT PRIMARY KEY,
  product_no INT,
  satici TEXT,
  satici_puan INT,
  FOREIGN KEY (product_no) REFERENCES products(product_no)
);
CREATE TABLE product_variants (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_no INT,
    color TEXT,
    image_url TEXT,
    FOREIGN KEY (product_no) REFERENCES products(product_no)
);

CREATE TABLE filters (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_no INT,
    location TEXT,
    yarin_kapimda INT,
    FOREIGN KEY (product_no) REFERENCES products(product_no)
);
CREATE TABLE kategori (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    kategori_name TEXT

);

INSERT INTO kategori (kategori_name) VALUES 
('Elektronik'), 
('Moda'), 
('Ev,Yaşam, Kırtasiye, Ofis'), 
('Oto,Bahçe,Yapı Market'), 
('Anne, Bebek, Oyuncak'), 
('Spor,  Outdoor'), 
('Kozmetik, Kişisel Bakım'), 
('Süpermarket, Pet Shop'), 
('Kitap, Müzik, Film, Hobi');


INSERT INTO products (product_name, description, price, category_id,rating_num, marka) VALUES
('Madame Coco Belford Kupa', '250 ml kupa', 179.99, 3 ,120,'Madame Coco'),
('Madame Coco Monte Kupa', '200 ml kupa', 129.99, 3,180,'Madame Coco'),
('English Home Hestia New Bone China Fincan Takımı' , '4 Parça 2 Kişilik Kahve Fincan Takımı', 399.99, 3,50,'English Home'),
('English Home Carnival Phenix Stoneware Kupa Mavi-Yeşil' , '150 ml kupa', 99.99, 3,90,'English Home'),
('Acar Brush Fincan Takımı' , ' 6 Adet Porselen Kahve Fincan Takımı ', 499.99, 3,35,'Acar Brush'),
(' Victorian Home 2000 Parça Puzzle' , ' Puzzle ', 499.99, 9,40,'Art Puzzle'),
(' Anatolian 500 Parçalık Puzzler' , ' Konakta İlkbahar Puzzle ', 499.99, 9,74,'Art Puzzle'),
(' Art Puzzle Çalışma Manzaram ' , ' 500 Parça Puzzle ', 499.99, 9,20,'Art Puzzle'),
(' Art Puzzle Miskinlik Vakti ' , ' 1000 Parça Puzzle ', 499.99, 9,75,'Art Puzzle'),
(' DoerKids Kar Eğlencesi Mini Puzzle' , ' 100 Puzzle ', 499.99, 9,85,'Art Puzzle'),
(' DoerKids Uzay Boşluğu Mini Puzzle' , ' 200 Puzzle ', 199.99, 9,65,'Art Puzzle'),
(' Besinistanbul Ps Spor Dambıl Seti' , ' Dumbıl Seti ', 799.99, 6,95,'Besinistanbul'),
('Aydın Sport 25 kg Halter Seti Dambıl Seti ve Fitness Ağırlık Seti' , ' Dumbıl Seti ', 599.99, 6,125,'Aydın Sport'),
(' Iphone 15 128 GB ' , ' Telefon  ', 60000, 1,95,'Apple'),
(' KIKO Ruj ' , ' Ruj  ', 600, 7,105,'KIKO'),
(' İstanbul Kuzu Etli Pirinçli Köpek Maması' , ' Köpek Maması  ', 600, 8,65,'Istanbul mama'),
('Erkek kazak' , ' Regular size erkek kazak  ', 800, 2,105,'DS DAMAT'),
('Özkoca Yapı Market Inşaat Kumu 0x3 mm - 1 kg' , ' İnşaat kumu ', 40, 4 ,10,'Yapı Market'),
('Süper Garaj Seti Büyük Otopark 6 Katlı' , ' Oyuncak Garaj Seti', 40, 5 ,15,'TOYS');

INSERT INTO satici_info(product_no, satici ,satici_puan)VALUES
(1, 'Ezgi', 8),
(2, 'Evlik ', 6),
(3, 'Bahadır',10),
(4, 'Nağme', 9),
(5, 'Renklim', 3),
(6, 'Ezgi', 7),
(7, 'Ezgi', 6),
(8, 'Murat', 1),
(9, 'Çağla', 5),
(10, 'Sedef', 4),
(11, 'Puzzlecım', 1),
(12, 'Nağme', 8),
(13, 'Sportif', 6),
(14, 'Apple Mağaza', 6),
(15, 'KIKO', 8),
(16, 'MAMACI', 8),
(17, 'DS DAMAT', 9),
(18, 'İNŞAAT', 7),
(19, 'OYUNCAKÇIM', 9);
INSERT INTO product_variants (product_no, color, image_url) VALUES
(1, 'Mavi', '/images/Madame Coco Belford Kupa-mavi.webp'),
(1, 'Mürdüm', '/images/Madame Coco Belford Kupa-mürdüm.webp'),
(1, 'Açık kahve', '/images/Madame Coco Belford Kupa-Açık kahve.jpeg'),
(2, 'Mavi', '/images/Madame Coco Monte Kupa.webp'),
(3, 'Somon', '/images/English Home Hestia New Bone China 4 Parça 2 Kişilik Kahve Fincan Takımı Somon.webp'),
(3, 'Lacivert', '/images/English Home Hestia New Bone China 4 Parça 2 Kişilik Kahve Fincan Takımı Lacivert.jpeg'),
(4, 'Mavi-Yeşil', '/images/English Home Carnival Phenix Stoneware Kupa Mavi-Yeşil.webp'),
(5, 'Mavi-Yeşil', '/images/Acar Brush 6 Adet Porselen Kahve Fincan Takımı.jpeg'),
(6, 'Renkli', '/images/22508 Ks Victorian Ev - Victorian Home 2000 Parça Puzzle.webp'),
(7, 'Renkli', '/images/Anatolian 500 Parçalık Puzzle - Konakta İlkbahar.webp'),
(8, 'Renkli', '/images/Art Puzzle Çalışma Manzaram 500 Parça Puzzle.webp'),
(9, 'Renkli', '/images/Art Puzzle Miskinlik Vakti 1000 Parça Puzzle.webp'),
(10, 'Renkli', '/images/DoerKids Kar Eğlencesi Mini Puzzle.webp'),
(11, 'Renkli', '/images/DoerKids Uzay Boşluğu Mini Puzzle.jpeg'),
(12, 'Renkli', '/images/Besinistanbul Ps Spor Dambıl Seti.webp'),
(13, 'Renkli', '/images/Aydın Sport 25 kg Halter Seti Dambıl Seti ve Fitness Ağırlık Seti.jpeg'),
(14, 'Yeşil', '/images/iphone 15 yesil.webp'),
(14, 'Sarı', '/images/iphone 15 sarı.webp'),
(14, 'Pembe', '/images/iphone 15 pembe.webp'),
(15, 'Baby Pink ', '/images/kiko ruj baby pink.webp'),
(15, 'Rosewood ', '/images/kiko ruj rosewood.webp'),
(15, 'Rosy Biscuit', '/images/kiko ruj rosy biscuit.webp'),
(16, 'renkli', '/images/Mama.webp'),
(17, 'Bej', '/images/kazak regular size.webp'),
(18, 'renkli', '/images/insaat kumu.webp'),
(19, 'renkli', '/images/süper garaj seti.webp');
INSERT INTO filters(product_no,location,yarin_kapimda)VALUES
(1,'İzmir',1),
(1,'Ankara',1),
(1,'İstanbul',1),
(2,'İzmir',0),
(2,'Ankara',0),
(2,'İstanbul',1),
(3,'İzmir',1),
(3,'Ankara',0),
(3,'İstanbul',1),
(4,'İzmir',0),
(4,'Ankara',1),
(4,'İstanbul',0),
(5,'İzmir',1),
(5,'Ankara',1),
(5,'İstanbul',0),
(6,'İzmir',1),
(6,'Ankara',1),
(6,'İstanbul',0),
(7,'İzmir',1),
(7,'Ankara',1),
(7,'İstanbul',1),
(8,'İzmir',0),
(8,'Ankara',1),
(8,'İstanbul',1),
(9,'İzmir',1),
(9,'Ankara',1),
(9,'İstanbul',1),
(10,'İzmir',0),
(10,'Ankara',0),
(10,'İstanbul',0),
(11,'İzmir',0),
(11,'Ankara',1),
(11,'İstanbul',0),
(12,'İzmir',0),
(12,'Ankara',0),
(12,'İstanbul',1),
(13,'İzmir',1),
(13,'Ankara',0),
(13,'İstanbul',1),
(14,'İzmir',1),
(14,'Ankara',0),
(14,'İstanbul',1),
(15,'İzmir',0),
(15,'Ankara',0),
(15,'İstanbul',1),
(16,'İzmir',0),
(16,'Ankara',0),
(16,'İstanbul',1),
(17,'İzmir',1),
(17,'Ankara',1),
(17,'İstanbul',1),
(18,'İzmir',0),
(18,'Ankara',1),
(18,'İstanbul',1),
(19,'İzmir',0),
(19,'Ankara',1),
(19,'İstanbul',0);
CREATE TABLE campaigns(
 id INT AUTO_INCREMENT PRIMARY KEY,
 campaign_image_url TEXT
);
INSERT INTO campaigns(campaign_image_url)values
('/images/kampanya1.png'),
('/images/kampanya2.png'),
('/images/kampanya3.png'),
('/images/kampanya4.png'),
('/images/kampanya5.png');


