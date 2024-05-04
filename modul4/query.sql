-- Menampilkan data berdasarkan di urutkan berdasarkan ASC, DESC, ORDER BY --

-- Menampilkan data hotel diurutkan berdasarkan nama hotel secara ascending (A-Z)--
SELECT * FROM Hotel ORDER BY nama_hotel ASC;

-- Menampilkan data hotel diurutkan berdasarkan jumlah bintang secara descending (5-1)--
SELECT * FROM Hotel ORDER BY bintang DESC;

-- Menampilkan jumlah tipe untuk setiap tipe kamar yang memiliki lebih dari 5 --
SELECT tipe_kamar, COUNT(*) AS jumlah_tipe FROM Kamar
GROUP BY tipe_kamar
HAVING COUNT(*) > 5 ORDER BY jumlah_tipe DESC;

-- menampilkan semua pemesanan yang tanggal check-in-nya berada di antara tanggal 2024-04-01 dan 2024-04-15:
SELECT * FROM Pemesanan
WHERE tanggal_checkin BETWEEN '2024-04-01' AND '2024-04-15';

-- Menampilkan tipe kamar dengan jumlah transaksi terbanyak --
SELECT tipe_kamar, COUNT(*) AS Jumlah_Sewa
FROM kamar
GROUP BY tipe_kamar
ORDER BY Jumlah_Sewa DESC
LIMIT 1;

-- Menampilkan tipe kamar hotel yang paling sedikit dimiliki --
SELECT tipe_kamar, COUNT(*) AS jumlah_kamar
FROM Kamar
GROUP BY tipe_kamar
ORDER BY jumlah_kamar ASC
LIMIT 1;

-- Menampilkan nama tamu dengan nama yang dimulai dengan huruf "a" --
SELECT * FROM tamu WHERE nama_tamu LIKE 'a%';

-- Menampilkan tamu dengan jumlah transaksi terbanyak --
SELECT tamu_id, COUNT(*) AS Jumlah_Transaksi
FROM pemesanan
GROUP BY tamu_id
ORDER BY Jumlah_Transaksi DESC
LIMIT 1;

-- Menampilkan tamu yang melakukan lebih dari 3 transaksi --
SELECT tamu_id, COUNT(*) AS Jumlah_Transaksi
FROM pemesanan
GROUP BY tamu_id
HAVING COUNT(*) > 3;

-- Tampilkan data seluruh “konsumen/user” atau data sejenis mulai dari data diri, dan data melakukan transaksi apa saja --
SELECT Tamu.*, Pemesanan.* FROM Tamu
JOIN Pemesanan ON Tamu.tamu_id = Pemesanan.tamu_id;




