import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fudo_challenge/config/routes/app_routes.dart';
import 'package:fudo_challenge/features/auth/di/providers.dart';
import 'package:fudo_challenge/features/auth/presentation/ui/screens/login_screen.dart';
import 'package:fudo_challenge/features/posts/presentation/ui/screens/create_post_screen.dart';
import 'package:fudo_challenge/features/posts/presentation/ui/screens/posts_screen.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.login.path,
    redirect: (context, state) {
      final authState = ref.read(authProvider).value;
      final isAuthenticated = authState?.isAuthenticated ?? false;
      final isGoingToLogin = state.matchedLocation == AppRoutes.login.path;

      if (!isAuthenticated && !isGoingToLogin) {
        return AppRoutes.login.path;
      }

      if (isAuthenticated && isGoingToLogin) {
        return AppRoutes.posts.path;
      }

      return null;
    },
    routes: [
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
      GoRoute(
        name: AppRoutes.createPost.name,
        path: AppRoutes.createPost.path,
        builder: (context, state) => const CreatePostScreen(),
      ),
    ],
  );
});
