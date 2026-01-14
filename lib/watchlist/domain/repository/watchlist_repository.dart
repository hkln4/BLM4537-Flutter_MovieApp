import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/core/domain/entities/media.dart';

abstract class WatchlistRepository {
  Future<Either<Failure, List<Media>>> getWatchListItems(int userId);
  Future<Either<Failure, Unit>> addWatchListItem(Media media, int userId);
  Future<Either<Failure, Unit>> removeWatchListItem(int movieId, int userId);
  Future<Either<Failure, bool>> isBookmarked(int tmdbId, int userId);
}
