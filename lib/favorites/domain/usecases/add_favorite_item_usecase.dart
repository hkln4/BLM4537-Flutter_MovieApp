import 'package:dartz/dartz.dart';
import 'package:movies_app/core/domain/entities/media.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/favorites/domain/repository/favorites_repository.dart';

class AddFavoriteItemParams {
  final Media media;
  final int userId;

  AddFavoriteItemParams({required this.media, required this.userId});
}

class AddFavoriteItemUseCase {
  final FavoritesRepository _favoritesRepository;

  AddFavoriteItemUseCase(this._favoritesRepository);

  Future<Either<Failure, Unit>> call(AddFavoriteItemParams params) async {
    return await _favoritesRepository.addFavoriteItem(params.media, params.userId);
  }
}
