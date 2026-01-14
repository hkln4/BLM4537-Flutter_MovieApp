import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/favorites/domain/repository/favorites_repository.dart';

class IsFavoriteParams {
  final int tmdbId;
  final int userId;

  IsFavoriteParams({required this.tmdbId, required this.userId});
}

class IsFavoriteUseCase {
  final FavoritesRepository _favoritesRepository;

  IsFavoriteUseCase(this._favoritesRepository);

  Future<Either<Failure, bool>> call(IsFavoriteParams params) async {
    return await _favoritesRepository.isFavorite(params.tmdbId, params.userId);
  }
}
