part of 'list_bloc.dart';

@immutable
abstract class ListEvent {}

class FetchListEvent extends ListEvent {

}



class FetchUserEvent extends ListEvent {
  final int userId;
  FetchUserEvent({required this.userId});
}
