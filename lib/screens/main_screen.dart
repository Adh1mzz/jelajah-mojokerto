import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/wisata_providers.dart';
import 'beranda_tab.dart';
import 'favorit_tab.dart';
import 'jelajah_tab.dart';

/// Soal 3a: Halaman utama menggunakan Scaffold dengan AppBar ("Jelajah Mojokerto - Adhim"),
/// NavigationBar 3 tab (Beranda, Jelajah, Favorit), dan IndexedStack agar posisi scroll
/// setiap tab tidak hilang ketika berpindah tab.
class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  // Local state dengan setState untuk index tab aktif pada NavigationBar (Soal 4b).
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    BerandaTab(),
    JelajahTab(),
    FavoritTab(),
  ];

  /// Soal 3f: Menampilkan BottomSheet pilihan pengurutan pada tab Jelajah.
  void _tampilkanBottomSheetUrutkan(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (BuildContext sheetContext) {
        return Consumer(
          builder: (BuildContext context, WidgetRef ref, _) {
            final UrutanWisata urutanSaatIni = ref.watch(urutanProvider);
            final ColorScheme colorScheme = Theme.of(context).colorScheme;
            final TextTheme textTheme = Theme.of(context).textTheme;

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Urutkan Destinasi',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...UrutanWisata.values.map((UrutanWisata opsi) {
                      final bool terpilih = urutanSaatIni == opsi;
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        leading: Icon(
                          terpilih
                              ? Icons.radio_button_checked_rounded
                              : Icons.radio_button_off_rounded,
                          color: terpilih
                              ? colorScheme.primary
                              : colorScheme.onSurfaceVariant,
                        ),
                        title: Text(
                          opsi.label,
                          style: textTheme.bodyLarge?.copyWith(
                            fontWeight:
                                terpilih ? FontWeight.w800 : FontWeight.w500,
                            color: terpilih
                                ? colorScheme.primary
                                : colorScheme.onSurface,
                          ),
                        ),
                        onTap: () {
                          ref.read(urutanProvider.notifier).state = opsi;
                          Navigator.pop(sheetContext);
                        },
                      );
                    }),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeMode currentThemeMode = ref.watch(themeModeProvider);
    final bool isDarkMode = currentThemeMode == ThemeMode.dark;
    final int jumlahFavorit = ref.watch(favoritProvider).length;

    return Scaffold(
      appBar: AppBar(
        // Ketentuan personalisasi wajib: "Jelajah Mojokerto - [Nama Panggilan Anda]"
        title: const Text('Jelajah Mojokerto - Adhim'),
        actions: [
          // Tombol urutkan khusus pada tab Jelajah (Soal 3f)
          if (_selectedIndex == 1)
            IconButton(
              tooltip: 'Urutkan destinasi',
              icon: const Icon(Icons.swap_vert_rounded),
              onPressed: () => _tampilkanBottomSheetUrutkan(context),
            ),
          // Tombol berpindah mode terang/gelap pada AppBar (Soal 2e)
          IconButton(
            tooltip: isDarkMode ? 'Mode Terang' : 'Mode Gelap',
            icon: Icon(
              isDarkMode
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_rounded,
            ),
            onPressed: () {
              ref.read(themeModeProvider.notifier).state =
                  isDarkMode ? ThemeMode.light : ThemeMode.dark;
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Beranda',
          ),
          const NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(Icons.grid_view_rounded),
            label: 'Jelajah',
          ),
          NavigationDestination(
            icon: Badge(
              isLabelVisible: jumlahFavorit > 0,
              label: Text('$jumlahFavorit'),
              child: const Icon(Icons.favorite_border_rounded),
            ),
            selectedIcon: Badge(
              isLabelVisible: jumlahFavorit > 0,
              label: Text('$jumlahFavorit'),
              child: const Icon(Icons.favorite_rounded),
            ),
            label: 'Favorit',
          ),
        ],
      ),
    );
  }
}
