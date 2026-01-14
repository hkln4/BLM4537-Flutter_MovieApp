part of 'watchlist_bloc.dart';

abstract class WatchlistEvent extends Equatable {
  const WatchlistEvent();
}

class GetWatchListItemsEvent extends WatchlistEvent {
  final int userId;

  const GetWatchListItemsEvent({required this.userId});

  @override
  List<Object?> get props => [userId];
}

class AddWatchListItemEvent extends WatchlistEvent {
  final Media media;
  final int userId;

  const AddWatchListItemEvent({required this.media, required this.userId});

  @override
  List<Object?> get props => [media, userId];
}

class RemoveWatchListItemEvent extends WatchlistEvent {
  final int movieId;
  final int userId;

  const RemoveWatchListItemEvent({required this.movieId, required this.userId});

  @override
  List<Object?> get props => [movieId, userId];
}

class CheckBookmarkEvent extends WatchlistEvent {
  final int tmdbId;
  final int userId;

  const CheckBookmarkEvent({required this.tmdbId, required this.userId});

  @override
  List<Object?> get props => [tmdbId, userId];
}
