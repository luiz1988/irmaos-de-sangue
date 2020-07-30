import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:irmaos_de_sangue/pages/splash_screen/splash_screen.dart';
import 'package:irmaos_de_sangue/services/user_repository.dart';

import 'package:irmaos_de_sangue/services/bloc_delegate.dart';
import 'package:irmaos_de_sangue/authentication_bloc/bloc.dart';

import 'package:irmaos_de_sangue/pages/videos/videos_bloc.dart';
import 'package:irmaos_de_sangue/pages/home/home_page.dart';
import 'package:bloc_pattern/bloc_pattern.dart' as NewBlocPattern;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = UserRepository();
  runApp(
    BlocProvider(
      builder: (context) => AuthenticationBloc(userRepository: userRepository)
        ..dispatch(AppStarted()),
      child: App(userRepository: userRepository),
    ),
  );
}

class App extends StatelessWidget {
  final UserRepository _userRepository;

  App({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  _home() {
    return NewBlocPattern.BlocProvider(
      bloc: VideosBloc(),
      child: HomePage(
        userRepository: _userRepository,
      ),
    );
  }

  // _home() {
  //   return HomePage(
  //     userRepository: _userRepository,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
          primarySwatch: Colors.red,
          accentColor: Colors.redAccent,
          iconTheme: IconThemeData(color: Colors.red),
          canvasColor: Colors.red,
          unselectedWidgetColor: Colors.red),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Uninitialized) {
            return SplashScreen();
          }
          return _home();
        },
      ),
    );
  }
}
