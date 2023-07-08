part of 'list_bloc.dart';

@immutable
abstract class ListState  {
 
}

class ListInitial extends ListState {}

class ListLoading extends ListState {}


class ListLoaded extends ListState {
  final List<User> users;
  final bool hasReachedEnd;
  ListLoaded({required this.users, required this.hasReachedEnd});
}

class ListError extends ListState {
  final String error;
  ListError({required this.error});
}
