import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fudo_challenge/config/routes/routes.dart';
import 'package:fudo_challenge/core/common/utils/debouncer.dart';
import 'package:fudo_challenge/core/common/widgets/fudo_loading.dart';
import 'package:fudo_challenge/core/common/widgets/fudo_text_field.dart';
import 'package:fudo_challenge/core/exceptions/fudo_exception.dart';
import 'package:fudo_challenge/features/auth/di/providers.dart';
import 'package:fudo_challenge/features/posts/di/providers.dart';
import 'package:go_router/go_router.dart';

class PostsScreen extends ConsumerStatefulWidget {
  const PostsScreen({super.key});

  @override
  ConsumerState<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends ConsumerState<PostsScreen> {
  final _debouncer = Debouncer(duration: const Duration(milliseconds: 500));
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _debouncer.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    final query = _searchController.text.trim();
    await ref.read(postsProvider.notifier).getPosts(query: query);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(postsProvider);

    ref.listen(authProvider, (previous, next) {
      if (next.hasValue && next.value?.isAuthenticated == false) {
        context.goNamed(AppRoutes.login.name);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(authProvider.notifier).logout(),
            tooltip: 'Logout',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed(AppRoutes.createPost.name),
        child: const Icon(Icons.draw),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FudoTextField(
                controller: _searchController,
                hintText: 'Search by author name',
                onChanged: (value) => _debouncer.run(() {
                  ref
                      .read(postsProvider.notifier)
                      .getPosts(query: value?.trim());
                }),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: state.when(
                  data: (value) => RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: value.isEmpty
                        ? const Center(child: Text('No posts found'))
                        : ListView.builder(
                            itemCount: value.length + 1,
                            itemBuilder: (context, index) {
                              if (index == value.length) {
                                return const SizedBox(height: 50);
                              }
                              return ListTile(
                                title: Text(
                                  'Post ${index + 1}: ${value[index].title}',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                subtitle: Text(
                                  value[index].body,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              );
                            },
                          ),
                  ),
                  error: (e, _) => RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.error,
                                color: Colors.red,
                                size: 48,
                              ),
                              const SizedBox(height: 16),
                              Text((e as FudoException).message),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  loading: () => const Center(child: FudoLoading()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
