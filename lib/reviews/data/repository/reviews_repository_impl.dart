import 'package:movies_app/core/error/exceptions.dart';
import 'package:movies_app/reviews/data/datasource/reviews_remote_data_source.dart';
import 'package:movies_app/reviews/data/models/user_review_model.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_app/reviews/domain/repository/reviews_repository.dart';

class ReviewsRepositoryImpl extends ReviewsRepository {
  final ReviewsRemoteDataSource _reviewsRemoteDataSource;

  ReviewsRepositoryImpl(this._reviewsRemoteDataSource);

  @override
  Future<Either<Failure, List<UserReviewModel>>> getUserReviews(int userId) async {
    try {
      final reviews = await _reviewsRemoteDataSource.getUserReviews(userId);
      return Right(reviews.reversed.toList());
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<UserReviewModel>>> getMovieReviews(int movieId) async {
    try {
      final reviews = await _reviewsRemoteDataSource.getMovieReviews(movieId);
      return Right(reviews.reversed.toList());
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, UserReviewModel?>> getUserReviewForMovie(int userId, int movieId) async {
    try {
      final review = await _reviewsRemoteDataSource.getUserReviewForMovie(userId, movieId);
      return Right(review);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, Unit>> addReview({
    required int userId,
    required int movieId,
    required double rating,
    String? reviewText,
    required String title,
    String? posterPath,
    double? voteAverage,
    String? releaseDate,
  }) async {
    try {
      await _reviewsRemoteDataSource.addReview(
        userId: userId,
        movieId: movieId,
        rating: rating,
        reviewText: reviewText,
        title: title,
        posterPath: posterPath,
        voteAverage: voteAverage,
        releaseDate: releaseDate,
      );
      return const Right(unit);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateReview({
    required int reviewId,
    double? rating,
    String? reviewText,
  }) async {
    try {
      await _reviewsRemoteDataSource.updateReview(
        reviewId: reviewId,
        rating: rating,
        reviewText: reviewText,
      );
      return const Right(unit);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteReview(int reviewId) async {
    try {
      await _reviewsRemoteDataSource.deleteReview(reviewId);
      return const Right(unit);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}
