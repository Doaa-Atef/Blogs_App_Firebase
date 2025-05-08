part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}
final class UserLoading extends UserState {}
class UserSuccess extends UserState {
  final String userId;
  final String username;
  final String email;

  UserSuccess({
    required this.userId,
    required this.username,
    required this.email,
  });
}

class UserError extends UserState {
  final String message;

  UserError(this.message);
}