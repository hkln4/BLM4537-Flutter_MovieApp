import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../controllers/profile_cubit.dart';
import 'package:movies_app/core/resources/app_routes.dart';

class ProfilePage extends StatelessWidget {
  static const String routeName = '/profile';

  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: Center(
        child: BlocBuilder<ProfileCubit, dynamic>(
          builder: (context, profile) {
            if (profile == null) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.person_outline,
                    size: 100,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Film Uygulamasına Hoşgeldiniz',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Devam etmek için lütfen kaydol veya giriş yap',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () => context.pushNamed(AppRoutes.loginRoute),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 48,
                        vertical: 16,
                      ),
                    ),
                    child: const Text('Giriş yap'),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: () => context.pushNamed(AppRoutes.registerRoute),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 48,
                        vertical: 16,
                      ),
                    ),
                    child: const Text('Kaydol'),
                  ),
                ],
              );
            } else {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: profile.avatarUrl != null
                          ? NetworkImage(profile.avatarUrl!)
                          : null,
                      child: profile.avatarUrl == null
                          ? const Icon(Icons.person, size: 50)
                          : null,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      profile.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      profile.email,
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Kullanıcı ID: ${profile.userId}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 32),
                    // Watchlist Card
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.bookmark, color: Colors.blue),
                        title: const Text('Kaydedilenlerim'),
                        subtitle: const Text('İzleme listesi'),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          context.pushNamed(AppRoutes.watchlistRoute);
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Favorites Card
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.favorite, color: Colors.red),
                        title: const Text('Favorilerim'),
                        subtitle: const Text('Beğenilen filmler'),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          context.pushNamed(AppRoutes.favoritesRoute);
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    // My Reviews Card
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.rate_review, color: Colors.amber),
                        title: const Text('Değerlendirmelerim'),
                        subtitle: const Text('Film yorumlarım'),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          context.pushNamed(AppRoutes.myReviewsRoute);
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          context.read<ProfileCubit>().logout();
                        },
                        icon: const Icon(Icons.logout),
                        label: const Text('Çıkış Yap'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

