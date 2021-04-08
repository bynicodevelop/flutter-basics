import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kdofavoris/forms/types/auth/form_auth_bloc.dart';
import 'package:kdofavoris/repositories/auth_repository.dart';
import 'package:kdofavoris/screens/auth/login_screen.dart';
import 'package:kdofavoris/screens/auth/profile_screen.dart';
import 'package:kdofavoris/screens/auth/register_screen.dart';
import 'package:kdofavoris/screens/home_screen.dart';
import 'package:kdofavoris/services/authentication/authentication_bloc.dart';
import 'package:kdofavoris/style.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  firebaseAuth.useEmulator('http://localhost:9099');

  runApp(App(
    firebaseAuth,
  ));
}

// ignore: must_be_immutable
class App extends StatelessWidget {
  final FirebaseAuth _firebaseAuth;

  App(
    this._firebaseAuth,
  );

  @override
  Widget build(BuildContext context) {
    AuthRepository authRepository = AuthRepository(_firebaseAuth);

    return MultiBlocProvider(
      providers: [
        BlocProvider<FormAuthBloc>(
          create: (context) => FormAuthBloc(),
        ),
        BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(authRepository),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: Theme.of(context).textTheme.copyWith(
                headline2: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: kFontSize * 1.1,
                      color: kPrimaryColor,
                    ),
              ),
        ),
        initialRoute: HomeScreen.ROUTE,
        routes: {
          HomeScreen.ROUTE: (_) => HomeScreen(),
          RegisterScreen.ROUTE: (_) => RegisterScreen(),
          LoginScreen.ROUTE: (_) => LoginScreen(),
          ProfileScreen.ROUTE: (_) => ProfileScreen(),
        },
      ),
    );
  }
}
