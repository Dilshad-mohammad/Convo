class ChatMessageEntity {
  String text;
  String? imageUrl;
  String id;
  int createdAt;
  Author author;

  ChatMessageEntity({
    required this.text,
    required this.id,
    required this.createdAt,
    this.imageUrl,
    required this.author,
  });


  factory ChatMessageEntity.fromJson(Map<String, dynamic> json) {
    return ChatMessageEntity(
      text: json['text'] ?? 'No text',
      id: json['id'] ?? 'Unknown ID',
      createdAt: json['createdAt'] ?? 0,
      imageUrl: json['image'],
      author: Author.fromJson(json['author'] ?? {}),
    );
  }
}

class Author {
  String userName;

  Author({required this.userName});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      userName: json['username'] ?? 'Unknown User', // Prevents null error
    );
  }
}
