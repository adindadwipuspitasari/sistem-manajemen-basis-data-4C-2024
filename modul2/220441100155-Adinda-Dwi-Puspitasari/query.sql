-- Updatetable view
CREATE VIEW View_KamarDetail AS
SELECT kamar_id, tipe_kamar, harga, kapasitas
FROM Kamar;

SELECT * FROM View_KamarDetail

CREATE VIEW View_Pemesanan AS SELECT P.pemesanan_id, T.nama_tamu, K.tipe_kamar, P.tanggal_checkin, P.tanggal_checkout, P.jumlah_tamu 
FROM pemesanan P
JOIN tamu T ON P.tamu_id = T.tamu_id
JOIN kamar K ON P.kamar_id = K.kamar_id;

SELECT * FROM View_Pemesanan

-- Update tanggal chek-in
UPDATE View_Pemesanan 
SET tanggal_checkin = '2024-07-01'
WHERE nama_tamu = 'Juwita';

-- update tipe kamar
UPDATE View_KamarDetail
SET tipe_kamar = 'Standard'
WHERE kamar_id = 1;

-- Read-only view
CREATE VIEW FasilitasView AS
SELECT * FROM Fasilitas;
SELECT * FROM FasilitasView

CREATE VIEW TamuView AS
SELECT * FROM tamu;
SELECT * FROM TamuView  

