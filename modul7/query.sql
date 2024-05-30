--soal 1
CREATE TABLE Pemesanan_Log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    pemesanan_id INT,
    tamu_id INT,
    kamar_id INT,
    tanggal_checkin DATE,
    tanggal_checkout DATE,
    jumlah_tamu INT,
    tanggal_insert TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //

CREATE TRIGGER log_insert_pemesanan
AFTER INSERT ON Pemesanan
FOR EACH ROW
BEGIN
    INSERT INTO Pemesanan_Log (pemesanan_id, tamu_id, kamar_id, tanggal_checkin, tanggal_checkout, jumlah_tamu)
    VALUES (NEW.pemesanan_id, NEW.tamu_id, NEW.kamar_id, NEW.tanggal_checkin, NEW.tanggal_checkout, NEW.jumlah_tamu);
END//

DELIMITER ;

-- Contoh INSERT yang akan memicu trigger
INSERT INTO Pemesanan (pemesanan_id, tamu_id, kamar_id, tanggal_checkin, tanggal_checkout, jumlah_tamu)
VALUES (34, 5, 7, '2024-05-01', '2024-05-03', 3);

-- Memeriksa apakah log ditambahkan
SELECT * FROM Pemesanan_Log;

-- soal 2
DELIMITER //

CREATE TRIGGER check_negative_harga
BEFORE INSERT ON Kamar
FOR EACH ROW
BEGIN
    IF NEW.harga < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Harga tidak boleh negatif';
    END IF;
END;
//

DELIMITER ;

-- Contoh INSERT yang akan memicu trigger
INSERT INTO Kamar (kamar_id, hotel_id, tipe_kamar, harga, kapasitas)
VALUES (31, 1, 'Standard', -100.00, 2);

--soal 3
DELIMITER //

CREATE TRIGGER update_kamar
AFTER UPDATE ON hotel
FOR EACH ROW
BEGIN
    UPDATE kamar SET harga = CONCAT('Update: ', NEW.nama_hotel)
    WHERE hotel_id = NEW.hotel_id;
 
END//

DELIMITER ;

UPDATE hotel SET nama_hotel = 'Hotel B+' WHERE hotel_id = 2;
SELECT * FROM hotel;

--soal 4
-- LANGKAH 1
ALTER TABLE Tamu ADD COLUMN no_telp VARCHAR(15);

-- trigger untuk memastikan no telp yang diinputkan sesuai ketentuan --
DELIMITER //

CREATE TRIGGER validate_no_telp_update
BEFORE UPDATE ON tamu
FOR EACH ROW
BEGIN
    IF LENGTH(NEW.no_telp) < 10 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'No Telpon tidak boleh kurang dari 10 angka';
    END IF;
END//
DELIMITER;

UPDATE tamu SET no_telp = '082337187828' WHERE tamu_id = 2;
SELECT * FROM tamu;




