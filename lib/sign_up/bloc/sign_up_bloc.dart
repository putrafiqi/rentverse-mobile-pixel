import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';

import '../../data/data.dart';
import '../../core/core.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository _authRepository;

  SignUpBloc(this._authRepository) : super(const SignUpState()) {
    on<SignUpEmailChanged>(_onEmailChanged);
    on<SignUpPasswordChanged>(_onPasswordChanged);
    on<SignUpFirstNameChanged>(_onFirstNameChanged);
    on<SignUpLastNameChanged>(_onLastNameChanged);
    on<SignUpPhoneNumberChanged>(_onPhoneNumberChanged);
    on<SignUpDateOfBirthChanged>(_onDateOfBirthChanged);
    on<SignUpPasswordObscuredToggled>(_onPasswordObscuredToggled);
    on<SignUpSubmitted>(_onSubmitted);
  }

  List<FormzInput> _getInputs({
    Email? email,
    Password? password,
    Name? firstName,
    Name? lastName,
    PhoneNumber? phoneNumber,
    DateOfBirth? dateOfBirth,
  }) {
    return [
      email ?? state.email,
      password ?? state.password,
      firstName ?? state.firstName,
      lastName ?? state.lastName,
      phoneNumber ?? state.phoneNumber,
      dateOfBirth ?? state.dateOfBirth,
    ];
  }

  void _onEmailChanged(SignUpEmailChanged event, Emitter<SignUpState> emit) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        isValidInput: Formz.validate(_getInputs(email: email)),
      ),
    );
  }

  void _onPasswordChanged(
    SignUpPasswordChanged event,
    Emitter<SignUpState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        isValidInput: Formz.validate(_getInputs(password: password)),
      ),
    );
  }

  void _onFirstNameChanged(
    SignUpFirstNameChanged event,
    Emitter<SignUpState> emit,
  ) {
    final firstName = Name.dirty(event.firstName);
    emit(
      state.copyWith(
        firstName: firstName,
        isValidInput: Formz.validate(_getInputs(firstName: firstName)),
      ),
    );
  }

  void _onLastNameChanged(
    SignUpLastNameChanged event,
    Emitter<SignUpState> emit,
  ) {
    final lastName = Name.dirty(event.lastName);
    emit(
      state.copyWith(
        lastName: lastName,
        isValidInput: Formz.validate(_getInputs(lastName: lastName)),
      ),
    );
  }

  void _onPhoneNumberChanged(
    SignUpPhoneNumberChanged event,
    Emitter<SignUpState> emit,
  ) {
    final phoneNumber = PhoneNumber.dirty(event.phoneNumber);
    emit(
      state.copyWith(
        phoneNumber: phoneNumber,
        isValidInput: Formz.validate(_getInputs(phoneNumber: phoneNumber)),
      ),
    );
  }

  void _onDateOfBirthChanged(
    SignUpDateOfBirthChanged event,
    Emitter<SignUpState> emit,
  ) {
    final dateOfBirth = DateOfBirth.dirty(event.dateOfBirth);
    emit(
      state.copyWith(
        dateOfBirth: dateOfBirth,
        isValidInput: Formz.validate(_getInputs(dateOfBirth: dateOfBirth)),
      ),
    );
  }

  void _onPasswordObscuredToggled(
    SignUpPasswordObscuredToggled event,
    Emitter<SignUpState> emit,
  ) {
    emit(state.copyWith(isObscuredPassword: !state.isObscuredPassword));
  }

  void _onSubmitted(SignUpSubmitted event, Emitter<SignUpState> emit) async {
    if (!state.isValidInput) return;

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    try {
      final response = await _authRepository.signUp(
        email: state.email.value,
        password: state.password.value,
        firstName: state.firstName.value,
        lastName: state.lastName.value,
        phoneNumber: state.phoneNumber.value,
        dateOfBirth: DateFormat('yyyy-MM-dd').format(state.dateOfBirth.value!),
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
