class Contact {
  final String name;
  final String profilePicUrl;
  final String lastMessage;

  Contact({
    required this.name,
    required this.profilePicUrl,
    required this.lastMessage,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      name: json['name'] ?? 'Unknown',
      lastMessage: json['lastMessage'] ?? 'start texting',
      profilePicUrl: json['profilePicUrl'] ?? 'assets/auth/user_img.jpg',
    );
  }
}
