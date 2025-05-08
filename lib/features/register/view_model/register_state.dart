part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitialState extends RegisterState {}
final class RegisterLoadingState extends RegisterState {}
final class RegisterSuccessState extends RegisterState {
  // final message;
  //
  // RegisterSuccessState( this.message);
  //
}
final class RegisterErrorState extends RegisterState {
  final error;

  RegisterErrorState( this.error);
}
