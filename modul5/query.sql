-- Menghitung Selisih Hari antara Tanggal Transaksi Terakhir dan Tanggal Sekarang
DELIMITER //

CREATE PROCEDURE TransaksiTerakhir (
    IN idTamu INT, 
    OUT HariSejakTransaksiTerakhir INT
)
BEGIN
    DECLARE tglTransaksiTerakhir DATE;

    SELECT MAX(tanggal_checkout) INTO tglTransaksiTerakhir
    FROM Pemesanan
    WHERE tamu_id = idTamu;

    SET HariSejakTransaksiTerakhir = DATEDIFF(CURDATE(), tglTransaksiTerakhir);
END //

DELIMITER ;

SET @idTamu = 5;
CALL TransaksiTerakhir(@idTamu, @HariSejakTransaksiTerakhir);
SELECT @HariSejakTransaksiTerakhir AS HariSejakTransaksiTerakhir;


-- Menghitung Jumlah Transaksi pada Bulan Tertentu
DELIMITER //

CREATE PROCEDURE HitungTransaksiBulanan (
    IN hotelID INT, 
    IN tahun INT, 
    IN bulan INT, 
    OUT jumlahTransaksi INT
)
BEGIN
    SELECT COUNT(*) INTO jumlahTransaksi
    FROM Pemesanan p
    JOIN Kamar k ON p.kamar_id = k.kamar_id
    WHERE k.hotel_id = hotelID
      AND YEAR(p.tanggal_checkin) = tahun
      AND MONTH(p.tanggal_checkin) = bulan;
END //

DELIMITER ;

SET @hotelID = 1;
SET @tahun = 2024;
SET @bulan = 5;
CALL HitungTransaksiBulanan(@hotelID, @tahun, @bulan, @jumlahTransaksi);
SELECT @jumlahTransaksi;

-- Menambahkan Data Baru ke Tabel Pemesanan dengan Tanggal Masuk Diisi Otomatis
DELIMITER //

CREATE PROCEDURE TambahPemesanan (
    IN idPemesanan INT,
    IN idTamu INT, 
    IN idKamar INT, 
    IN tanggalCheckout DATE,
    IN jumlahTamu INT
)
BEGIN
    INSERT INTO Pemesanan (pemesanan_id, tamu_id, kamar_id, tanggal_checkin, tanggal_checkout, jumlah_tamu)
    VALUES (idPemesanan, idTamu, idKamar, CURDATE(), tanggalCheckout, jumlahTamu);
END //

DELIMITER ;

-- Menggunakan stored procedure
SET @idPemesanan = 33;
SET @idTamu = 1;
SET @idKamar = 1;
SET @tanggalCheckout = '2024-10-31';
SET @jumlahTamu = 2;
CALL TambahPemesanan(@idPemesanan, @idTamu, @idKamar, @tanggalCheckout, @jumlahTamu);

-- Memverifikasi data baru
SELECT * FROM Pemesanan;