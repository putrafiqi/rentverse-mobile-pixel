import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/data.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  AuthBloc(this._authRepository) : super(const AuthState()) {
    on<AuthRequested>(_onAuthRequested);
    on<AuthSignedOut>(_onSignedOut);
  }

  void _onAuthRequested(AuthRequested event, Emitter<AuthState> emit) async {
    await emit.forEach<AuthSession>(
      _authRepository.session,
      onData: (session) =>
          AuthState(status: session.status, user: session.user),
      onError: (_, _) => const AuthState(status: AuthStatus.unauthenticated),
    );
  }

  void _onSignedOut(AuthSignedOut event, Emitter<AuthState> emit) async {
    await _authRepository.signOut();
  }
}
