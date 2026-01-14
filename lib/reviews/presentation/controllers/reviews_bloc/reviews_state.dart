part of 'reviews_bloc.dart';

class ReviewsState extends Equatable {
  final List<UserReviewModel> reviews;
  final ReviewsRequestStatus status;
  final ReviewActionStatus actionStatus;
  final String message;

  const ReviewsState({
    this.reviews = const [],
    this.status = ReviewsRequestStatus.loading,
    this.actionStatus = ReviewActionStatus.none,
    this.message = '',
  });

  ReviewsState copyWith({
    List<UserReviewModel>? reviews,
    ReviewsRequestStatus? status,
    ReviewActionStatus? actionStatus,
    String? message,
  }) {
    return ReviewsState(
      reviews: reviews ?? this.reviews,
      status: status ?? this.status,
      actionStatus: actionStatus ?? ReviewActionStatus.none,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [reviews, status, actionStatus, message];
}
