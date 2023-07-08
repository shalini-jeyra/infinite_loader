import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_loader/styles/styles.dart';

import '../../services/list_bloc/list_bloc.dart';
import '../pages.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  late ScrollController _scrollController;
  late ListBloc _listBloc;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    _listBloc = BlocProvider.of<ListBloc>(context);
    _listBloc.add(FetchListEvent());
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _listBloc.add(FetchListEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.secondaryColor,
        title: Text(
          'User List',
          style: HeaderFonts.primaryText,
        ),
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

            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              controller: _scrollController,
              itemCount: users.length + 1,
              itemBuilder: (context, index) {
                if (index < users.length) {
                  final user = users[index];

                  return OpenContainer(
                    closedBuilder: (context, action) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(user.avatar),
                        ),
                        title: Text(
                          '${user.firstName} ${user.lastName}',
                          style: TextFonts.primaryText,
                        ),
                        subtitle: Text(
                          user.email,
                          style: TextFonts.seconadryText,
                        ),
                      );
                    },
                    openBuilder: (context, action) {
                      return UserDetailsPage(
                        userId: user.id,
                      );
                    },
                    closedElevation: 0.0,
                  );
                } else {
                  return _buildProgressIndicator(context, state);
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

  Widget _buildProgressIndicator(BuildContext context, ListState state) {
    if (state is ListLoaded && state.hasReachedEnd) {
      return Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text('No more data', style: TextFonts.specialText),
        ),
      );
    } else {
      final postBloc = BlocProvider.of<ListBloc>(context);
      postBloc.add(FetchListEvent());

      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
