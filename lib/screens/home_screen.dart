import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kdofavoris/screens/auth/login_screen.dart';
import 'package:kdofavoris/screens/auth/profile_screen.dart';
import 'package:kdofavoris/services/authentication/authentication_bloc.dart';

class HomeScreen extends StatefulWidget {
  static const String ROUTE = "/";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    context.read<AuthenticationBloc>().add(AuthenticationInializeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is AuthenticatedState) {
                return IconButton(
                  icon: Icon(Icons.person),
                  onPressed: () => Navigator.pushNamed(
                    context,
                    ProfileScreen.ROUTE,
                  ),
                );
              }

              return IconButton(
                icon: Icon(Icons.login),
                onPressed: () => Navigator.pushNamed(
                  context,
                  LoginScreen.ROUTE,
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Container(
          child: Text("Content"),
        ),
      ),
    );
  }
}
