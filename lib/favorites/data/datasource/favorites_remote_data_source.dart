import 'package:dio/dio.dart';
import 'package:movies_app/core/error/exceptions.dart';
import 'package:movies_app/core/network/error_message_model.dart';
import 'package:movies_app/favorites/data/models/favorite_item_model.dart';

abstract class FavoritesRemoteDataSource {
  Future<List<FavoriteItemModel>> getFavoriteItems(int userId);
  Future<void> addFavoriteItem(FavoriteItemModel item);
  Future<void> removeFavoriteItem(int movieId, int userId);
  Future<bool> isFavorite(int tmdbID, int userId);
}

class FavoritesRemoteDataSourceImpl extends FavoritesRemoteDataSource {
  static const String _baseUrl = 'http://127.0.0.1:5000';
  final Dio _dio;

  FavoritesRemoteDataSourceImpl(this._dio);

  @override
  Future<List<FavoriteItemModel>> getFavoriteItems(int userId) async {
    try {
      final response = await _dio.get('$_baseUrl/favorites/$userId');
      if (response.statusCode == 200) {
        return List<FavoriteItemModel>.from(
          (response.data as List).map((e) => FavoriteItemModel.fromJson(e)),
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
  Future<void> addFavoriteItem(FavoriteItemModel item) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/favorites/add',
        data: {
          'user_id': item.userId,
          'movie_id': item.tmdbID,
          'title': item.title,
          'poster_path': item.posterUrl,
          'vote_average': item.voteAverage,
          'release_date': item.releaseDate,
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
  Future<void> removeFavoriteItem(int movieId, int userId) async {
    try {
      final response = await _dio.delete(
        '$_baseUrl/favorites/$userId/$movieId',
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
  Future<bool> isFavorite(int tmdbID, int userId) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/favorites/check',
        data: {'user_id': userId, 'movie_id': tmdbID},
      );
      if (response.statusCode == 200) {
        return response.data['is_in_favorites'] as bool;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
