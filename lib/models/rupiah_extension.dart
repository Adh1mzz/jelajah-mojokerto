/// Soal 1d: Extension pada int dengan method toRupiah() tanpa package intl.
extension RupiahFormatter on int {
  String toRupiah() {
    if (this == 0) return 'Gratis';

    final bool isNegative = this < 0;
    final String digits = abs().toString();
    final StringBuffer buffer = StringBuffer();

    for (int i = 0; i < digits.length; i++) {
      final int reverseIndex = digits.length - i;
      if (i > 0 && reverseIndex % 3 == 0) {
        buffer.write('.');
      }
      buffer.write(digits[i]);
    }

    return '${isNegative ? '-' : ''}Rp${buffer.toString()}';
  }
}
