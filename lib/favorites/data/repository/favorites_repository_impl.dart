import 'package:movies_app/core/domain/entities/media.dart';
import 'package:movies_app/core/error/exceptions.dart';
import 'package:movies_app/favorites/data/datasource/favorites_remote_data_source.dart';
import 'package:movies_app/favorites/data/models/favorite_item_model.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_app/favorites/domain/repository/favorites_repository.dart';

class FavoritesRepositoryImpl extends FavoritesRepository {
  final FavoritesRemoteDataSource _favoritesRemoteDataSource;

  FavoritesRepositoryImpl(this._favoritesRemoteDataSource);

  @override
  Future<Either<Failure, List<Media>>> getFavoriteItems(int userId) async {
    try {
      final models = await _favoritesRemoteDataSource.getFavoriteItems(userId);
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
  Future<Either<Failure, Unit>> addFavoriteItem(Media media, int userId) async {
    try {
      final model = FavoriteItemModel.fromEntity(media, userId);
      await _favoritesRemoteDataSource.addFavoriteItem(model);
      return const Right(unit);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, Unit>> removeFavoriteItem(int movieId, int userId) async {
    try {
      await _favoritesRemoteDataSource.removeFavoriteItem(movieId, userId);
      return const Right(unit);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, bool>> isFavorite(int tmdbId, int userId) async {
    try {
      final result = await _favoritesRemoteDataSource.isFavorite(
        tmdbId,
        userId,
      );
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}
