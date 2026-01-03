import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../data/data.dart';
import '../../core/core.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthRepository _authRepository;

  SignInBloc(this._authRepository) : super(const SignInState()) {
    on<SignInEmailChanged>(_onEmailChanged);
    on<SignInPasswordChanged>(_onPasswordChanged);
    on<SignInPasswordObscuredToggled>(_onPasswordObscuredToggled);
    on<SignInSubmitted>(_onSubmitted);
  }

  List<FormzInput> _getInputs({Email? email, Password? password}) {
    return [email ?? state.email, password ?? state.password];
  }

  void _onEmailChanged(SignInEmailChanged event, Emitter<SignInState> emit) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        isValidInput: Formz.validate(_getInputs(email: email)),
      ),
    );
  }

  void _onPasswordChanged(
    SignInPasswordChanged event,
    Emitter<SignInState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        isValidInput: Formz.validate(_getInputs(password: password)),
      ),
    );
  }

  void _onPasswordObscuredToggled(
    SignInPasswordObscuredToggled event,
    Emitter<SignInState> emit,
  ) {
    emit(state.copyWith(isObscuredPassword: !state.isObscuredPassword));
  }

  void _onSubmitted(SignInSubmitted event, Emitter<SignInState> emit) async {
    if (!state.isValidInput) return;

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    try {
      final response = await _authRepository.signIn(
        email: state.email.value,
        password: state.password.value,
      );

      switch (response) {
        case ResultSuccess():
          emit(state.copyWith(status: FormzSubmissionStatus.success));
        case ResultFailure(:final message):
          emit(
            state.copyWith(
              status: FormzSubmissionStatus.failure,
              errorMessage: message,
            ),
          );
      }
    } catch (_) {
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.failure,
          errorMessage: 'Something went wrong',
        ),
      );
    }
  }
}
