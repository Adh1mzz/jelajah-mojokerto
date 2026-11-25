import 'kategori_wisata.dart';

/// Soal 1c: Class Destinasi immutable (semua field final + const constructor dengan named parameter).
class Destinasi {
  const Destinasi({
    required this.id,
    required this.nama,
    required this.lokasi,
    required this.deskripsi,
    required this.gambarUrl,
    required this.kategori,
    required this.hargaTiket,
    required this.rating,
    required this.fasilitas,
    this.jamBuka,
  });

  final String id;
  final String nama;
  final String lokasi;
  final String deskripsi;
  final String gambarUrl;
  final KategoriWisata kategori;
  final int hargaTiket;
  final double rating;
  final List<String> fasilitas;

  /// Nullable: jika null, aplikasi menampilkan teks "Buka 24 jam".
  final String? jamBuka;
}
