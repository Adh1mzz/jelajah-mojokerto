import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/destinasi.dart';
import '../models/rupiah_extension.dart';
import '../providers/wisata_providers.dart';
import '../widgets/network_image_with_fallback.dart';
import 'detail_screen.dart';

/// Soal 4d: Tab Favorit menampilkan daftar destinasi favorit dalam ListView
/// dengan tombol hapus, atau empty state jika belum ada favorit.
class FavoritTab extends ConsumerWidget {
  const FavoritTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final List<Destinasi> favoritList = ref.watch(destinasiFavoritListProvider);

    if (favoritList.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.favorite_border_rounded,
                size: 64,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 12),
              Text(
                'Belum ada destinasi favorit',
                textAlign: TextAlign.center,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: favoritList.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (BuildContext context, int index) {
        final Destinasi destinasi = favoritList[index];
        return Card(
          margin: EdgeInsets.zero,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (_) => DetailScreen(destinasi: destinasi),
                ),
              );
            },
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                width: 64,
                height: 64,
                child: NetworkImageWithFallback(
                  imageUrl: destinasi.gambarUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(
              destinasi.nama,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: colorScheme.onSurface,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                children: [
                  Text(
                    destinasi.kategori.label,
                    style: textTheme.labelMedium?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.star_rounded,
                    size: 15,
                    color: colorScheme.tertiary,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    destinasi.rating.toStringAsFixed(1),
                    style: textTheme.labelMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '• ${destinasi.hargaTiket.toRupiah()}',
                    style: textTheme.labelMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            trailing: IconButton(
              tooltip: 'Hapus dari favorit',
              icon: Icon(
                Icons.delete_outline_rounded,
                color: colorScheme.error,
              ),
              onPressed: () {
                ref.read(favoritProvider.notifier).toggle(destinasi.id);
              },
            ),
          ),
        );
      },
    );
  }
}
