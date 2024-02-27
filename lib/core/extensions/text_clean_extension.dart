extension TextCleanExtension on String {
  String get clean => replaceAll(RegExp(r'<[^>]*>|&[^;]*;'), '');

  String caption(int length) {
    final words = clean.split(' ');
    return '${words.take(15).join(' ')}...';
  }
}
