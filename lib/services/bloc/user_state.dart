part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final User user;
   final Support support;
  UserLoaded({required this.user, required this.support});
}
class UserError extends UserState {
  final String error;
  UserError({required this.error});
}