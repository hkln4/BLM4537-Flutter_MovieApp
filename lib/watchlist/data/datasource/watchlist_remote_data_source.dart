import 'package:dio/dio.dart';
import 'package:movies_app/core/error/exceptions.dart';
import 'package:movies_app/core/network/error_message_model.dart';
import 'package:movies_app/watchlist/data/models/watchlist_item_model.dart';

abstract class WatchlistRemoteDataSource {
  Future<List<WatchlistItemModel>> getWatchListItems(int userId);
  Future<void> addWatchListItem(WatchlistItemModel item);
  Future<void> removeWatchListItem(int movieId, int userId);
  Future<bool> isBookmarked(int tmdbID, int userId);
}

class WatchlistRemoteDataSourceImpl extends WatchlistRemoteDataSource {
  // Backend URL'i buraya sabitliyoruz veya Env'den çekebiliriz.
  // Şimdilik localhost kullanıyoruz.
  static const String _baseUrl = 'http://127.0.0.1:5000';
  final Dio _dio;

  WatchlistRemoteDataSourceImpl(this._dio);

  @override
  Future<List<WatchlistItemModel>> getWatchListItems(int userId) async {
    try {
      final response = await _dio.get('$_baseUrl/watchlist/$userId');
      if (response.statusCode == 200) {
        return List<WatchlistItemModel>.from(
          (response.data as List).map((e) => WatchlistItemModel.fromJson(e)),
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
  Future<void> addWatchListItem(WatchlistItemModel item) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/watchlist/add',
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
  Future<void> removeWatchListItem(int movieId, int userId) async {
    try {
      // POST yerine DELETE kullanıyoruz
      final response = await _dio.delete(
        '$_baseUrl/watchlist/$userId/$movieId', // URL yapısı değişti
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
  Future<bool> isBookmarked(int tmdbID, int userId) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/watchlist/check',
        data: {'user_id': userId, 'movie_id': tmdbID},
      );
      if (response.statusCode == 200) {
        return response.data['is_in_watchlist'] as bool;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
