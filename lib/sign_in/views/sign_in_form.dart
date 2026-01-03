import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../sign_up/sign_up.dart';
import '../bloc/sign_in_bloc.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          const SizedBox(height: kToolbarHeight + 48),
          const _SignInFormHeader(),
          const SizedBox(height: 24),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 24.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const _EmailInput(),
                  const SizedBox(height: 16.0),
                  const _PasswordInput(),
                  const SizedBox(height: 24.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const _SignInSubmitButton(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account?',
                            style: textTheme.bodyMedium,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                SignUpPage.route(),
                              );
                            },
                            child: const Text('Sign Up'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (SignInBloc bloc) => bloc.state.email.displayError,
    );

    return TextFormField(
      key: const Key('signInForm_emailInput_textField'),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        isDense: true,
        labelText: 'Email',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        errorText: displayError?.message,
      ),
      onChanged: (value) =>
          context.read<SignInBloc>().add(SignInEmailChanged(value)),
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput();

  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (SignInBloc bloc) => bloc.state.password.displayError,
    );

    final isObscure = context.select(
      (SignInBloc bloc) => bloc.state.isObscuredPassword,
    );

    return TextFormField(
      key: const Key('signInForm_passwordInput_textField'),
      obscureText: isObscure,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        isDense: true,
        labelText: 'Password',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        errorText: displayError?.message,
        suffixIcon: IconButton(
          icon: Icon(isObscure ? LucideIcons.eyeOff : LucideIcons.eye),
          onPressed: () {
            context.read<SignInBloc>().add(SignInPasswordObscuredToggled());
          },
        ),
      ),
      onChanged: (value) =>
          context.read<SignInBloc>().add(SignInPasswordChanged(value)),
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
    );
  }
}

class _SignInSubmitButton extends StatelessWidget {
  const _SignInSubmitButton();

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final isValidInput = context.select(
      (SignInBloc bloc) => bloc.state.isValidInput,
    );

    final status = context.select((SignInBloc bloc) => bloc.state.status);

    return FilledButton(
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      onPressed: isValidInput
          ? () => context.read<SignInBloc>().add(SignInSubmitted())
          : null,
      child: status.isInProgress
          ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: colorScheme.onPrimary,
              ),
            )
          : const Text('Sign In'),
    );
  }
}

class _SignInFormHeader extends StatelessWidget {
  const _SignInFormHeader();

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          'assets/images/logo.svg',
          height: 40,
          colorFilter: ColorFilter.mode(colorScheme.onPrimary, BlendMode.srcIn),
        ),
        const SizedBox(height: 24),
        Text(
          'Sign in to your Account',
          style: textTheme.headlineLarge?.copyWith(
            color: colorScheme.onPrimary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Enter your email and password to log in',
          style: textTheme.bodyMedium?.copyWith(color: colorScheme.onPrimary),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
