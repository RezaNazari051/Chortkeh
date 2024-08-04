extension StringExtension on String {
  String toCurrencyFormat() => replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (match) => '${match[1]},');
}
