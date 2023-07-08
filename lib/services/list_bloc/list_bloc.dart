import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../../models/user.dart';
part 'list_event.dart';
part 'list_state.dart';
class ListBloc extends Bloc<ListEvent, ListState> {
  List<User> _users = [];
  bool _hasReachedEnd = false;
  int _currentPage = 1;

  ListBloc() : super(ListInitial()) {
    on<FetchListEvent>(_mapFetchListEventToState);
    on<FetchUserEvent>(_mapFetchUserEventToState);
  }

  void _mapFetchListEventToState(FetchListEvent event, Emitter<ListState> emit) async {
    if (_hasReachedEnd) return;

    emit(ListLoading());

    try {
      final url = 'https://reqres.in/api/users?page=$_currentPage';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final userList = data['data'] as List<dynamic>;

        final List<User> loadedUsers = userList
            .map((user) => User(
                  id: user['id'],
                  email: user['email'],
                  firstName: user['first_name'],
                  lastName: user['last_name'],
                  avatar: user['avatar'],
                ))
            .toList();

        _users.addAll(loadedUsers);

        final totalPageCount = data['total_pages'] as int;
        _currentPage++;

        if (_currentPage > totalPageCount) {
          _hasReachedEnd = true;
        }

        emit(ListLoaded(users: _users.toList(), hasReachedEnd: _hasReachedEnd));
      } else {
        throw Exception('Failed to fetch Lists');
      }
    } catch (e) {
      emit(ListError(error: 'Failed to fetch Lists'));
    }
  }

  void _mapFetchUserEventToState(FetchUserEvent event, Emitter<ListState> emit) async {
    emit(UserLoading());

    try {
      final url = 'https://reqres.in/api/users/${event.userId}';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final user = data['data'];
        final userModel = User.fromJson(user);
        emit(UserLoaded(user: userModel));
      } else {
        throw Exception('Failed to fetch user');
      }
    } catch (e) {
      emit(ListError(error: 'Failed to fetch user'));
    }
  }
}

