import 'package:movies_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_app/core/domain/usecase/base_use_case.dart';
import 'package:movies_app/watchlist/domain/repository/watchlist_repository.dart';

class IsBookmarkedParams {
  final int tmdbId;
  final int userId;

  IsBookmarkedParams({required this.tmdbId, required this.userId});
}

class IsBookmarkedUseCase extends BaseUseCase<bool, IsBookmarkedParams> {
  final WatchlistRepository _watchlistRepository;

  IsBookmarkedUseCase(this._watchlistRepository);

  @override
  Future<Either<Failure, bool>> call(IsBookmarkedParams p) async {
    return await _watchlistRepository.isBookmarked(p.tmdbId, p.userId);
  }
}
