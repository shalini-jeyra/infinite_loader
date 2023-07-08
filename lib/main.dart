import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_loader/pages/pages.dart';
import 'package:infinite_loader/services/bloc/user_bloc.dart';
import 'package:infinite_loader/services/list_bloc/list_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
       providers: [
        BlocProvider<ListBloc>(
          create: (context) => ListBloc(),
        ),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(),
        ),
      ],
      child: 
        MaterialApp(
        debugShowCheckedModeBanner: false,
          theme: ThemeData(
           
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home:  const UserListPage(),
        ),
    
    );
  }
}
