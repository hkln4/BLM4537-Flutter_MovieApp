import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:movies_app/core/config/env.dart';
import 'package:movies_app/movies/data/datasource/movies_remote_data_source.dart';
import 'package:movies_app/movies/data/repository/movies_repository_impl.dart';
import 'package:movies_app/movies/domain/repository/movies_repository.dart';
import 'package:movies_app/movies/domain/usecases/get_all_popular_movies_usecase.dart';
import 'package:movies_app/movies/domain/usecases/get_all_top_rated_movies_usecase.dart';
import 'package:movies_app/movies/domain/usecases/get_movie_details_usecase.dart';
import 'package:movies_app/movies/domain/usecases/get_movies_usecase.dart';
import 'package:movies_app/movies/presentation/controllers/popular_movies_bloc/popular_movies_bloc.dart';
import 'package:movies_app/movies/presentation/controllers/top_rated_movies_bloc/top_rated_movies_bloc.dart';
import 'package:movies_app/search/data/datasource/search_remote_data_source.dart';
import 'package:movies_app/search/data/repository/search_repository_impl.dart';
import 'package:movies_app/search/domain/repository/search_repository.dart';
import 'package:movies_app/search/domain/usecases/search_usecase.dart';
import 'package:movies_app/search/presentation/controllers/search_bloc/search_bloc.dart';
import 'package:movies_app/tv_shows/data/datasource/tv_shows_remote_data_source.dart';
import 'package:movies_app/tv_shows/data/repository/tv_shows_repository_impl.dart';
import 'package:movies_app/tv_shows/domain/repository/tv_shows_repository.dart';
import 'package:movies_app/tv_shows/domain/usecases/get_all_popular_tv_shows_usecase.dart';
import 'package:movies_app/tv_shows/domain/usecases/get_all_top_rated_tv_shows_usecase.dart';
import 'package:movies_app/tv_shows/domain/usecases/get_season_details_usecase.dart';
import 'package:movies_app/tv_shows/domain/usecases/get_tv_show_details_usecase.dart';
import 'package:movies_app/tv_shows/domain/usecases/get_tv_shows_usecase.dart';
import 'package:movies_app/tv_shows/presentation/controllers/popular_tv_shows_bloc/popular_tv_shows_bloc.dart';
import 'package:movies_app/tv_shows/presentation/controllers/top_rated_tv_shows_bloc/top_rated_tv_shows_bloc.dart';
import 'package:movies_app/tv_shows/presentation/controllers/tv_show_details_bloc/tv_show_details_bloc.dart';
import 'package:movies_app/tv_shows/presentation/controllers/tv_shows_bloc/tv_shows_bloc.dart';
import 'package:movies_app/movies/presentation/controllers/movie_details_bloc/movie_details_bloc.dart';
import 'package:movies_app/movies/presentation/controllers/movies_bloc/movies_bloc.dart';
import 'package:movies_app/watchlist/data/datasource/watchlist_remote_data_source.dart';

import 'package:movies_app/watchlist/data/repository/watchlist_repository_impl.dart';
import 'package:movies_app/watchlist/domain/repository/watchlist_repository.dart';
import 'package:movies_app/watchlist/domain/usecases/add_watchlist_item_usecase.dart';
import 'package:movies_app/watchlist/domain/usecases/is_bookmarked_usecase.dart';
import 'package:movies_app/watchlist/domain/usecases/get_watchlist_items_usecase.dart';
import 'package:movies_app/watchlist/domain/usecases/remove_watchlist_item_usecase.dart';
import 'package:movies_app/watchlist/presentation/controllers/watchlist_bloc/watchlist_bloc.dart';

// Favorites imports
import 'package:movies_app/favorites/data/datasource/favorites_remote_data_source.dart';
import 'package:movies_app/favorites/data/repository/favorites_repository_impl.dart';
import 'package:movies_app/favorites/domain/repository/favorites_repository.dart';
import 'package:movies_app/favorites/domain/usecases/add_favorite_item_usecase.dart';
import 'package:movies_app/favorites/domain/usecases/get_favorite_items_usecase.dart';
import 'package:movies_app/favorites/domain/usecases/is_favorite_usecase.dart';
import 'package:movies_app/favorites/domain/usecases/remove_favorite_item_usecase.dart';
import 'package:movies_app/favorites/presentation/controllers/favorites_bloc/favorites_bloc.dart';

// Reviews imports
import 'package:movies_app/reviews/data/datasource/reviews_remote_data_source.dart';
import 'package:movies_app/reviews/data/repository/reviews_repository_impl.dart';
import 'package:movies_app/reviews/domain/repository/reviews_repository.dart';
import 'package:movies_app/reviews/domain/usecases/add_review_usecase.dart';
import 'package:movies_app/reviews/domain/usecases/delete_review_usecase.dart';
import 'package:movies_app/reviews/domain/usecases/get_movie_reviews_usecase.dart';
import 'package:movies_app/reviews/domain/usecases/get_user_reviews_usecase.dart';
import 'package:movies_app/reviews/domain/usecases/update_review_usecase.dart';
import 'package:movies_app/reviews/presentation/controllers/reviews_bloc/reviews_bloc.dart';

