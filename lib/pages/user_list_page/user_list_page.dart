import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/list_bloc/list_bloc.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  late ScrollController _scrollController;
  final ListBloc _listBloc = ListBloc();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    
    _scrollController.addListener(_scrollListener);

    _listBloc.add(FetchListEvent());
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _listBloc.close();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
     
      _listBloc.add(FetchListEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      body: BlocBuilder<ListBloc, ListState>(
        bloc: _listBloc,
        builder: (context, state) {
          if (state is ListInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ListLoaded) {
            final users = state.users;

            return ListView.builder(
              controller: _scrollController,
              itemCount: users.length + 1,
              itemBuilder: (context, index) {
                if (index < users.length) {
                  final user = users[index];

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.avatar),
                    ),
                    title: Text('${user.firstName} ${user.lastName}'),
                    subtitle: Text(user.email),
                  );
                } else {
                 
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          } else if (state is ListError) {
            return Center(
              child: Text(state.error),
            );
          }

          return Container();
        },
      ),
    );
  }
}
