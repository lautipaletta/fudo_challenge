import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fudo_challenge/core/common/utils/debouncer.dart';
import 'package:fudo_challenge/core/common/widgets/fudo_loading.dart';
import 'package:fudo_challenge/core/common/widgets/fudo_text_field.dart';
import 'package:fudo_challenge/core/exceptions/fudo_exception.dart';
import 'package:fudo_challenge/features/posts/di/providers.dart';

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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(postsProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(postsProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.draw),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 48),
              Text(
                'Posts',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              FudoTextField(
                controller: _searchController,
                hintText: 'Search by author name',
                onChanged: (value) => _debouncer.run(() {
                  ref.read(postsProvider.notifier).getPosts(query: value);
                }),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: state.when(
                  data: (value) => ListView.builder(
                    itemCount: value.length + 1,
                    itemBuilder: (context, index) {
                      if (index == value.length) {
                        return const SizedBox(height: 50);
                      }
                      return ListTile(
                        title: Text(
                          'Post ${index + 1}: ${value[index].title}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        subtitle: Text(
                          value[index].body,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      );
                    },
                  ),
                  error: (e, _) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error, color: Colors.red, size: 48),
                        const SizedBox(height: 16),
                        Text((e as FudoException).message),
                      ],
                    ),
                  ),
                  loading: () => Center(child: FudoLoading()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
