import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/reviews/domain/repository/reviews_repository.dart';

class AddReviewParams {
  final int userId;
  final int movieId;
  final double rating;
  final String? reviewText;
  final String title;
  final String? posterPath;
  final double? voteAverage;
  final String? releaseDate;

  AddReviewParams({
    required this.userId,
    required this.movieId,
    required this.rating,
    this.reviewText,
    required this.title,
    this.posterPath,
    this.voteAverage,
    this.releaseDate,
  });
}

class AddReviewUseCase {
  final ReviewsRepository _reviewsRepository;

  AddReviewUseCase(this._reviewsRepository);

  Future<Either<Failure, Unit>> call(AddReviewParams params) async {
    return await _reviewsRepository.addReview(
      userId: params.userId,
      movieId: params.movieId,
      rating: params.rating,
      reviewText: params.reviewText,
      title: params.title,
      posterPath: params.posterPath,
      voteAverage: params.voteAverage,
      releaseDate: params.releaseDate,
    );
  }
}
