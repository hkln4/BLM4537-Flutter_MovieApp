import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';
import 'package:movies_app/core/domain/entities/media.dart';
import 'package:movies_app/core/presentation/components/custom_app_bar.dart';
import 'package:movies_app/core/presentation/components/error_screen.dart';
import 'package:movies_app/core/presentation/components/loading_indicator.dart';
import 'package:movies_app/core/presentation/components/vertical_listview_card.dart';
import 'package:movies_app/core/resources/app_strings.dart';
import 'package:movies_app/core/resources/app_values.dart';
import 'package:movies_app/core/resources/app_routes.dart';
import 'package:movies_app/core/services/service_locator.dart';
import 'package:movies_app/core/utils/enums.dart';
import 'package:movies_app/profile/presentation/controllers/profile_cubit.dart';
import 'package:movies_app/watchlist/presentation/components/empty_watchlist_text.dart';
import 'package:movies_app/watchlist/presentation/controllers/watchlist_bloc/watchlist_bloc.dart';

class WatchlistView extends StatelessWidget {
  const WatchlistView({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<ProfileCubit>().state;

    if (profile == null) {
      return Scaffold(
        appBar: const CustomAppBar(title: AppStrings.watchlist),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.person_outline, size: 80, color: Colors.grey),
              const SizedBox(height: 24),
              const Text(
                'Kaydedilenleri görmek için lütfen giriş yap.',
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
          sl<WatchlistBloc>()
            ..add(GetWatchListItemsEvent(userId: profile.userId)),
      child: Scaffold(
        appBar: const CustomAppBar(title: AppStrings.watchlist),
        body: BlocBuilder<WatchlistBloc, WatchlistState>(
          builder: (context, state) {
            if (state.status == WatchlistRequestStatus.loading) {
              return const LoadingIndicator();
            } else if (state.status == WatchlistRequestStatus.loaded) {
              return WatchlistWidget(
                items: state.items,
                userId: profile.userId,
              );
            } else if (state.status == WatchlistRequestStatus.empty) {
              return const EmptyWatchlistText();
            } else {
              return ErrorScreen(
                onTryAgainPressed: () {
                  context.read<WatchlistBloc>().add(
                    GetWatchListItemsEvent(userId: profile.userId),
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

class WatchlistWidget extends StatelessWidget {
  const WatchlistWidget({super.key, required this.items, required this.userId});

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
