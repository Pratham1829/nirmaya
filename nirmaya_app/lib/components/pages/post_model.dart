class Post {
  final int id;
  final String title;
  final String content;
  final String imageUrl;
  final bool isAsset;
  final List<int> categories;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.isAsset,
    required this.categories,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title']['rendered'] ?? 'No Title',
      content: json['content']['rendered'] ?? '',
      imageUrl: json['featured_image_url'] ?? '',
      isAsset: json['is_asset'] ?? false,
      categories: List<int>.from(json['categories'] ?? []),
    );
  }
}
