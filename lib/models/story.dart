class StoryModel {
  final int? id;
  final String title;
  final String description;
  final String image;
  final String status;

  StoryModel({
    this.id,
    required this.title,
    this.description = '',
    required this.image,
    this.status = 'draft',
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '', // penting untuk app kamu
      status: json['status'] ?? 'draft',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "image": image,
      "status": status,
    };
  }
}