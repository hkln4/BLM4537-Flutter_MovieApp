class ProfileModel {
  final int userId;
  final String name;
  final String email;
  final String? avatarUrl;

  ProfileModel({
    required this.userId,
    required this.name,
    required this.email,
    this.avatarUrl,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      userId: json['user_id'],
      name: json['name'],
      email: json['email'],
      avatarUrl: json['avatar_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'name': name,
      'email': email,
      'avatar_url': avatarUrl,
    };
  }

  @override
  String toString() {
    return 'ProfileModel(userId: $userId, name: $name, email: $email, avatarUrl: $avatarUrl)';
  }
}
