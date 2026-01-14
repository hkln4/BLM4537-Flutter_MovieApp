import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/core/domain/usecase/base_use_case.dart';
import 'package:movies_app/watchlist/domain/repository/watchlist_repository.dart';

class RemoveWatchlistItemParams {
  final int movieId;
  final int userId;

  RemoveWatchlistItemParams({required this.movieId, required this.userId});
}

class RemoveWatchlistItemUseCase extends BaseUseCase<Unit, RemoveWatchlistItemParams> {
  final WatchlistRepository _watchlistRepository;

  RemoveWatchlistItemUseCase(this._watchlistRepository);

  @override
  Future<Either<Failure, Unit>> call(RemoveWatchlistItemParams p) async {
    return await _watchlistRepository.removeWatchListItem(p.movieId, p.userId);
  }
}
