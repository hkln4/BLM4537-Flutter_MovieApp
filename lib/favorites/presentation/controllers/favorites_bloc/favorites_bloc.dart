import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/core/domain/entities/media.dart';
import 'package:movies_app/core/utils/enums.dart';
import 'package:movies_app/favorites/domain/usecases/add_favorite_item_usecase.dart';
import 'package:movies_app/favorites/domain/usecases/is_favorite_usecase.dart';
import 'package:movies_app/favorites/domain/usecases/get_favorite_items_usecase.dart';
import 'package:movies_app/favorites/domain/usecases/remove_favorite_item_usecase.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc(
    this._getFavoriteItemsUseCase,
    this._addFavoriteItemUseCase,
    this._removeFavoriteItemUseCase,
    this._isFavoriteUseCase,
  ) : super(const FavoritesState()) {
    on<GetFavoriteItemsEvent>(_getFavoriteItems);
    on<AddFavoriteItemEvent>(_addFavoriteItem);
    on<RemoveFavoriteItemEvent>(_removeFavoriteItem);
    on<CheckFavoriteEvent>(_checkFavorite);
  }

  final GetFavoriteItemsUseCase _getFavoriteItemsUseCase;
  final AddFavoriteItemUseCase _addFavoriteItemUseCase;
  final RemoveFavoriteItemUseCase _removeFavoriteItemUseCase;
  final IsFavoriteUseCase _isFavoriteUseCase;

  Future<void> _getFavoriteItems(
    GetFavoriteItemsEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(const FavoritesState(status: FavoritesRequestStatus.loading));

    final result = await _getFavoriteItemsUseCase.call(event.userId);

    result.fold(
      (l) => emit(
        FavoritesState(
          status: FavoritesRequestStatus.error,
          message: l.message,
        ),
      ),
      (r) {
        if (r.isEmpty) {
          emit(const FavoritesState(status: FavoritesRequestStatus.empty));
        } else {
          emit(FavoritesState(status: FavoritesRequestStatus.loaded, items: r));
        }
      },
    );
  }

  Future<void> _addFavoriteItem(
    AddFavoriteItemEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(const FavoritesState(status: FavoritesRequestStatus.loading));

    final result = await _addFavoriteItemUseCase.call(
      AddFavoriteItemParams(media: event.media, userId: event.userId),
    );

    result.fold(
      (l) => emit(
        FavoritesState(
          status: FavoritesRequestStatus.error,
          message: l.message,
        ),
      ),
      (r) => emit(const FavoritesState(actionStatus: FavoriteStatus.added, isFavorite: true)),
    );
  }

  Future<void> _removeFavoriteItem(
    RemoveFavoriteItemEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(const FavoritesState(status: FavoritesRequestStatus.loading));

    final result = await _removeFavoriteItemUseCase.call(
      RemoveFavoriteItemParams(movieId: event.movieId, userId: event.userId),
    );

    result.fold(
      (l) => emit(
        FavoritesState(
          status: FavoritesRequestStatus.error,
          message: l.message,
        ),
      ),
      (r) => emit(const FavoritesState(actionStatus: FavoriteStatus.removed, isFavorite: false)),
    );
  }

  FutureOr<void> _checkFavorite(
    CheckFavoriteEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(const FavoritesState(status: FavoritesRequestStatus.loading));

    final result = await _isFavoriteUseCase.call(
      IsFavoriteParams(tmdbId: event.tmdbId, userId: event.userId),
    );

    result.fold(
      (l) => emit(
        FavoritesState(
          status: FavoritesRequestStatus.error,
          message: l.message,
        ),
      ),
      (r) => emit(FavoritesState(
        actionStatus: FavoriteStatus.exists,
        isFavorite: r,
      )),
    );
  }
}
