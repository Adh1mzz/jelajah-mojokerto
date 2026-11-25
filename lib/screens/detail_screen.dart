import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/destinasi.dart';
import '../models/rupiah_extension.dart';
import '../providers/wisata_providers.dart';
import '../widgets/network_image_with_fallback.dart';

/// Soal 4c: Halaman Detail dengan CustomScrollView, SliverAppBar, Table informasi,
/// daftar fasilitas berupa Chip dalam Wrap, deskripsi, dan tombol favorit tersinkron.
class DetailScreen extends ConsumerWidget {
  const DetailScreen({
    super.key,
    required this.destinasi,
  });

  final Destinasi destinasi;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final bool isFavorite =
        ref.watch(favoritProvider).contains(destinasi.id);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 1) SliverAppBar (pinned, expandedHeight 250) dengan gambar destinasi pada flexibleSpace
          SliverAppBar(
            pinned: true,
            expandedHeight: 250,
            backgroundColor: colorScheme.surfaceContainerHighest,
            foregroundColor: colorScheme.onSurface,
            actions: [
              IconButton(
                tooltip: isFavorite ? 'Hapus dari favorit' : 'Tambah ke favorit',
                icon: Icon(
                  isFavorite
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  color: isFavorite ? colorScheme.error : colorScheme.onSurface,
                ),
                onPressed: () {
                  ref.read(favoritProvider.notifier).toggle(destinasi.id);
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                destinasi.nama,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: colorScheme.onPrimaryContainer,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  NetworkImageWithFallback(
                    imageUrl: destinasi.gambarUrl,
                    fit: BoxFit.cover,
                  ),
                  // Gradasi hitam transparan di atas gambar (diperbolehkan ketentuan Soal 2d)
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.35),
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.55),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Konten Detail
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 88),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // 2) Nama, Chip kategori, dan rating
                Text(
                  destinasi.nama,
                  style: textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Chip(
                      avatar: Icon(
                        destinasi.kategori.icon,
                        size: 16,
                        color: colorScheme.primary,
                      ),
                      label: Text(destinasi.kategori.label),
                    ),
                    const SizedBox(width: 12),
                    Icon(
                      Icons.star_rounded,
                      size: 20,
                      color: colorScheme.tertiary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      destinasi.rating.toStringAsFixed(1),
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // 3) Table informasi: Lokasi, Tiket (toRupiah()), dan Jam Buka ("Buka 24 jam" jika null)
                Table(
                  border: TableBorder.all(
                    color: colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  columnWidths: const <int, TableColumnWidth>{
                    0: FlexColumnWidth(1.2),
                    1: FlexColumnWidth(2.2),
                  },
                  children: [
                    _buildTableRow(
                      context,
                      label: 'Lokasi',
                      value: destinasi.lokasi,
                    ),
                    _buildTableRow(
                      context,
                      label: 'Tiket',
                      value: destinasi.hargaTiket.toRupiah(),
                    ),
                    _buildTableRow(
                      context,
                      label: 'Jam Buka',
                      value: destinasi.jamBuka ?? 'Buka 24 jam',
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                // 4) Daftar fasilitas berupa Chip di dalam Wrap, serta deskripsi
                Text(
                  'Fasilitas',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: destinasi.fasilitas
                      .map(
                        (String fasilitas) => Chip(
                          label: Text(fasilitas),
                          backgroundColor: colorScheme.surfaceContainerLow,
                        ),
                      )
                      .toList(),
                ),

                const SizedBox(height: 18),

                Text(
                  'Deskripsi',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  destinasi.deskripsi,
                  textAlign: TextAlign.justify,
                  style: textTheme.bodyLarge?.copyWith(
                    height: 1.5,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
      // 5) FloatingActionButton favorit yang tersinkron langsung
      floatingActionButton: FloatingActionButton(
        tooltip: isFavorite ? 'Hapus dari favorit' : 'Simpan ke favorit',
        onPressed: () {
          ref.read(favoritProvider.notifier).toggle(destinasi.id);
        },
        child: Icon(
          isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
          color: isFavorite ? colorScheme.error : colorScheme.primary,
        ),
      ),
    );
  }

  TableRow _buildTableRow(
    BuildContext context, {
    required String label,
    required String value,
  }) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return TableRow(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Text(
            label,
            style: textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w800,
              color: colorScheme.onSurface,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Text(
            value,
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}
