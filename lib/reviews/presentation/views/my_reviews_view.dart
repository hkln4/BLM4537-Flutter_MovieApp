import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/core/presentation/components/custom_app_bar.dart';
import 'package:movies_app/core/presentation/components/error_screen.dart';
import 'package:movies_app/core/presentation/components/loading_indicator.dart';
import 'package:movies_app/core/resources/app_values.dart';
import 'package:movies_app/core/resources/app_routes.dart';
import 'package:movies_app/core/services/service_locator.dart';
import 'package:movies_app/core/utils/enums.dart';
import 'package:movies_app/profile/presentation/controllers/profile_cubit.dart';
import 'package:movies_app/reviews/data/models/user_review_model.dart';
import 'package:movies_app/reviews/presentation/controllers/reviews_bloc/reviews_bloc.dart';
import 'package:movies_app/core/resources/app_colors.dart';

class MyReviewsView extends StatelessWidget {
  const MyReviewsView({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<ProfileCubit>().state;

    if (profile == null) {
      return Scaffold(
        appBar: const CustomAppBar(title: 'Değerlendirmelerim'),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.rate_review_outlined, size: 80, color: Colors.grey),
              const SizedBox(height: 24),
              const Text(
                'Değerlendirmelerini görmek için lütfen giriş yap.',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.pushNamed(AppRoutes.loginRoute),
                child: const Text('Giriş Yap'),
              ),
            ],
          ),
        ),
      );
    }

    return BlocProvider(
      create: (context) =>
          sl<ReviewsBloc>()
            ..add(GetUserReviewsEvent(userId: profile.userId)),
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Değerlendirmelerim'),
        body: BlocBuilder<ReviewsBloc, ReviewsState>(
          builder: (context, state) {
            if (state.status == ReviewsRequestStatus.loading) {
              return const LoadingIndicator();
            } else if (state.status == ReviewsRequestStatus.loaded) {
              return MyReviewsWidget(
                reviews: state.reviews,
                userId: profile.userId,
              );
            } else if (state.status == ReviewsRequestStatus.empty) {
              return const EmptyReviewsText();
            } else {
              return ErrorScreen(
                onTryAgainPressed: () {
                  context.read<ReviewsBloc>().add(
                    GetUserReviewsEvent(userId: profile.userId),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class MyReviewsWidget extends StatelessWidget {
  const MyReviewsWidget({super.key, required this.reviews, required this.userId});

  final List<UserReviewModel> reviews;
  final int userId;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: reviews.length,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p12,
        vertical: AppPadding.p6,
      ),
      itemBuilder: (context, index) {
        return MyReviewCard(review: reviews[index]);
      },
      separatorBuilder: (context, index) => const SizedBox(height: AppSize.s10),
    );
  }
}

class MyReviewCard extends StatelessWidget {
  const MyReviewCard({super.key, required this.review});

  final UserReviewModel review;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Movie Poster
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: review.posterPath != null && review.posterPath!.isNotEmpty
                  ? Image.network(
                      'https://image.tmdb.org/t/p/w200${review.posterPath}',
                      width: 80,
                      height: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          _buildPlaceholder(),
                    )
                  : _buildPlaceholder(),
            ),
            const SizedBox(width: 12),
            // Review Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review.movieTitle ?? 'Film',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: AppColors.ratingIconColor,
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        review.rating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text(
                        ' / 10',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  if (review.reviewText != null && review.reviewText!.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      review.reviewText!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const SizedBox(height: 8),
                  if (review.createdAt != null)
                    Text(
                      _formatDate(review.createdAt!),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      width: 80,
      height: 120,
      color: Colors.grey.shade800,
      child: const Icon(Icons.movie, size: 40, color: Colors.grey),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}.${date.month}.${date.year}';
  }
}

class EmptyReviewsText extends StatelessWidget {
  const EmptyReviewsText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.rate_review_outlined,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'Henüz değerlendirme yapmadınız',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'İzlediğiniz filmleri puanlayın',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}
