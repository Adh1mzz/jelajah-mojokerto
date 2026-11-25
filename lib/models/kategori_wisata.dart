import 'package:material_ui/material_ui.dart';

/// Soal 1b: Enhanced enum KategoriWisata dengan properti label dan icon.
enum KategoriWisata {
  sejarah(label: 'Sejarah', icon: Icons.account_balance_rounded),
  alam(label: 'Alam', icon: Icons.landscape_rounded),
  religi(label: 'Religi', icon: Icons.mosque_rounded),
  kuliner(label: 'Kuliner', icon: Icons.restaurant_rounded);

  const KategoriWisata({
    required this.label,
    required this.icon,
  });

  final String label;
  final IconData icon;
}
