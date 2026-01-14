import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/reviews/domain/repository/reviews_repository.dart';

class DeleteReviewUseCase {
  final ReviewsRepository _reviewsRepository;

  DeleteReviewUseCase(this._reviewsRepository);

  Future<Either<Failure, Unit>> call(int reviewId) async {
    return await _reviewsRepository.deleteReview(reviewId);
  }
}
