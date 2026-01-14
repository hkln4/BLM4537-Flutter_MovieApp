part of 'reviews_bloc.dart';

abstract class ReviewsEvent extends Equatable {
  const ReviewsEvent();
}

class GetUserReviewsEvent extends ReviewsEvent {
  final int userId;

  const GetUserReviewsEvent({required this.userId});

  @override
  List<Object?> get props => [userId];
}

class GetMovieReviewsEvent extends ReviewsEvent {
  final int movieId;

  const GetMovieReviewsEvent({required this.movieId});

  @override
  List<Object?> get props => [movieId];
}

class AddReviewEvent extends ReviewsEvent {
  final int userId;
  final int movieId;
  final double rating;
  final String? reviewText;
  final String title;
  final String? posterPath;
  final double? voteAverage;
  final String? releaseDate;

  const AddReviewEvent({
    required this.userId,
    required this.movieId,
    required this.rating,
    this.reviewText,
    required this.title,
    this.posterPath,
    this.voteAverage,
    this.releaseDate,
  });

  @override
  List<Object?> get props => [userId, movieId, rating, reviewText, title];
}

class UpdateReviewEvent extends ReviewsEvent {
  final int reviewId;
  final double? rating;
  final String? reviewText;

  const UpdateReviewEvent({
    required this.reviewId,
    this.rating,
    this.reviewText,
  });

  @override
  List<Object?> get props => [reviewId, rating, reviewText];
}

class DeleteReviewEvent extends ReviewsEvent {
  final int reviewId;

  const DeleteReviewEvent({required this.reviewId});

  @override
  List<Object?> get props => [reviewId];
}
