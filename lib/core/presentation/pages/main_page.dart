import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/core/resources/app_routes.dart';
import 'package:movies_app/core/resources/app_strings.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.child});

  final Widget child;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            label: AppStrings.movies,
            icon: Icon(Icons.movie_creation_rounded),
          ),
          BottomNavigationBarItem(
            label: AppStrings.shows,
            icon: Icon(Icons.tv_rounded),
          ),
          BottomNavigationBarItem(
            label: AppStrings.search,
            icon: Icon(Icons.search_rounded),
          ),
          BottomNavigationBarItem(
            label: AppStrings.watchlist,
            icon: Icon(Icons.bookmark_rounded),
          ),
          BottomNavigationBarItem(
            label: AppStrings.profile,
            icon: Icon(Icons.person),
          ),
        ],
        currentIndex: _getSelectedIndex(context),
        onTap: (index) => _onItemTapped(index, context),
      ),
    );
  }

  int _getSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/movies')) return 0;
    if (location.startsWith('/tvShows')) return 1;
    if (location.startsWith('/search')) return 2;
    if (location.startsWith('/watchlist')) return 3;
    if (location.startsWith('/profile')) return 4;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.goNamed(AppRoutes.moviesRoute);
        break;
      case 1:
        context.goNamed(AppRoutes.tvShowsRoute);
        break;
      case 2:
        context.goNamed(AppRoutes.searchRoute);
        break;
      case 3:
        context.goNamed(AppRoutes.watchlistRoute);
        break;
      case 4:
        context.goNamed(AppRoutes.profileRoute);
        break;
    }
  }
}
