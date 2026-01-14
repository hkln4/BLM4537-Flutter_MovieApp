import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/reviews/data/models/user_review_model.dart';
import 'package:movies_app/reviews/domain/repository/reviews_repository.dart';

class GetMovieReviewsUseCase {
  final ReviewsRepository _reviewsRepository;

  GetMovieReviewsUseCase(this._reviewsRepository);

  Future<Either<Failure, List<UserReviewModel>>> call(int movieId) async {
    return await _reviewsRepository.getMovieReviews(movieId);
  }
}
