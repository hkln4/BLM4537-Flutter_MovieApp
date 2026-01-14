import 'package:movies_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_app/core/domain/entities/media.dart';
import 'package:movies_app/core/domain/usecase/base_use_case.dart';
import 'package:movies_app/watchlist/domain/repository/watchlist_repository.dart';

class GetWatchlistItemsUseCase extends BaseUseCase<List<Media>, int> {
  final WatchlistRepository _watchlistRepository;

  GetWatchlistItemsUseCase(this._watchlistRepository);

  @override
  Future<Either<Failure, List<Media>>> call(int userId) async {
    return await _watchlistRepository.getWatchListItems(userId);
  }
}
