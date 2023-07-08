import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_loader/services/bloc/user_bloc.dart';
import 'package:infinite_loader/styles/styles.dart';

class UserDetailsPage extends StatefulWidget {
  final int userId;

  const UserDetailsPage({
    required this.userId,
  });

  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  late UserBloc _userBloc;
  @override
  void initState() {
    super.initState();
    _userBloc = BlocProvider.of<UserBloc>(context);
    _userBloc.add(FetchUserEvent(userId: widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<UserBloc, UserState>(
            bloc: _userBloc,
            builder: (context, state) {
              if (state is UserLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is UserLoaded) {
                final user = state.user;
                final support = state.support;

                return Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(user.avatar),
                        radius: 60,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '${user.firstName} ${user.lastName}',
                        style: HeaderFonts.seconadryText,
                      ),
                      const SizedBox(height: 8),
                      RichText(
                        text: TextSpan(
                         
                          children: [
                            TextSpan(
                                text: 'Email: ', style: TextFonts.specialText),
                            TextSpan(
                                text: user.email, style: TextFonts.ternaryText),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        support.url,
                        style: HintFonts.primaryText,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        support.text,
                        style: TextFonts.specialText,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              } else if (state is UserError) {
                return Center(
                  child: Text(state.error),
                );
              }

              return Container();
            },
          ),
        ),
      ),
    );
  }
}
