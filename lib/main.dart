import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fudo_challenge/config/routes/routes.dart';
import 'package:fudo_challenge/features/auth/di/providers.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  runApp(const ProviderScope(child: App()));
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authProvider, (previous, next) {
      if (next.hasValue && next.value?.isAuthenticated == false) {
        context.goNamed(AppRoutes.login.name);
      }
    });

    return MaterialApp.router(
      title: 'Fudo Challenge',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      routerConfig: ref.read(routerProvider),
    );
  }
}
