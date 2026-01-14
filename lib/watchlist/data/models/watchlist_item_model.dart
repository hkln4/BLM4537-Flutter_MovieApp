import 'package:movies_app/core/domain/entities/media.dart';

class WatchlistItemModel {
  final int tmdbID;
  final String title;
  final String posterUrl;
  final String backdropUrl;
  final double voteAverage;
  final String releaseDate;
  final String overview;
  final bool isMovie;
  final int userId;

  const WatchlistItemModel({
    required this.tmdbID,
    required this.title,
    required this.posterUrl,
    required this.backdropUrl,
    required this.voteAverage,
    required this.releaseDate,
    required this.overview,
    required this.isMovie,
    required this.userId,
  });

  factory WatchlistItemModel.fromEntity(Media media, int userId) {
    return WatchlistItemModel(
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

  factory WatchlistItemModel.fromJson(Map<String, dynamic> json) {
    return WatchlistItemModel(
      tmdbID: json['movie_id'] ?? 0,
      title: json['title'] ?? '',
      posterUrl: json['poster_path'] ?? '',
      backdropUrl: '', // Backend'de yoksa boş
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      releaseDate: json['release_date'] ?? '',
      overview: '', // Backend'de yoksa boş
      isMovie: true, // Varsayılan olarak film kabul ediyoruz
      userId: json['user_id'] ?? 0,
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
    return 'WatchlistItemModel(tmdbID: $tmdbID, title: $title, isMovie: $isMovie, userId: $userId)';
  }
}
