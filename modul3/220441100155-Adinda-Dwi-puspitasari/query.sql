-- Stored Procedure dengan parameter IN --
DELIMITER $$
CREATE PROCEDURE GetHotelName(
    IN hotel_id_param INT
)
BEGIN
    SELECT nama_hotel FROM Hotel WHERE hotel_id = hotel_id_param;
END$$
DELIMITER ;

CALL GetHotelName(1);

-- Stored Procedure dengan parameter OUT --
DELIMITER $$
CREATE PROCEDURE GetTotalHotel(
    OUT total_hotel INT
)
BEGIN
    SELECT COUNT(*) INTO total_hotel FROM Hotel;
END$$
DELIMITER ;

CALL GetTotalHotel(@total_hotel);
SELECT @total_hotel AS total_hotel;

-- Stored Procedure dengan parameter INOUT --
DELIMITER //

CREATE PROCEDURE HargaBkmr (
 INOUT kamarID INT,
 INOUT Harga_Kamar DECIMAL(10,2)
)

BEGIN 
	DECLARE HargaLama DECIMAL(10,2);
	
	SELECT harga INTO HargaLama FROM kamar WHERE kamar_id = kamarID;
	
	UPDATE kamar SET harga = Harga_Kamar WHERE kamar_id = kamarID;
	
	SET Harga_Kamar = HargaLama;
END //

DELIMITER;

SET @kamarID := 1;
SET @Harga_Kamar := 150000;
CALL HargaBkmr(@kamarID, @Harga_Kamar);
SELECT @kamarID, @Harga_Kamar;
SELECT * FROM kamar;

-- Stored Procedure untuk Memasukkan Data Baru --
DELIMITER //

CREATE PROCEDURE InsertTamu (
 IN id INT,
 IN nama VARCHAR(255), 
 IN alamat_tamu VARCHAR(255), 
 IN email VARCHAR(15))
BEGIN
    INSERT INTO Tamu (tamu_id, nama_tamu, alamat, email) VALUES (id, nama, alamat_tamu, email);
END//


DELIMITER ;

CALL InsertTamu(21, 'Geby', 'Jalan Soekarno No. 70', 'geby@gmail.com');
SELECT * FROM Tamu;


-- Stored Procedure untuk Memperbarui Data --
DELIMITER //

CREATE PROCEDURE UpdateKamar (
 IN id INT,  
 IN kamar VARCHAR(50), 
 IN harga_kamar DECIMAL (10.2),
 IN kapasitas_kamar INT (11)
 )
BEGIN
    UPDATE kamar
    SET tipe_kamar = kamar, harga = harga_kamar, kapasitas = kapasitas_kamar
    WHERE kamar_id = id;
END//

DELIMITER ;

CALL UpdateKamar(4, 'Suite', 500000, '2');
SELECT * FROM Kamar;

-- Stored Procedure untuk Menghapus Data --
DELIMITER //

CREATE PROCEDURE DeleteTamu (
 IN id INT
 )
BEGIN
    DELETE FROM Tamu WHERE tamu_id = id;
END//

DELIMITER ;

CALL DeleteTamu(21);
SELECT * FROM Tamu;