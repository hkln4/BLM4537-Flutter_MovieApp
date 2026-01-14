import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/core/domain/entities/media.dart';

abstract class FavoritesRepository {
  Future<Either<Failure, List<Media>>> getFavoriteItems(int userId);
  Future<Either<Failure, Unit>> addFavoriteItem(Media media, int userId);
  Future<Either<Failure, Unit>> removeFavoriteItem(int movieId, int userId);
  Future<Either<Failure, bool>> isFavorite(int tmdbId, int userId);
}
