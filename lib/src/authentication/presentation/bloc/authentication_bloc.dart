import 'package:bigsizeship_mobile/src/authentication/domain/entities/user.dart';
import 'package:bigsizeship_mobile/src/authentication/domain/usecases/login.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required Login login,
  })  : _login = login,
        super(const AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) {
      emit(const LoginLoading());
    });
    on<LoginEvent>(_loginHandler);
  }

  final Login _login;

  Future<void> _loginHandler(
    LoginEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    final result =
        await _login(LoginParams(email: event.email, password: event.password));
    result.fold(
      (failure) => emit(AuthenticationError(failure.errorMessage)),
      (user) => emit(Logined(user)),
    );
  }
}
