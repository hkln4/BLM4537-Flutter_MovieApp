part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();
}

class GetFavoriteItemsEvent extends FavoritesEvent {
  final int userId;

  const GetFavoriteItemsEvent({required this.userId});

  @override
  List<Object?> get props => [userId];
}

class AddFavoriteItemEvent extends FavoritesEvent {
  final Media media;
  final int userId;

  const AddFavoriteItemEvent({required this.media, required this.userId});

  @override
  List<Object?> get props => [media, userId];
}

class RemoveFavoriteItemEvent extends FavoritesEvent {
  final int movieId;
  final int userId;

  const RemoveFavoriteItemEvent({required this.movieId, required this.userId});

  @override
  List<Object?> get props => [movieId, userId];
}

class CheckFavoriteEvent extends FavoritesEvent {
  final int tmdbId;
  final int userId;

  const CheckFavoriteEvent({required this.tmdbId, required this.userId});

  @override
  List<Object?> get props => [tmdbId, userId];
}
