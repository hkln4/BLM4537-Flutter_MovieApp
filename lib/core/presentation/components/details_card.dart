import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movies_app/core/domain/entities/media.dart';
import 'package:movies_app/core/domain/entities/media_details.dart';
import 'package:movies_app/core/presentation/components/slider_card_image.dart';
import 'package:movies_app/core/utils/enums.dart';
import 'package:movies_app/watchlist/presentation/controllers/watchlist_bloc/watchlist_bloc.dart';
import 'package:movies_app/favorites/presentation/controllers/favorites_bloc/favorites_bloc.dart';
import 'package:movies_app/profile/presentation/controllers/profile_cubit.dart';
import 'package:movies_app/core/resources/app_colors.dart';
import 'package:movies_app/core/resources/app_values.dart';
import 'package:movies_app/reviews/presentation/components/add_review_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsCard extends StatefulWidget {
  const DetailsCard({
    required this.mediaDetails,
    required this.detailsWidget,
    super.key,
  });

  final MediaDetails mediaDetails;
  final Widget detailsWidget;

  @override
  State<DetailsCard> createState() => _DetailsCardState();
}

class _DetailsCardState extends State<DetailsCard> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadUserIdAndCheckStatus();
  }

  void _loadUserIdAndCheckStatus() {
    final profile = context.read<ProfileCubit>().state;

    if (profile != null) {
      // Bookmark kontrolü yap
      context.read<WatchlistBloc>().add(
        CheckBookmarkEvent(
          tmdbId: widget.mediaDetails.tmdbID,
          userId: profile.userId,
        ),
      );
      // Favorite kontrolü yap
      context.read<FavoritesBloc>().add(
        CheckFavoriteEvent(
          tmdbId: widget.mediaDetails.tmdbID,
          userId: profile.userId,
        ),
      );
    }
  }

  void _toggleBookmark() {
    final profile = context.read<ProfileCubit>().state;

    if (profile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kaydetmek için lütfen giriş yapın'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    if (widget.mediaDetails.isBookmarked) {
      context.read<WatchlistBloc>().add(
        RemoveWatchListItemEvent(
          movieId: widget.mediaDetails.tmdbID,
          userId: profile.userId,
        ),
      );
    } else {
      context.read<WatchlistBloc>().add(
        AddWatchListItemEvent(
          media: Media.fromMediaDetails(widget.mediaDetails),
          userId: profile.userId,
        ),
      );
    }
  }

  void _toggleFavorite() {
    final profile = context.read<ProfileCubit>().state;

    if (profile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Favorilere eklemek için lütfen giriş yapın'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    if (_isFavorite) {
      context.read<FavoritesBloc>().add(
        RemoveFavoriteItemEvent(
          movieId: widget.mediaDetails.tmdbID,
          userId: profile.userId,
        ),
      );
    } else {
      context.read<FavoritesBloc>().add(
        AddFavoriteItemEvent(
          media: Media.fromMediaDetails(widget.mediaDetails),
          userId: profile.userId,
        ),
      );
    }
  }

  void _showReviewDialog() {
    showAddReviewDialog(context, widget.mediaDetails);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Stack(
        children: [
          SliderCardImage(imageUrl: widget.mediaDetails.backdropUrl),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
            child: SizedBox(
              height: size.height * 0.6,
              child: Padding(
                padding: const EdgeInsets.only(bottom: AppPadding.p8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.mediaDetails.title,
                            maxLines: 2,
                            style: textTheme.titleMedium,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: AppPadding.p4,
                              bottom: AppPadding.p6,
                            ),
                            child: widget.detailsWidget,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star_rate_rounded,
                                color: AppColors.ratingIconColor,
                                size: AppSize.s18,
                              ),
                              Text(
                                '${widget.mediaDetails.voteAverage} ',
                                style: textTheme.bodyMedium,
                              ),
                              Text(
                                widget.mediaDetails.voteCount,
                                style: textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (widget.mediaDetails.trailerUrl.isNotEmpty) ...[
                      InkWell(
                        onTap: () async {
                          final url = Uri.parse(widget.mediaDetails.trailerUrl);
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          }
                        },
                        child: Container(
                          height: AppSize.s40,
                          width: AppSize.s40,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.play_arrow_rounded,
                            color: AppColors.secondaryText,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
          // Top Action Buttons
          Padding(
            padding: const EdgeInsets.only(
              top: AppPadding.p12,
              left: AppPadding.p16,
              right: AppPadding.p16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back Button
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(AppPadding.p8),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.iconContainerColor,
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.secondaryText,
                      size: AppSize.s20,
                    ),
                  ),
                ),
                // Action Buttons Row
                Row(
                  children: [
                    // Rate Button
                    InkWell(
                      onTap: _showReviewDialog,
                      child: Container(
                        padding: const EdgeInsets.all(AppPadding.p8),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.iconContainerColor,
                        ),
                        child: const Icon(
                          Icons.rate_review_rounded,
                          color: AppColors.ratingIconColor,
                          size: AppSize.s20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Favorite Button
                    InkWell(
                      onTap: _toggleFavorite,
                      child: Container(
                        padding: const EdgeInsets.all(AppPadding.p8),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.iconContainerColor,
                        ),
                        child: BlocConsumer<FavoritesBloc, FavoritesState>(
                          listener: (context, state) {
                            final action = state.actionStatus;
                            if (action == FavoriteStatus.added) {
                              setState(() {
                                _isFavorite = true;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Favorilere eklendi'),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            } else if (action == FavoriteStatus.removed) {
                              setState(() {
                                _isFavorite = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Favorilerden çıkarıldı'),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            } else if (action == FavoriteStatus.exists) {
                              setState(() {
                                _isFavorite = state.isFavorite;
                              });
                            }
                          },
                          builder: (context, state) {
                            return Icon(
                              _isFavorite
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_border_rounded,
                              color: _isFavorite
                                  ? Colors.red
                                  : AppColors.secondaryText,
                              size: AppSize.s20,
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Bookmark Button
                    InkWell(
                      onTap: _toggleBookmark,
                      child: Container(
                        padding: const EdgeInsets.all(AppPadding.p8),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.iconContainerColor,
                        ),
                        child: BlocConsumer<WatchlistBloc, WatchlistState>(
                          listener: (context, state) {
                            final action = state.actionStatus;
                            if (action == BookmarkStatus.added) {
                              setState(() {
                                widget.mediaDetails.isBookmarked = true;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Listeye eklendi'),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            } else if (action == BookmarkStatus.removed) {
                              setState(() {
                                widget.mediaDetails.isBookmarked = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Listeden çıkarıldı'),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            } else if (action == BookmarkStatus.exists) {
                              setState(() {
                                widget.mediaDetails.isBookmarked = state.isBookmarked;
                              });
                            }
                          },
                          builder: (context, state) {
                            return Icon(
                              Icons.bookmark_rounded,
                              color: widget.mediaDetails.isBookmarked
                                  ? AppColors.primary
                                  : AppColors.secondaryText,
                              size: AppSize.s20,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

