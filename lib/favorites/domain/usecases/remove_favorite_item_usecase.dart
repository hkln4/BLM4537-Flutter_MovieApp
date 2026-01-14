import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/favorites/domain/repository/favorites_repository.dart';

class RemoveFavoriteItemParams {
  final int movieId;
  final int userId;

  RemoveFavoriteItemParams({required this.movieId, required this.userId});
}

class RemoveFavoriteItemUseCase {
  final FavoritesRepository _favoritesRepository;

  RemoveFavoriteItemUseCase(this._favoritesRepository);

  Future<Either<Failure, Unit>> call(RemoveFavoriteItemParams params) async {
    return await _favoritesRepository.removeFavoriteItem(params.movieId, params.userId);
  }
}
