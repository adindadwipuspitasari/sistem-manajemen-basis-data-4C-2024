-- Stored Procedure untuk Mengecek Apakah Produk (Kamar) Tersebut Merupakan Produk yang Paling Sering Disewa
DELIMITER //

CREATE PROCEDURE CekKamarTerlaris(
    IN kamarID INT
)
BEGIN
    DECLARE topKamarID INT;
    DECLARE tipeKamar VARCHAR(255);

    -- Mendapatkan id kamar yang paling sering disewa
    SELECT kamar_id INTO topKamarID
    FROM Pemesanan
    GROUP BY kamar_id
    ORDER BY COUNT(*) DESC
    LIMIT 1;

    -- Mendapatkan tipe kamar yang dicek
    SELECT tipe_kamar INTO tipeKamar
    FROM Kamar
    WHERE kamar_id = kamarID;

    -- Membandingkan apakah kamar yang dicek adalah yang terlaris
    IF kamarID = topKamarID THEN
        SELECT CONCAT(tipeKamar, ' adalah tipe kamar terlaris') AS Hasil;
    ELSE
        SELECT CONCAT(tipeKamar, ' bukan tipe kamar terlaris') AS Hasil;
    END IF;
END //

DELIMITER ;


-- Menggunakan stored procedure
CALL CekKamarTerlaris(10);

-- Menampilkan data dari tabel master masing masing dengan ID yang berurutan dari 1 hingga 10
DELIMITER //
CREATE PROCEDURE TampilkanDataTamu()
BEGIN
	DECLARE i INT DEFAULT 1;
	DECLARE selesai INT DEFAULT 0;
	DECLARE namaTamu VARCHAR (225);
	DECLARE alamatTamu VARCHAR (225);
	
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET selesai = 1;
	
	WHILE i <= 10 AND selesai = 0 DO
		SELECT nama_tamu, alamat INTO namaTamu, alamatTamu
		FROM tamu
		WHERE tamu_id = i;
		
		IF selesai = 0 THEN
			SELECT tamu_id, nama_tamu, alamat
			FROM tamu
			WHERE tamu_id = i;
		END IF;
	
		SET i = i + 1;
	END WHILE;
END//
DELIMITER ;

CALL TampilkanDataTamu;