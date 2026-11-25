import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/destinasi.dart';
import '../models/kategori_wisata.dart';
import '../providers/wisata_providers.dart';
import '../widgets/destinasi_card.dart';
import 'detail_screen.dart';

/// Soal 3c: Tab Jelajah menampilkan destinasi hasil filter dalam GridView.builder
/// dengan LayoutBuilder responsif: lebar < 600 -> 2 kolom, 600-900 -> 3 kolom, > 900 -> 4 kolom.
class JelajahTab extends ConsumerWidget {
  const JelajahTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final List<Destinasi> destinasiList = ref.watch(destinasiTerfilterProvider);
    final UrutanWisata urutanAktif = ref.watch(urutanProvider);
    final Set<KategoriWisata> kategoriTerpilih =
        ref.watch(kategoriTerpilihProvider);

    if (destinasiList.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.travel_explore_rounded,
                size: 56,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 12),
              Text(
                'Destinasi tidak ditemukan',
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Coba ubah kata kunci pencarian atau filter kategori di tab Beranda.',
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        // Bar info jumlah hasil & urutan aktif
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                kategoriTerpilih.isEmpty
                    ? 'Menampilkan ${destinasiList.length} destinasi'
                    : 'Filter aktif (${kategoriTerpilih.length} kategori) • ${destinasiList.length} hasil',
                style: textTheme.labelMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                urutanAktif.label,
                style: textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final double maxWidth = constraints.maxWidth;
              final int crossAxisCount;
              if (maxWidth < 600) {
                crossAxisCount = 2;
              } else if (maxWidth <= 900) {
                crossAxisCount = 3;
              } else {
                crossAxisCount = 4;
              }

              return GridView.builder(
                padding: const EdgeInsets.all(14),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.76,
                ),
                itemCount: destinasiList.length,
                itemBuilder: (BuildContext context, int index) {
                  final Destinasi destinasi = destinasiList[index];
                  return DestinasiCard(
                    destinasi: destinasi,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (_) => DetailScreen(destinasi: destinasi),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