final sl = GetIt.instance;

class ServiceLocator {
  ServiceLocator._();

  static void init() {
    sl.registerLazySingleton<Dio>(
      () => Dio(
        BaseOptions(
          baseUrl: Env.baseUrl,
          queryParameters: {'api_key': Env.apiKey},
        ),
      ),
    );

    // Data source
    sl.registerLazySingleton<MoviesRemoteDataSource>(
      () => MoviesRemoteDataSourceImpl(sl()),
    );
    sl.registerLazySingleton<TVShowsRemoteDataSource>(
      () => TVShowsRemoteDataSourceImpl(sl()),
    );
    sl.registerLazySingleton<WatchlistRemoteDataSource>(
      () => WatchlistRemoteDataSourceImpl(sl()),
    );
    sl.registerLazySingleton<SearchRemoteDataSource>(
      () => SearchRemoteDataSourceImpl(sl()),
    );
    sl.registerLazySingleton<FavoritesRemoteDataSource>(
      () => FavoritesRemoteDataSourceImpl(sl()),
    );
    sl.registerLazySingleton<ReviewsRemoteDataSource>(
      () => ReviewsRemoteDataSourceImpl(sl()),
    );


    // Repository
    sl.registerLazySingleton<MoviesRespository>(
      () => MoviesRepositoryImpl(sl()),
    );
    sl.registerLazySingleton<TVShowsRepository>(
      () => TVShowsRepositoryImpl(sl()),
    );
    sl.registerLazySingleton<SearchRepository>(
      () => SearchRepositoryImpl(sl()),
    );
    sl.registerLazySingleton<WatchlistRepository>(
      () => WatchListRepositoryImpl(sl()),
    );
    sl.registerLazySingleton<FavoritesRepository>(
      () => FavoritesRepositoryImpl(sl()),
    );
    sl.registerLazySingleton<ReviewsRepository>(
      () => ReviewsRepositoryImpl(sl()),
    );

    // Use Cases
    sl.registerLazySingleton(() => GetMoviesDetailsUseCase(sl()));
    sl.registerLazySingleton(() => GetMoviesUseCase(sl()));
    sl.registerLazySingleton(() => GetAllPopularMoviesUseCase(sl()));
    sl.registerLazySingleton(() => GetAllTopRatedMoviesUseCase(sl()));
    sl.registerLazySingleton(() => GetTVShowsUseCase(sl()));
    sl.registerLazySingleton(() => GetTVShowDetailsUseCase(sl()));
    sl.registerLazySingleton(() => GetSeasonDetailsUseCase(sl()));
    sl.registerLazySingleton(() => GetAllPopularTVShowsUseCase(sl()));
    sl.registerLazySingleton(() => GetAllTopRatedTVShowsUseCase(sl()));
    sl.registerLazySingleton(() => SearchUseCase(sl()));
    sl.registerLazySingleton(() => GetWatchlistItemsUseCase(sl()));
    sl.registerLazySingleton(() => AddWatchlistItemUseCase(sl()));
    sl.registerLazySingleton(() => RemoveWatchlistItemUseCase(sl()));
    sl.registerLazySingleton(() => IsBookmarkedUseCase(sl()));
    
    // Favorites Use Cases
    sl.registerLazySingleton(() => GetFavoriteItemsUseCase(sl()));
    sl.registerLazySingleton(() => AddFavoriteItemUseCase(sl()));
    sl.registerLazySingleton(() => RemoveFavoriteItemUseCase(sl()));
    sl.registerLazySingleton(() => IsFavoriteUseCase(sl()));
    
    // Reviews Use Cases
    sl.registerLazySingleton(() => GetUserReviewsUseCase(sl()));
    sl.registerLazySingleton(() => GetMovieReviewsUseCase(sl()));
    sl.registerLazySingleton(() => AddReviewUseCase(sl()));
    sl.registerLazySingleton(() => UpdateReviewUseCase(sl()));
    sl.registerLazySingleton(() => DeleteReviewUseCase(sl()));

    // Bloc
    sl.registerFactory(() => MoviesBloc(sl()));
    sl.registerFactory(() => MovieDetailsBloc(sl()));
    sl.registerFactory(() => PopularMoviesBloc(sl()));
    sl.registerFactory(() => TopRatedMoviesBloc(sl()));
    sl.registerFactory(() => TVShowsBloc(sl()));
    sl.registerFactory(() => TVShowDetailsBloc(sl(), sl()));
    sl.registerFactory(() => PopularTVShowsBloc(sl()));
    sl.registerFactory(() => TopRatedTVShowsBloc(sl()));
    sl.registerFactory(() => SearchBloc(sl()));
    sl.registerFactory(() => WatchlistBloc(sl(), sl(), sl(), sl()));
    sl.registerFactory(() => FavoritesBloc(sl(), sl(), sl(), sl()));
    sl.registerFactory(() => ReviewsBloc(sl(), sl(), sl(), sl(), sl()));
  }
}

