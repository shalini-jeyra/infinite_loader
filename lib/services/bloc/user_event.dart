part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}
class FetchUserEvent extends UserEvent {
  final int userId;
  FetchUserEvent({required this.userId});
}
