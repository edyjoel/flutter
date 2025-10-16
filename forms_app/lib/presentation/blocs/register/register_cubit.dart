import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterFormState> {
  RegisterCubit() : super(RegisterFormState());

  void onSubmit() {
    print('Submitted: ${state.username}, ${state.email}, ${state.password}');
  }

  void usernameChanged(String username) {
    emit(state.copyWith(username: username));
  }

  void emailChanged(String email) {
    emit(state.copyWith(email: email));
  }

  void passwordChanged(String password) {
    emit(state.copyWith(password: password));
  }
}
