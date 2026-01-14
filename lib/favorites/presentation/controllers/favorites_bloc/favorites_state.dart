part of 'favorites_bloc.dart';

class FavoritesState extends Equatable {
  final bool isFavorite;
  final List<Media> items;
  final FavoritesRequestStatus status;
  final FavoriteStatus actionStatus;
  final String message;

  const FavoritesState({
    this.isFavorite = false,
    this.items = const [],
    this.status = FavoritesRequestStatus.loading,
    this.actionStatus = FavoriteStatus.none,
    this.message = '',
  });

  FavoritesState copyWith({
    bool? isFavorite,
    List<Media>? items,
    FavoritesRequestStatus? status,
    FavoriteStatus? actionStatus,
    String? message,
  }) {
    return FavoritesState(
      isFavorite: isFavorite ?? this.isFavorite,
      items: items ?? this.items,
      status: status ?? this.status,
      actionStatus: actionStatus ?? FavoriteStatus.none,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [isFavorite, items, status, actionStatus, message];
}
