
class Chapter {
  final int id;
  final int storyId;
  final int chapterNumber;
  final String title;
  final String content;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Chapter({
    required this.id,
    required this.storyId,
    required this.chapterNumber,
    required this.title,
    required this.content,
    this.createdAt,
    this.updatedAt,
  });

  /// 1. Convert dari JSON (dari API/Backend) ke Object
  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      id: json['id'] as int,
      storyId: json['story_id'] as int,
      chapterNumber: json['chapter_number'] as int,
      title: json['title'] ?? 'Tanpa Judul',
      content: json['content'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }

  /// 2. Convert dari Object ke JSON (untuk dikirim ke API via POST/PUT)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'story_id': storyId,
      'chapter_number': chapterNumber,
      'title': title,
      'content': content,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  /// 3. CopyWith: Membantu saat ingin mengubah satu data saja tanpa merusak data lain
  Chapter copyWith({
    int? id,
    int? storyId,
    int? chapterNumber,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Chapter(
      id: id ?? this.id,
      storyId: storyId ?? this.storyId,
      chapterNumber: chapterNumber ?? this.chapterNumber,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}