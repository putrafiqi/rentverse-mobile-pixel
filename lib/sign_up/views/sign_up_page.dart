import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../data/data.dart';
import '../bloc/sign_up_bloc.dart';
import 'sign_up_form.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  static Route<void> route() =>
      MaterialPageRoute(builder: (_) => const SignUpPage());

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    return BlocProvider(
      create: (context) => SignUpBloc(context.read<AuthRepository>()),
      child: BlocListener<SignUpBloc, SignUpState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status.isFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(
                    state.errorMessage ?? 'Sign Up Failure',
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
        child: const _SignUpView(),
      ),
    );
  }
}

class _SignUpView extends StatelessWidget {
  const _SignUpView();

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
          const SignUpForm(),
        ],
      ),
    );
  }
}
