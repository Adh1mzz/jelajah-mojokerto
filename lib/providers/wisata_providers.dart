import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../data/destinasi_data.dart';
import '../models/destinasi.dart';
import '../models/kategori_wisata.dart';

/// Opsi pengurutan pada BottomSheet tab Jelajah (Soal 3f).
enum UrutanWisata {
  namaAZ('Nama (A-Z)'),
  ratingTertinggi('Rating tertinggi'),
  hargaTermurah('Harga termurah');

  const UrutanWisata(this.label);
  final String label;
}

/// Soal 4a & 4b:
/// Alasan pemilihan App State (Riverpod):
/// State seperti kata kunci pencarian, kategori terpilih, urutan, daftar favorit,
/// dan mode tema disimpan di Riverpod karena perlu diakses & disinkronkan lintas
/// halaman/tab secara reaktif (Beranda, Jelajah, Favorit, dan Halaman Detail).
/// Sementara itu, state lokal UI murni seperti `TextEditingController` dan index tab
/// aktif pada `NavigationBar` cukup dikelola dengan `StatefulWidget` (`setState`)
/// karena tidak dibutuhkan oleh widget luar maupun halaman detail.

/// Provider seluruh data master destinasi wisata Mojokerto.
final daftarDestinasiProvider = Provider<List<Destinasi>>((ref) {
  return daftarDestinasiMojokerto;
});

/// 1a) Provider kata kunci pencarian (case-insensitive).
final kataKunciProvider = StateProvider<String>((ref) => '');

/// 1b) Provider kategori terpilih (`Set<KategoriWisata>`, kosong berarti semua kategori).
final kategoriTerpilihProvider = StateProvider<Set<KategoriWisata>>(
  (ref) => <KategoriWisata>{},
);

/// 1c) Provider urutan destinasi pada tab Jelajah.
final urutanProvider = StateProvider<UrutanWisata>(
  (ref) => UrutanWisata.namaAZ,
);

/// 2) Notifier untuk mengelola daftar ID destinasi favorit secara immutable.
class FavoritNotifier extends Notifier<Set<String>> {
  @override
  Set<String> build() {
    return <String>{};
  }

  /// Toggle ID destinasi favorit dengan membuat Set baru (immutable).
  void toggle(String id) {
    if (state.contains(id)) {
      state = <String>{
        for (final existingId in state)
          if (existingId != id) existingId,
      };
    } else {
      state = <String>{...state, id};
    }
  }
}

final favoritProvider = NotifierProvider<FavoritNotifier, Set<String>>(
  FavoritNotifier.new,
);

/// 3) Provider untuk mode tema terang/gelap di seluruh halaman.
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);

/// 4) Provider turunan yang menggabungkan filter pencarian, kategori, dan pengurutan.
final destinasiTerfilterProvider = Provider<List<Destinasi>>((ref) {
  final List<Destinasi> semuaDestinasi = ref.watch(daftarDestinasiProvider);
  final String kataKunci = ref.watch(kataKunciProvider).trim().toLowerCase();
  final Set<KategoriWisata> kategoriTerpilih =
      ref.watch(kategoriTerpilihProvider);
  final UrutanWisata urutan = ref.watch(urutanProvider);

  // Filter berdasarkan kata kunci & kategori terpilih
  final List<Destinasi> hasilFilter = semuaDestinasi.where((destinasi) {
    final bool cocokNama = kataKunci.isEmpty ||
        destinasi.nama.toLowerCase().contains(kataKunci);
    final bool cocokKategori = kategoriTerpilih.isEmpty ||
        kategoriTerpilih.contains(destinasi.kategori);
    return cocokNama && cocokKategori;
  }).toList();

  // Urutkan hasil sesuai urutanProvider
  switch (urutan) {
    case UrutanWisata.namaAZ:
      hasilFilter.sort(
        (a, b) => a.nama.toLowerCase().compareTo(b.nama.toLowerCase()),
      );
      break;
    case UrutanWisata.ratingTertinggi:
      hasilFilter.sort((a, b) => b.rating.compareTo(a.rating));
      break;
    case UrutanWisata.hargaTermurah:
      hasilFilter.sort((a, b) => a.hargaTiket.compareTo(b.hargaTiket));
      break;
  }

  return hasilFilter;
});

/// Provider turunan untuk daftar objek Destinasi yang ditandai sebagai favorit.
final destinasiFavoritListProvider = Provider<List<Destinasi>>((ref) {
  final List<Destinasi> semuaDestinasi = ref.watch(daftarDestinasiProvider);
  final Set<String> favoritIds = ref.watch(favoritProvider);

  return semuaDestinasi
      .where((destinasi) => favoritIds.contains(destinasi.id))
      .toList();
});
