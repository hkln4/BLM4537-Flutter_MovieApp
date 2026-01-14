import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/reviews/data/models/user_review_model.dart';
import 'package:movies_app/reviews/domain/repository/reviews_repository.dart';

class GetUserReviewsUseCase {
  final ReviewsRepository _reviewsRepository;

  GetUserReviewsUseCase(this._reviewsRepository);

  Future<Either<Failure, List<UserReviewModel>>> call(int userId) async {
    return await _reviewsRepository.getUserReviews(userId);
  }
}
