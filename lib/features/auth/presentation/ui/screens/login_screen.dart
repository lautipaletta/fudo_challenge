import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fudo_challenge/config/routes/routes.dart';
import 'package:fudo_challenge/core/common/utils/form_validators.dart';
import 'package:fudo_challenge/core/common/utils/snackbar_handler.dart';
import 'package:fudo_challenge/core/common/widgets/fudo_loading.dart';
import 'package:fudo_challenge/core/common/widgets/fudo_text_field.dart';
import 'package:fudo_challenge/core/exceptions/fudo_exception.dart';
import 'package:fudo_challenge/features/auth/di/providers.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authProvider);
    final controller = ref.read(authProvider.notifier);

    ref.listen(authProvider, (previous, next) {
      if (next.isLoading) return;
      if (next.hasValue && next.value?.isAuthenticated == true) {
        context.goNamed(AppRoutes.posts.name);
      } else if (next.hasError) {
        SnackbarHandler.showSnackbar(
          context,
          (next.error as FudoException).message,
        );
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FudoTextField(
                  controller: _emailController,
                  labelText: 'Email',
                  validator: FormValidators.emailValidator,
                ),
                const SizedBox(height: 32),
                FudoTextField(
                  controller: _passwordController,
                  labelText: 'Password',
                  obscureText: true,
                  validator: FormValidators.passwordValidator,
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: state.isLoading
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            controller.signIn(
                              _emailController.text,
                              _passwordController.text,
                            );
                          }
                        },
                  child: state.isLoading ? const FudoLoading() : Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
