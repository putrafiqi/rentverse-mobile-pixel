import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../data/data.dart';
import '../bloc/sign_in_bloc.dart';

import 'sign_in_form.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  static Route<void> route() =>
      MaterialPageRoute(builder: (_) => const SignInPage());

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    return BlocProvider<SignInBloc>(
      create: (context) => SignInBloc(context.read<AuthRepository>()),
      child: BlocListener<SignInBloc, SignInState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status.isFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(
                    state.errorMessage ?? 'Sign In Failed',
                    style: TextStyle(color: colorScheme.onError),
                  ),
                  backgroundColor: colorScheme.error,
                ),
              );
          }
          if (state.status.isSuccess) {
            Navigator.of(context).pop();
          }
        },
        child: const _SignInView(),
      ),
    );
  }
}

class _SignInView extends StatelessWidget {
  const _SignInView();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final colorScheme = ColorScheme.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        forceMaterialTransparency: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: Stack(
        children: [
          Container(height: screenHeight * 0.5, color: colorScheme.primary),
          const SignInForm(),
        ],
      ),
    );
  }
}
