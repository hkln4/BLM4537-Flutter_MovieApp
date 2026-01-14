import 'package:movies_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_app/core/domain/entities/media.dart';
import 'package:movies_app/core/domain/usecase/base_use_case.dart';
import 'package:movies_app/watchlist/domain/repository/watchlist_repository.dart';

class AddWatchlistItemParams {
  final Media media;
  final int userId;

  AddWatchlistItemParams({required this.media, required this.userId});
}

class AddWatchlistItemUseCase extends BaseUseCase<Unit, AddWatchlistItemParams> {
  final WatchlistRepository _watchlistRepository;

  AddWatchlistItemUseCase(this._watchlistRepository);

  @override
  Future<Either<Failure, Unit>> call(AddWatchlistItemParams p) async {
    return await _watchlistRepository.addWatchListItem(p.media, p.userId);
  }
}
