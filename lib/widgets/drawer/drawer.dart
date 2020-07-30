import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:irmaos_de_sangue/authentication_bloc/bloc.dart';
import 'package:irmaos_de_sangue/pages/home/home_page.dart';
import 'package:irmaos_de_sangue/pages/login/login_screen.dart';
import 'package:irmaos_de_sangue/services/user_repository.dart';
import 'package:irmaos_de_sangue/utils/nav.dart';

class DrawerApp extends StatefulWidget {
  final UserRepository _userRepository;
  DrawerApp({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  _DrawerAppState createState() => _DrawerAppState();
}

class _DrawerAppState extends State<DrawerApp> {
  bool isLogged = false;
  String userEmail = "";
  Future<FirebaseUser> loggedUser;
  String mainProfilePicture =
      "https://lh3.googleusercontent.com/-6XnV92p4vLE/AAAAAAAAAAI/AAAAAAAAAAA/ACHi3rfL-UDEUeZhid0cCkRv6cPScs1Cpg.CMID/s400-c/photo.jpg";
  String otherProfilePicture =
      "https://lh3.googleusercontent.com/-satysRBaCMY/AAAAAAAAAAI/AAAAAAAAAAA/ACHi3rciVin3fpfi7UP1jjgG7_Q0Tkk45Q.CMID/s32-c/photo.jpg";

  _DrawerAppState() {
    var user = FirebaseAuth.instance.currentUser();
    if (mounted && user != null) {
      print("Logago");
      setState(() {
        isLogged = true;
        loggedUser = user;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FutureBuilder(
          future: widget._userRepository.getUserInfo(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView(
                children: <Widget>[
                  snapshot.data != null
                      ? _buildUserAccountsDrawerHeader(snapshot.data)
                      : _buildUserLoginDrawerHeader(context),
                  _buildListTile(
                      context,
                      "First Page",
                      Icons.branding_watermark,
                      () => _onClickFirstTile(context)),
                  _buildListTile(context, "Second Page", Icons.account_circle,
                      () => _onClickFirstTile(context)),
                  new Divider(),
                  snapshot.data != null
                      ? _buildListTile(context, "Sign out", Icons.verified_user,
                          () => _onSignOut(context))
                      : _buildListTile(context, "Close", Icons.cancel,
                          () => _onClickFirstTile(context)),
                ],
              );
            }else{
              return ListView(
                children: <Widget>[
                  Center(                    
                    child: CircularProgressIndicator(),
                  )
                ],
              );
            }
          }),
    );
  }

  _onClickFirstTile(context) {
    Navigator.of(context).pop();
  }

  _onSignOut(context) {
    BlocProvider.of<AuthenticationBloc>(context).dispatch(
      LoggedOut(),
    );
    widget._userRepository.signOut();
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return HomePage(
        userRepository: widget._userRepository,
      );
    }));
  }

  _buildListTile(BuildContext context, title, icon, action) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      onTap: action,
    );
  }

  _buildUserLoginDrawerHeader(context) {
    return ListTile(
      title: Text("Login"),
      leading: Icon(Icons.account_circle),
      onTap: () async {
        Navigator.pop(context);
        bool isLogged = await push(
            context,
            LoginScreen(
              userRepository: widget._userRepository,
            ));
        print(isLogged);
      },
    );
  }

  _buildUserAccountsDrawerHeader(user) {
    return UserAccountsDrawerHeader(
      accountName: new Text(user['nome']),
      accountEmail: Text(user['email'].toString()),
      currentAccountPicture: new GestureDetector(
        child: new CircleAvatar(
          backgroundImage: new NetworkImage(user['pictureUrl']),
        ),
        onTap: () {},
      ),
      decoration: new BoxDecoration(
          color: Colors.black,
          image: new DecorationImage(
              fit: BoxFit.fill,
              image: new NetworkImage(
                  "https://images.unsplash.com/photo-1500382017468-9049fed747ef?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80"))),
    );
  }
}
