part of 'watchlist_bloc.dart';

class WatchlistState extends Equatable {
  final bool isBookmarked;
  final List<Media> items;
  final WatchlistRequestStatus status;
  final BookmarkStatus actionStatus;
  final String message;

  const WatchlistState({
    this.isBookmarked = false,
    this.items = const [],
    this.status = WatchlistRequestStatus.loading,
    this.actionStatus = BookmarkStatus.none,
    this.message = '',
  });

  WatchlistState copyWith({
    bool? isBookmarked,
    List<Media>? items,
    WatchlistRequestStatus? status,
    BookmarkStatus? actionStatus,
    String? message,
  }) {
    return WatchlistState(
      isBookmarked: isBookmarked ?? this.isBookmarked,
      items: items ?? this.items,
      status: status ?? this.status,
      actionStatus: actionStatus ?? BookmarkStatus.none,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [isBookmarked, items, status, actionStatus, message];
}
