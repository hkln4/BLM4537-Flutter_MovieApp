import 'package:dartz/dartz.dart';
import 'package:movies_app/core/domain/entities/media.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/favorites/domain/repository/favorites_repository.dart';

class GetFavoriteItemsUseCase {
  final FavoritesRepository _favoritesRepository;

  GetFavoriteItemsUseCase(this._favoritesRepository);

  Future<Either<Failure, List<Media>>> call(int userId) async {
    return await _favoritesRepository.getFavoriteItems(userId);
  }
}
