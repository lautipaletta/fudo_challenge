import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fudo_challenge/config/routes/app_routes.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((_) {
  return GoRouter(
    initialLocation: AppRoutes.splash.path,
    routes: [
      GoRoute(
        name: AppRoutes.splash.name,
        path: AppRoutes.splash.path,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: AppRoutes.login.name,
        path: AppRoutes.login.path,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        name: AppRoutes.posts.name,
        path: AppRoutes.posts.path,
        builder: (context, state) => const PostsScreen(),
      ),
    ],
  );
});
