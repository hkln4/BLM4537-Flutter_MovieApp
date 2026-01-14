import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/core/utils/enums.dart';
import 'package:movies_app/reviews/data/models/user_review_model.dart';
import 'package:movies_app/reviews/domain/usecases/add_review_usecase.dart';
import 'package:movies_app/reviews/domain/usecases/delete_review_usecase.dart';
import 'package:movies_app/reviews/domain/usecases/get_movie_reviews_usecase.dart';
import 'package:movies_app/reviews/domain/usecases/get_user_reviews_usecase.dart';
import 'package:movies_app/reviews/domain/usecases/update_review_usecase.dart';

part 'reviews_event.dart';
part 'reviews_state.dart';

class ReviewsBloc extends Bloc<ReviewsEvent, ReviewsState> {
  ReviewsBloc(
    this._getUserReviewsUseCase,
    this._getMovieReviewsUseCase,
    this._addReviewUseCase,
    this._updateReviewUseCase,
    this._deleteReviewUseCase,
  ) : super(const ReviewsState()) {
    on<GetUserReviewsEvent>(_getUserReviews);
    on<GetMovieReviewsEvent>(_getMovieReviews);
    on<AddReviewEvent>(_addReview);
    on<UpdateReviewEvent>(_updateReview);
    on<DeleteReviewEvent>(_deleteReview);
  }

  final GetUserReviewsUseCase _getUserReviewsUseCase;
  final GetMovieReviewsUseCase _getMovieReviewsUseCase;
  final AddReviewUseCase _addReviewUseCase;
  final UpdateReviewUseCase _updateReviewUseCase;
  final DeleteReviewUseCase _deleteReviewUseCase;

  Future<void> _getUserReviews(
    GetUserReviewsEvent event,
    Emitter<ReviewsState> emit,
  ) async {
    emit(const ReviewsState(status: ReviewsRequestStatus.loading));

    final result = await _getUserReviewsUseCase.call(event.userId);

    result.fold(
      (l) => emit(
        ReviewsState(
          status: ReviewsRequestStatus.error,
          message: l.message,
        ),
      ),
      (r) {
        if (r.isEmpty) {
          emit(const ReviewsState(status: ReviewsRequestStatus.empty));
        } else {
          emit(ReviewsState(status: ReviewsRequestStatus.loaded, reviews: r));
        }
      },
    );
  }

  Future<void> _getMovieReviews(
    GetMovieReviewsEvent event,
    Emitter<ReviewsState> emit,
  ) async {
    emit(const ReviewsState(status: ReviewsRequestStatus.loading));

    final result = await _getMovieReviewsUseCase.call(event.movieId);

    result.fold(
      (l) => emit(
        ReviewsState(
          status: ReviewsRequestStatus.error,
          message: l.message,
        ),
      ),
      (r) {
        if (r.isEmpty) {
          emit(const ReviewsState(status: ReviewsRequestStatus.empty));
        } else {
          emit(ReviewsState(status: ReviewsRequestStatus.loaded, reviews: r));
        }
      },
    );
  }

  Future<void> _addReview(
    AddReviewEvent event,
    Emitter<ReviewsState> emit,
  ) async {
    emit(const ReviewsState(status: ReviewsRequestStatus.loading));

    final result = await _addReviewUseCase.call(
      AddReviewParams(
        userId: event.userId,
        movieId: event.movieId,
        rating: event.rating,
        reviewText: event.reviewText,
        title: event.title,
        posterPath: event.posterPath,
        voteAverage: event.voteAverage,
        releaseDate: event.releaseDate,
      ),
    );

    result.fold(
      (l) => emit(
        ReviewsState(
          status: ReviewsRequestStatus.error,
          message: l.message,
        ),
      ),
      (r) => emit(const ReviewsState(actionStatus: ReviewActionStatus.added)),
    );
  }

  Future<void> _updateReview(
    UpdateReviewEvent event,
    Emitter<ReviewsState> emit,
  ) async {
    emit(const ReviewsState(status: ReviewsRequestStatus.loading));

    final result = await _updateReviewUseCase.call(
      UpdateReviewParams(
        reviewId: event.reviewId,
        rating: event.rating,
        reviewText: event.reviewText,
      ),
    );

    result.fold(
      (l) => emit(
        ReviewsState(
          status: ReviewsRequestStatus.error,
          message: l.message,
        ),
      ),
      (r) => emit(const ReviewsState(actionStatus: ReviewActionStatus.updated)),
    );
  }

  Future<void> _deleteReview(
    DeleteReviewEvent event,
    Emitter<ReviewsState> emit,
  ) async {
    emit(const ReviewsState(status: ReviewsRequestStatus.loading));

    final result = await _deleteReviewUseCase.call(event.reviewId);

    result.fold(
      (l) => emit(
        ReviewsState(
          status: ReviewsRequestStatus.error,
          message: l.message,
        ),
      ),
      (r) => emit(const ReviewsState(actionStatus: ReviewActionStatus.deleted)),
    );
  }
}
