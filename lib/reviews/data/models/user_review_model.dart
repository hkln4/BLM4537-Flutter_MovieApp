class UserReviewModel {
  final int id;
  final int userId;
  final int movieId;
  final double rating;
  final String? reviewText;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? movieTitle;
  final String? posterPath;
  final String? userName;

  const UserReviewModel({
    required this.id,
    required this.userId,
    required this.movieId,
    required this.rating,
    this.reviewText,
    this.createdAt,
    this.updatedAt,
    this.movieTitle,
    this.posterPath,
    this.userName,
  });

  factory UserReviewModel.fromJson(Map<String, dynamic> json) {
    return UserReviewModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      movieId: json['movie_id'] ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewText: json['review_text'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      movieTitle: json['movie_title'],
      posterPath: json['poster_path'],
      userName: json['user_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'movie_id': movieId,
      'rating': rating,
      'review_text': reviewText,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'movie_title': movieTitle,
      'poster_path': posterPath,
      'user_name': userName,
    };
  }

  UserReviewModel copyWith({
    int? id,
    int? userId,
    int? movieId,
    double? rating,
    String? reviewText,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? movieTitle,
    String? posterPath,
    String? userName,
  }) {
    return UserReviewModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      movieId: movieId ?? this.movieId,
      rating: rating ?? this.rating,
      reviewText: reviewText ?? this.reviewText,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      movieTitle: movieTitle ?? this.movieTitle,
      posterPath: posterPath ?? this.posterPath,
      userName: userName ?? this.userName,
    );
  }

  @override
  String toString() {
    return 'UserReviewModel(id: $id, userId: $userId, movieId: $movieId, rating: $rating)';
  }
}
