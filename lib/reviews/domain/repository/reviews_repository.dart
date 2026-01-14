import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/reviews/data/models/user_review_model.dart';

abstract class ReviewsRepository {
  Future<Either<Failure, List<UserReviewModel>>> getUserReviews(int userId);
  Future<Either<Failure, List<UserReviewModel>>> getMovieReviews(int movieId);
  Future<Either<Failure, UserReviewModel?>> getUserReviewForMovie(int userId, int movieId);
  Future<Either<Failure, Unit>> addReview({
    required int userId,
    required int movieId,
    required double rating,
    String? reviewText,
    required String title,
    String? posterPath,
    double? voteAverage,
    String? releaseDate,
  });
  Future<Either<Failure, Unit>> updateReview({
    required int reviewId,
    double? rating,
    String? reviewText,
  });
  Future<Either<Failure, Unit>> deleteReview(int reviewId);
}
