import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';
import 'package:movies_app/core/domain/entities/media.dart';
import 'package:movies_app/core/presentation/components/custom_app_bar.dart';
import 'package:movies_app/core/presentation/components/error_screen.dart';
import 'package:movies_app/core/presentation/components/loading_indicator.dart';
import 'package:movies_app/core/presentation/components/vertical_listview_card.dart';
import 'package:movies_app/core/resources/app_values.dart';
import 'package:movies_app/core/resources/app_routes.dart';
import 'package:movies_app/core/services/service_locator.dart';
import 'package:movies_app/core/utils/enums.dart';
import 'package:movies_app/profile/presentation/controllers/profile_cubit.dart';
import 'package:movies_app/favorites/presentation/controllers/favorites_bloc/favorites_bloc.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<ProfileCubit>().state;

    if (profile == null) {
      return Scaffold(
        appBar: const CustomAppBar(title: 'Favorilerim'),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.favorite_border, size: 80, color: Colors.grey),
              const SizedBox(height: 24),
              const Text(
                'Favorileri görmek için lütfen giriş yap.',
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
          sl<FavoritesBloc>()
            ..add(GetFavoriteItemsEvent(userId: profile.userId)),
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Favorilerim'),
        body: BlocBuilder<FavoritesBloc, FavoritesState>(
          builder: (context, state) {
            if (state.status == FavoritesRequestStatus.loading) {
              return const LoadingIndicator();
            } else if (state.status == FavoritesRequestStatus.loaded) {
              return FavoritesWidget(
                items: state.items,
                userId: profile.userId,
              );
            } else if (state.status == FavoritesRequestStatus.empty) {
              return const EmptyFavoritesText();
            } else {
              return ErrorScreen(
                onTryAgainPressed: () {
                  context.read<FavoritesBloc>().add(
                    GetFavoriteItemsEvent(userId: profile.userId),
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

class FavoritesWidget extends StatelessWidget {
  const FavoritesWidget({super.key, required this.items, required this.userId});

  final List<Media> items;
  final int userId;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p12,
        vertical: AppPadding.p6,
      ),
      itemBuilder: (context, index) {
        return VerticalListViewCard(media: items[index]);
      },
      separatorBuilder: (context, index) => const SizedBox(height: AppSize.s10),
    );
  }
}

class EmptyFavoritesText extends StatelessWidget {
  const EmptyFavoritesText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'Henüz favori filminiz yok',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Beğendiğiniz filmleri favorilere ekleyin',
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
