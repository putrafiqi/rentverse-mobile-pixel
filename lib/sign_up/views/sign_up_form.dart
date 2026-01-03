import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:intl/intl.dart';

import '../../sign_in/sign_in.dart';
import '../bloc/sign_up_bloc.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          const SizedBox(height: kToolbarHeight + 48),
          const _SignUpFormHeader(),
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
                  const Row(
                    children: [
                      Expanded(child: _FirstNameInput()),
                      SizedBox(width: 16.0),
                      Expanded(child: _LastNameInput()),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  const _DateOfBirthInput(),
                  const SizedBox(height: 16.0),
                  const _PhoneNumberInput(),
                  const SizedBox(height: 16.0),
                  const _EmailInput(),
                  const SizedBox(height: 16.0),
                  const _PasswordInput(),
                  const SizedBox(height: 24.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const _SignUpSubmitButton(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: textTheme.bodyMedium,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                SignInPage.route(),
                              );
                            },
                            child: const Text('Sign In'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _FirstNameInput extends StatelessWidget {
  const _FirstNameInput();

  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (SignUpBloc bloc) => bloc.state.firstName.displayError,
    );

    return TextFormField(
      key: const Key('signUpForm_firstNameInput_textField'),
      onChanged: (value) =>
          context.read<SignUpBloc>().add(SignUpFirstNameChanged(value)),
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        isDense: true,
        labelText: 'First Name',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        errorText: displayError?.message,
      ),
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
    );
  }
}

class _LastNameInput extends StatelessWidget {
  const _LastNameInput();

  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (SignUpBloc bloc) => bloc.state.lastName.displayError,
    );

    return TextFormField(
      key: const Key('signUpForm_lastNameInput_textField'),
      onChanged: (value) =>
          context.read<SignUpBloc>().add(SignUpLastNameChanged(value)),
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        isDense: true,
        labelText: 'Last Name',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        errorText: displayError?.message,
      ),
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
    );
  }
}

class _DateOfBirthInput extends StatelessWidget {
  const _DateOfBirthInput();

  @override
  Widget build(BuildContext context) {
    final dateOfBirth = context.select(
      (SignUpBloc bloc) => bloc.state.dateOfBirth.value,
    );
    final displayError = context.select(
      (SignUpBloc bloc) => bloc.state.dateOfBirth.displayError,
    );

    // Helper to format date for display inside the text field
    final textController = TextEditingController(
      text: dateOfBirth != null
          ? DateFormat('dd-MM-yyyy').format(dateOfBirth)
          : '',
    );

    return TextFormField(
      key: const Key('signUpForm_dateOfBirthInput_textField'),
      controller: textController,
      readOnly: true,
      keyboardType: TextInputType.datetime,
      decoration: InputDecoration(
        isDense: true,
        labelText: 'Date of Birth',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        errorText: displayError?.message,
        suffixIcon: const Icon(LucideIcons.calendar),
      ),
      onTap: () async {
        final selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );

        if (selectedDate != null && context.mounted) {
          context.read<SignUpBloc>().add(
            SignUpDateOfBirthChanged(selectedDate),
          );
        }
      },
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
    );
  }
}

class _PhoneNumberInput extends StatelessWidget {
  const _PhoneNumberInput();

  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (SignUpBloc bloc) => bloc.state.phoneNumber.displayError,
    );

    return TextFormField(
      key: const Key('signUpForm_phoneNumberInput_textField'),
      onChanged: (value) =>
          context.read<SignUpBloc>().add(SignUpPhoneNumberChanged(value)),
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        isDense: true,
        labelText: 'Phone Number',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        errorText: displayError?.message,
      ),
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (SignUpBloc bloc) => bloc.state.email.displayError,
    );

    return TextFormField(
      key: const Key('signUpForm_emailInput_textField'),
      onChanged: (value) =>
          context.read<SignUpBloc>().add(SignUpEmailChanged(value)),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        isDense: true,
        labelText: 'Email',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        errorText: displayError?.message,
      ),
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput();

  @override
  Widget build(BuildContext context) {
    final isObscure = context.select(
      (SignUpBloc bloc) => bloc.state.isObscuredPassword,
    );
    final displayError = context.select(
      (SignUpBloc bloc) => bloc.state.password.displayError,
    );

    return TextFormField(
      key: const Key('signUpForm_passwordInput_textField'),
      onChanged: (value) =>
          context.read<SignUpBloc>().add(SignUpPasswordChanged(value)),
      obscureText: isObscure,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        isDense: true,
        labelText: 'Password',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        errorText: displayError?.message,
        suffixIcon: IconButton(
          icon: Icon(isObscure ? LucideIcons.eyeOff : LucideIcons.eye),
          onPressed: () =>
              context.read<SignUpBloc>().add(SignUpPasswordObscuredToggled()),
        ),
      ),
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
    );
  }
}

class _SignUpSubmitButton extends StatelessWidget {
  const _SignUpSubmitButton();

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final isValidInput = context.select(
      (SignUpBloc bloc) => bloc.state.isValidInput,
    );

    final status = context.select((SignUpBloc bloc) => bloc.state.status);

    return FilledButton(
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      onPressed: isValidInput
          ? () => context.read<SignUpBloc>().add(SignUpSubmitted())
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
          : const Text('Sign Up'),
    );
  }
}

class _SignUpFormHeader extends StatelessWidget {
  const _SignUpFormHeader();

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
          'Sign up to create your Account.',
          style: textTheme.headlineLarge?.copyWith(
            color: colorScheme.onPrimary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Enter your information to create an account.',
          style: textTheme.bodyMedium?.copyWith(color: colorScheme.onPrimary),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
