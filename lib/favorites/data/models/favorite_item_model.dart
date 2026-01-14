import 'package:movies_app/core/domain/entities/media.dart';

class FavoriteItemModel {
  final int tmdbID;
  final String title;
  final String posterUrl;
  final String backdropUrl;
  final double voteAverage;
  final String releaseDate;
  final String overview;
  final bool isMovie;
  final int userId;
  final DateTime? addedAt;

  const FavoriteItemModel({
    required this.tmdbID,
    required this.title,
    required this.posterUrl,
    required this.backdropUrl,
    required this.voteAverage,
    required this.releaseDate,
    required this.overview,
    required this.isMovie,
    required this.userId,
    this.addedAt,
  });

  factory FavoriteItemModel.fromEntity(Media media, int userId) {
    return FavoriteItemModel(
      tmdbID: media.tmdbID,
      title: media.title,
      posterUrl: media.posterUrl,
      backdropUrl: media.backdropUrl,
      voteAverage: media.voteAverage,
      releaseDate: media.releaseDate,
      overview: media.overview,
      isMovie: media.isMovie,
      userId: userId,
    );
  }

  factory FavoriteItemModel.fromJson(Map<String, dynamic> json) {
    return FavoriteItemModel(
      tmdbID: json['movie_id'] ?? 0,
      title: json['title'] ?? '',
      posterUrl: json['poster_path'] ?? '',
      backdropUrl: '',
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      releaseDate: json['release_date'] ?? '',
      overview: '',
      isMovie: true,
      userId: json['user_id'] ?? 0,
      addedAt: json['added_at'] != null ? DateTime.parse(json['added_at']) : null,
    );
  }

  Media toEntity() {
    return Media(
      tmdbID: tmdbID,
      title: title,
      posterUrl: posterUrl,
      backdropUrl: backdropUrl,
      voteAverage: voteAverage,
      releaseDate: releaseDate,
      overview: overview,
      isMovie: isMovie,
    );
  }

  @override
  String toString() {
    return 'FavoriteItemModel(tmdbID: $tmdbID, title: $title, isMovie: $isMovie, userId: $userId)';
  }
}
