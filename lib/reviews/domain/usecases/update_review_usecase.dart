import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/reviews/domain/repository/reviews_repository.dart';

class UpdateReviewParams {
  final int reviewId;
  final double? rating;
  final String? reviewText;

  UpdateReviewParams({
    required this.reviewId,
    this.rating,
    this.reviewText,
  });
}

class UpdateReviewUseCase {
  final ReviewsRepository _reviewsRepository;

  UpdateReviewUseCase(this._reviewsRepository);

  Future<Either<Failure, Unit>> call(UpdateReviewParams params) async {
    return await _reviewsRepository.updateReview(
      reviewId: params.reviewId,
      rating: params.rating,
      reviewText: params.reviewText,
    );
  }
}
