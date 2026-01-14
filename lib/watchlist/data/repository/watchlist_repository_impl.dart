import 'package:movies_app/core/domain/entities/media.dart';
import 'package:movies_app/core/error/exceptions.dart';
import 'package:movies_app/watchlist/data/datasource/watchlist_remote_data_source.dart';
import 'package:movies_app/watchlist/data/models/watchlist_item_model.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_app/watchlist/domain/repository/watchlist_repository.dart';

class WatchListRepositoryImpl extends WatchlistRepository {
  final WatchlistRemoteDataSource _watchlistRemoteDataSource;

  WatchListRepositoryImpl(this._watchlistRemoteDataSource);

  @override
  Future<Either<Failure, List<Media>>> getWatchListItems(int userId) async {
    try {
      final models = await _watchlistRemoteDataSource.getWatchListItems(userId);
      final entities = models
          .map((model) => model.toEntity())
          .toList()
          .reversed
          .toList();
      return Right(entities);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, Unit>> addWatchListItem(Media media, int userId) async {
    try {
      final model = WatchlistItemModel.fromEntity(media, userId);
      await _watchlistRemoteDataSource.addWatchListItem(model);
      return const Right(unit);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, Unit>> removeWatchListItem(int movieId, int userId) async {
    try {
      await _watchlistRemoteDataSource.removeWatchListItem(movieId, userId);
      return const Right(unit);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, bool>> isBookmarked(int tmdbId, int userId) async {
    try {
      final result = await _watchlistRemoteDataSource.isBookmarked(
        tmdbId,
        userId,
      );
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}
