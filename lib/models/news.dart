class News {
  final int id;
  final String title;
  final String summary;
  final String link;
  final String published;
  bool? isFavorite;

  News({
    required this.id,
    required this.title,
    required this.summary,
    required this.link,
    required this.published,
    this.isFavorite,
  });
}
