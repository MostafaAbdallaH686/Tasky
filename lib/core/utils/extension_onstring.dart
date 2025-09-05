extension StringExtension on String? {
  String get capitalizeFirst {
    if (this == null || this!.isEmpty) return '';
    return this![0].toUpperCase() + this!.substring(1).toLowerCase();
  }
}
