import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/support.dart';
import '../../models/user.dart';
import 'package:http/http.dart' as http;
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<FetchUserEvent>(_mapFetchUserEventToState);
  }
   void _mapFetchUserEventToState(FetchUserEvent event, Emitter<UserState> emit) async {
  emit(UserLoading());

  try {
    final url = 'https://reqres.in/api/users/${event.userId}';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final user = data['data'];
      final userModel = User.fromJson(user);
      final supportData = data['support'];
      final support = Support(
        url: supportData['url'],
        text: supportData['text'],
      );
      emit(UserLoaded(user: userModel, support: support));
    } else {
      throw Exception('Failed to fetch user');
    }
  } catch (e) {
    print('User API Error: $e');
    emit(UserError(error: 'Failed to fetch user'));
  }
}
}
