import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/destinasi_data.dart';
import '../models/destinasi.dart';
import '../models/kategori_wisata.dart';
import '../providers/wisata_providers.dart';
import '../widgets/network_image_with_fallback.dart';
import 'detail_screen.dart';

/// Soal 3b: Tab Beranda dengan sapaan, pencarian, daftar Populer (rating >= 4.5),
/// FilterChip Kategori dalam Wrap, dan kotak statistik kategori.
class BerandaTab extends ConsumerStatefulWidget {
  const BerandaTab({super.key});

  @override
  ConsumerState<BerandaTab> createState() => _BerandaTabState();
}

class _BerandaTabState extends ConsumerState<BerandaTab> {
  // Local state murni UI untuk kontrol input teks pencarian (Soal 4b).
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(
      text: ref.read(kataKunciProvider),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _bukaDetail(Destinasi destinasi) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => DetailScreen(destinasi: destinasi),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    final String kataKunci = ref.watch(kataKunciProvider);
    final Set<KategoriWisata> kategoriTerpilih =
        ref.watch(kategoriTerpilihProvider);
    final List<Destinasi> destinasiTerfilter =
        ref.watch(destinasiTerfilterProvider);

    // Destinasi populer: rating >= 4.5 (mengikuti hasil filter aktif agar pencarian & kategori terasa responsif)
    final List<Destinasi> destinasiPopuler = destinasiTerfilter
        .where((destinasi) => destinasi.rating >= 4.5)
        .toList();

    // Kategori yang ditampilkan di kotak statistik: kategori terpilih, atau semua kategori jika belum ada yang dipilih
    final List<KategoriWisata> kategoriStatistik = kategoriTerpilih.isEmpty
        ? KategoriWisata.values
        : KategoriWisata.values
            .where((k) => kategoriTerpilih.contains(k))
            .toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // 1) Teks sapaan & TextField pencarian
        Text(
          'Halo, mau ke mana hari ini?',
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _searchController,
          onChanged: (String value) {
            ref.read(kataKunciProvider.notifier).state = value;
          },
          decoration: InputDecoration(
            hintText: 'Cari destinasi...',
            prefixIcon: Icon(
              Icons.search_rounded,
              color: colorScheme.onSurfaceVariant,
            ),
            suffixIcon: kataKunci.isNotEmpty
                ? IconButton(
                    tooltip: 'Hapus pencarian',
                    icon: const Icon(Icons.clear_rounded),
                    onPressed: () {
                      _searchController.clear();
                      ref.read(kataKunciProvider.notifier).state = '';
                    },
                  )
                : null,
            filled: true,
            fillColor: colorScheme.surfaceContainerLow,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28),
              borderSide: BorderSide(color: colorScheme.outline),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28),
              borderSide: BorderSide(color: colorScheme.outlineVariant),
            ),
          ),
        ),

        const SizedBox(height: 20),

        // 2) Bagian "Populer (rating >= 4.5)"
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Populer (rating ≥ 4.5)',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
                color: colorScheme.onSurface,
              ),
            ),
            Text(
              '${destinasiPopuler.length} tempat',
              style: textTheme.labelMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 175,
          child: destinasiPopuler.isEmpty
              ? Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: colorScheme.outlineVariant),
                  ),
                  child: Text(
                    'Tidak ada destinasi populer yang cocok dengan filter.',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                )
              : ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: destinasiPopuler.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (BuildContext context, int index) {
                    final Destinasi item = destinasiPopuler[index];
                    return SizedBox(
                      width: 155,
                      child: Card(
                        margin: EdgeInsets.zero,
                        child: InkWell(
                          onTap: () => _bukaDetail(item),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: NetworkImageWithFallback(
                                  imageUrl: item.gambarUrl,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.nama,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: textTheme.labelLarge?.copyWith(
                                        fontWeight: FontWeight.w800,
                                        color: colorScheme.onSurface,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star_rounded,
                                          size: 15,
                                          color: colorScheme.tertiary,
                                        ),
                                        const SizedBox(width: 3),
                                        Text(
                                          item.rating.toStringAsFixed(1),
                                          style: textTheme.labelMedium?.copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: colorScheme.onSurfaceVariant,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),

        const SizedBox(height: 20),

        // 3) Bagian "Kategori" dengan FilterChip dalam Wrap
        Text(
          'Kategori',
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w800,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: KategoriWisata.values.map((KategoriWisata kategori) {
            final bool isSelected = kategoriTerpilih.contains(kategori);
            return FilterChip(
              selected: isSelected,
              avatar: isSelected
                  ? null
                  : Icon(
                      kategori.icon,
                      size: 17,
                      color: colorScheme.primary,
                    ),
              label: Text(kategori.label),
              onSelected: (bool selected) {
                final Set<KategoriWisata> updated = <KategoriWisata>{
                  ...kategoriTerpilih,
                };
                if (selected) {
                  updated.add(kategori);
                } else {
                  updated.remove(kategori);
                }
                ref.read(kategoriTerpilihProvider.notifier).state = updated;
              },
            );
          }).toList(),
        ),

        const SizedBox(height: 20),

        // 4) Kotak ringkasan statistik kategori (dari function statistikKategori Soal 1f)
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: colorScheme.outlineVariant),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.analytics_outlined,
                    size: 18,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Statistik kategori:',
                    style: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ...kategoriStatistik.map((KategoriWisata kategori) {
                final ({int jumlah, double rataRating}) hasilStat =
                    statistikKategori(daftarDestinasiMojokerto, kategori);
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    children: [
                      Icon(
                        kategori.icon,
                        size: 16,
                        color: colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '${kategori.label}: ${hasilStat.jumlah} destinasi, rata ★ ${hasilStat.rataRating.toStringAsFixed(1)}',
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}
