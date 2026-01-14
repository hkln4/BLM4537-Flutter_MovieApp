import 'package:dio/dio.dart';
import 'package:movies_app/core/error/exceptions.dart';
import 'package:movies_app/core/network/error_message_model.dart';
import 'package:movies_app/reviews/data/models/user_review_model.dart';

abstract class ReviewsRemoteDataSource {
  Future<List<UserReviewModel>> getUserReviews(int userId);
  Future<List<UserReviewModel>> getMovieReviews(int movieId);
  Future<UserReviewModel?> getUserReviewForMovie(int userId, int movieId);
  Future<void> addReview({
    required int userId,
    required int movieId,
    required double rating,
    String? reviewText,
    required String title,
    String? posterPath,
    double? voteAverage,
    String? releaseDate,
  });
  Future<void> updateReview({
    required int reviewId,
    double? rating,
    String? reviewText,
  });
  Future<void> deleteReview(int reviewId);
}

class ReviewsRemoteDataSourceImpl extends ReviewsRemoteDataSource {
  static const String _baseUrl = 'http://127.0.0.1:5000';
  final Dio _dio;

  ReviewsRemoteDataSourceImpl(this._dio);

  @override
  Future<List<UserReviewModel>> getUserReviews(int userId) async {
    try {
      final response = await _dio.get('$_baseUrl/reviews/user/$userId');
      if (response.statusCode == 200) {
        return List<UserReviewModel>.from(
          (response.data as List).map((e) => UserReviewModel.fromJson(e)),
        );
      } else {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } catch (e) {
      throw ServerException(
        errorMessageModel: ErrorMessageModel(
          statusCode: 500,
          statusMessage: e.toString(),
          success: false,
        ),
      );
    }
  }

  @override
  Future<List<UserReviewModel>> getMovieReviews(int movieId) async {
    try {
      final response = await _dio.get('$_baseUrl/reviews/movie/$movieId');
      if (response.statusCode == 200) {
        return List<UserReviewModel>.from(
          (response.data as List).map((e) => UserReviewModel.fromJson(e)),
        );
      } else {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } catch (e) {
      throw ServerException(
        errorMessageModel: ErrorMessageModel(
          statusCode: 500,
          statusMessage: e.toString(),
          success: false,
        ),
      );
    }
  }

  @override
  Future<UserReviewModel?> getUserReviewForMovie(int userId, int movieId) async {
    try {
      final reviews = await getMovieReviews(movieId);
      final userReview = reviews.where((r) => r.userId == userId).toList();
      return userReview.isNotEmpty ? userReview.first : null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> addReview({
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
      final response = await _dio.post(
        '$_baseUrl/reviews/add',
        data: {
          'user_id': userId,
          'movie_id': movieId,
          'rating': rating,
          'review_text': reviewText,
          'title': title,
          'poster_path': posterPath,
          'vote_average': voteAverage,
          'release_date': releaseDate,
        },
      );
      if (response.statusCode != 201) {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } catch (e) {
      throw ServerException(
        errorMessageModel: ErrorMessageModel(
          statusCode: 500,
          statusMessage: e.toString(),
          success: false,
        ),
      );
    }
  }

  @override
  Future<void> updateReview({
    required int reviewId,
    double? rating,
    String? reviewText,
  }) async {
    try {
      final response = await _dio.put(
        '$_baseUrl/reviews/$reviewId',
        data: {
          if (rating != null) 'rating': rating,
          if (reviewText != null) 'review_text': reviewText,
        },
      );

      if (response.statusCode != 200) {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } catch (e) {
      throw ServerException(
        errorMessageModel: ErrorMessageModel(
          statusCode: 500,
          statusMessage: e.toString(),
          success: false,
        ),
      );
    }
  }

  @override
  Future<void> deleteReview(int reviewId) async {
    try {
      final response = await _dio.delete('$_baseUrl/reviews/$reviewId');

      if (response.statusCode != 200) {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } catch (e) {
      throw ServerException(
        errorMessageModel: ErrorMessageModel(
          statusCode: 500,
          statusMessage: e.toString(),
          success: false,
        ),
      );
    }
  }
}
