import '../models/destinasi.dart';
import '../models/kategori_wisata.dart';

/// Soal 1e: Daftar minimal 8 destinasi wisata di Mojokerto (minimal 2 per kategori).
const List<Destinasi> daftarDestinasiMojokerto = [
  // Kategori: Sejarah (3 destinasi)
  Destinasi(
    id: 'dst_01',
    nama: 'Candi Jolotundo',
    lokasi: 'Kec. Trawas',
    deskripsi:
        'Candi Jolotundo (Petirtaan Jolotundo) merupakan salah satu situs petirtaan kuno tertua di Jawa Timur yang berlokasi di lereng barat Gunung Penanggungan, tepatnya di Desa Seloliman, Kecamatan Trawas, Kabupaten Mojokerto. Dibangun pada abad ke-10 (sekitar tahun 977 Masehi) dengan struktur batu andesit yang menyerupai replika Gunung Mahameru, situs ini dikenal sebagai simbol penghormatan atas kelahiran Prabu Airlangga.',
    gambarUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDeku9ZYHpBtO3LFAAO19rfSZwszLVPgTjRlbvUdBbjA&s=10',
    kategori: KategoriWisata.sejarah,
    hargaTiket: 10000,
    rating: 4.7,
    fasilitas: ['Parkir', 'Toilet', 'Musala', 'Pemandu', 'Taman'],
    jamBuka: '07.00 - 17.00',
  ),
  Destinasi(
    id: 'dst_02',
    nama: 'Candi Tikus',
    lokasi: 'Kec. Trowulan',
    deskripsi:
        'Candi Tikus adalah situs petirtaan kuno era Majapahit yang unik karena terletak di bawah permukaan tanah. Struktur bangunan bata merahnya menyerupai miniatur Gunung Mahameru yang dikelilingi kolam air jernih dan pancuran air.',
    gambarUrl:
        'https://assets.promediateknologi.id/crop/0x0:0x0/1200x0/webp/photo/p1/803/2023/10/04/FotoJet-tikus-1712655812.jpg',
    kategori: KategoriWisata.sejarah,
    hargaTiket: 10000,
    rating: 4.6,
    fasilitas: ['Parkir', 'Toilet', 'Musala', 'Gazebo'],
    jamBuka: '07.00 - 16.30',
  ),
  Destinasi(
    id: 'dst_03',
    nama: 'Candi Bajang Ratu',
    lokasi: 'Kec. Trowulan',
    deskripsi:
        'Gapura paduraksa megah peninggalan abad ke-14 yang diyakini dibangun untuk menghormati wafatnya Raja Jayanegara. Ukiran relief pada kaki dan atap gapura menampilkan detail seni pahat tinggi khas Majapahit.',
    gambarUrl:
        'https://img.inews.id/media/1050/files/inews_new/2022/12/13/bajang_ratu.jpg',
    kategori: KategoriWisata.sejarah,
    hargaTiket: 10000,
    rating: 4.8,
    fasilitas: ['Parkir', 'Toilet', 'Musala', 'Spot Foto'],
    jamBuka: '07.00 - 17.00',
  ),

  // Kategori: Alam (3 destinasi)
  Destinasi(
    id: 'dst_04',
    nama: 'Air Terjun Dlundung',
    lokasi: 'Kec. Trawas',
    deskripsi:
        'Terletak di lereng Gunung Welirang, Air Terjun Dlundung menawarkan udara pegunungan yang sejuk dengan aliran air terjun setinggi sekitar 50 meter. Kawasan ini juga dilengkapi bumi perkemahan dan area rekreasi keluarga.',
    gambarUrl:
        'https://pariwisata.mojokertokab.go.id/storage/HyzTdESob5Wy7aEPHLlmPXKgOvFyTJ-metaZGx1bmR1bmcuanBlZw==-.jpg',
    kategori: KategoriWisata.alam,
    hargaTiket: 15000,
    rating: 4.6,
    fasilitas: ['Parkir', 'Toilet', 'Musala', 'Camping Ground', 'Warung'],
    jamBuka: '07.30 - 16.30',
  ),
  Destinasi(
    id: 'dst_05',
    nama: 'Pemandian Air Panas Padusan',
    lokasi: 'Kec. Pacet',
    deskripsi:
        'Destinasi pemandian air panas alami yang bersumber langsung dari lereng Gunung Welirang. Pengunjung dapat berendam menikmati kehangatan air belerang alami sambil memandang hutan pinus yang asri.',
    gambarUrl:
        'https://awsimages.detik.net.id/community/media/visual/2024/03/04/wisata-pemandian-air-panas-padusan-pacet-mojokerto-2_169.jpeg?w=650&q=90',
    kategori: KategoriWisata.alam,
    hargaTiket: 20000,
    rating: 4.5,
    fasilitas: ['Parkir', 'Kolam Hangat', 'Kamar Bilas', 'Musala', 'Kafe'],
    jamBuka: null, // Buka 24 jam
  ),
  Destinasi(
    id: 'dst_06',
    nama: 'Ranu Manduro',
    lokasi: 'Kec. Ngoro',
    deskripsi:
        'Hamparan padang rumput hijau luas dengan latar belakang gagahnya Gunung Penanggungan. Saat musim hujan, cekungan alami di kawasan ini membentuk telaga jernih yang memantulkan siluet pegunungan.',
    gambarUrl:
        'https://img.cnt.traveloka.com/tvlk/blog/2023/08/sabana-ranu-manduro.jpg?tr=q-70,c-at_max,w-1000,h-600',
    kategori: KategoriWisata.alam,
    hargaTiket: 10000,
    rating: 4.4,
    fasilitas: ['Parkir', 'Spot Foto', 'Warung Lokal'],
    jamBuka: '06.00 - 17.30',
  ),

  // Kategori: Religi (2 destinasi)
  Destinasi(
    id: 'dst_07',
    nama: 'Makam Troloyo',
    lokasi: 'Kec. Trowulan',
    deskripsi:
        'Kompleks pemakaman Islam kuno dari masa Kerajaan Majapahit yang menjadi bukti penyebaran agama Islam di tanah Jawa. Di kawasan ini terdapat makam Syekh Jumadil Kubro yang ramai dikunjungi peziarah dari berbagai daerah.',
    gambarUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTSTQsQVxzUkGjztaPI4sOy7V53HiWjHw5DL1UR088vvA&s=10',
    kategori: KategoriWisata.religi,
    hargaTiket: 0, // Gratis
    rating: 4.8,
    fasilitas: ['Parkir Luas', 'Masjid', 'Toilet', 'Sentra Oleh-oleh'],
    jamBuka: null, // Buka 24 jam
  ),
  Destinasi(
    id: 'dst_08',
    nama: 'Maha Vihara Mojopahit',
    lokasi: 'Kec. Trowulan',
    deskripsi:
        'Kompleks vihara megah yang terkenal dengan patung Buddha Tidur raksasa berlapis cat emas sepanjang 22 meter. Suasana tenang dengan taman bergaya arsitektur Jawa-Majapahit membuat tempat ini cocok untuk wisata religi dan edukasi budaya.',
    gambarUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThPBpLDLYFGU1qhdS-OtThOw5AXGPW4_nb-KBY2097oQ&s=10',
    kategori: KategoriWisata.religi,
    hargaTiket: 5000,
    rating: 4.7,
    fasilitas: ['Parkir', 'Toilet', 'Taman Meditasi', 'Pemandu'],
    jamBuka: '08.00 - 17.00',
  ),

  // Kategori: Kuliner (2 destinasi)
  Destinasi(
    id: 'dst_09',
    nama: 'Sentra Onde-Onde Bo Liem',
    lokasi: 'Kec. Magersari',
    deskripsi:
        'Ikon kuliner legendaris Kota Mojokerto sejak tahun 1929. Menyajikan onde-onde hangat bertekstur renyah di luar dan lembut di dalam dengan isian kacang hijau kupas pilihan yang manis gurih.',
    gambarUrl:
        'https://assets-a1.kompasiana.com/items/album/2016/03/30/bo-liem-1-56fb71e5d693737107d1bb73.jpg?t=o&v=770',
    kategori: KategoriWisata.kuliner,
    hargaTiket: 0, // Gratis masuk gerai kuliner
    rating: 4.8,
    fasilitas: [
      'Parkir',
      'Ruang Tunggu',
      'Pembayaran Non-Tunai',
      'Box Oleh-oleh'
    ],
    jamBuka: '06.00 - 21.00',
  ),
  Destinasi(
    id: 'dst_10',
    nama: 'Wisata Kuliner Sambel Wader Trowulan',
    lokasi: 'Kec. Trowulan',
    deskripsi:
        'Kawasan kuliner khas di sekitar Kolam Segaran yang menyajikan ikan wader goreng renyah dipadukan dengan sambal terasi segar, lalapan, dan nasi hangat dengan suasana tepi kolam bersejarah.',
    gambarUrl: 'https://i.ytimg.com/vi/tB-xUnnT69A/maxresdefault.jpg',
    kategori: KategoriWisata.kuliner,
    hargaTiket: 0, // Gratis masuk area kuliner
    rating: 4.5,
    fasilitas: ['Parkir', 'Lesehan', 'Toilet', 'Musala'],
    jamBuka: '08.00 - 21.00',
  ),
];

/// Soal 1f: Function statistikKategori yang mengembalikan Dart Record ({int jumlah, double rataRating}).
({int jumlah, double rataRating}) statistikKategori(
  List<Destinasi> data,
  KategoriWisata k,
) {
  final List<Destinasi> filtered =
      data.where((item) => item.kategori == k).toList();

  if (filtered.isEmpty) {
    return (jumlah: 0, rataRating: 0.0);
  }

  final double totalRating =
      filtered.fold<double>(0.0, (sum, item) => sum + item.rating);
  final double rataRata = totalRating / filtered.length;

  return (jumlah: filtered.length, rataRating: rataRata);
}
