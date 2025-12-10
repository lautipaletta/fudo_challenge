import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fudo_challenge/core/common/utils/form_validators.dart';
import 'package:fudo_challenge/core/common/utils/snackbar_handler.dart';
import 'package:fudo_challenge/core/common/widgets/fudo_loading.dart';
import 'package:fudo_challenge/core/common/widgets/fudo_text_field.dart';
import 'package:fudo_challenge/features/posts/di/providers.dart';
import 'package:go_router/go_router.dart';

class CreatePostScreen extends ConsumerStatefulWidget {
  const CreatePostScreen({super.key});

  @override
  ConsumerState<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends ConsumerState<CreatePostScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(createPostsProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FudoTextField(
                  labelText: 'Title',
                  controller: _titleController,
                  validator: FormValidators.emptyValidator,
                ),
                const SizedBox(height: 48),
                FudoTextField(
                  labelText: 'Content',
                  controller: _contentController,
                  validator: FormValidators.emptyValidator,
                ),
                const SizedBox(height: 48),
                ElevatedButton(
                  onPressed: state.isLoading
                      ? null
                      : () async {
                          if (_formKey.currentState!.validate()) {
                            final result = await ref
                                .read(createPostsProvider.notifier)
                                .createPost(
                                  title: _titleController.text.trim(),
                                  body: _contentController.text.trim(),
                                );
                            if (!context.mounted) return;
                            result.fold(
                              (l) => SnackbarHandler.showSnackbar(
                                context,
                                l.message,
                              ),
                              (r) => context.pop(true),
                            );
                          }
                        },
                  child: state.isLoading
                      ? const FudoLoading()
                      : const Text('Create Post'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
