import 'package:flutter/material.dart';
import 'package:irmaos_de_sangue/pages/doacao/doacao_page.dart';
import 'package:irmaos_de_sangue/pages/orientation/orientation_page.dart';
import 'package:irmaos_de_sangue/pages/login/login_screen.dart';
import 'package:irmaos_de_sangue/pages/empresa/empresa_page.dart';
import 'package:irmaos_de_sangue/pages/videos/video_page.dart';
import 'package:irmaos_de_sangue/services/user_repository.dart';
import 'package:irmaos_de_sangue/widgets/drawer/drawer.dart';
import 'package:irmaos_de_sangue/utils/nav.dart';

class HomePage extends StatefulWidget {
  @override
  _HomeStatePage createState() {
    return _HomeStatePage();
  }

  final UserRepository _userRepository;

  HomePage({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);
}

class _HomeStatePage extends State<HomePage> {
  bool isLogged = false;

  getTabBarWhenLogged() {
    return TabBar(
      tabs: <Widget>[
        Tab(
          text: "DOAÇÃO",
        ),
        Tab(
          text: "VIDEOS",
        ),
        Tab(
          text: "ORIENTAÇÕES",
        ),
        Tab(
          text: "RANKING EMPRESAS",
        ),
      ],
    );
  }

  getTabBarViewWhenIsLogged() {
    return TabBarView(
      children: [
        DoacaoPage(),
        VideoPage(),
        OrientationPage(),
        EmpresaPage(),
      ],
    );
  }

  getTabBarViewWhenIsNotLogged() {
    return TabBarView(
      children: [
        VideoPage(),
        OrientationPage(),
        EmpresaPage(),
      ],
    );
  }

  getTabBarWhenIsNotLogged() {
    return TabBar(
      tabs: <Widget>[
        Tab(
          text: "VIDEOS",
        ),
        Tab(
          text: "ORIENTAÇÕES",
        ),
        Tab(
          text: "RANKING EMPRESAS",
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
          future: widget._userRepository.getUserInfo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                appBar: AppBar(
                  title: Text('#Irmãos de Sangue'),
                  backgroundColor: Colors.redAccent[200],
                  centerTitle: true,
                ),
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return DefaultTabController(
                length: snapshot.data != null ? 4 : 3,
                child: Scaffold(
                    appBar: AppBar(
                      title: const Text(
                        '#Irmãos de Sangue',
                        style: TextStyle(color: Colors.white),
                      ),
                      centerTitle: true,
                      backgroundColor: Colors.redAccent[200],
                      iconTheme: new IconThemeData(color: Colors.white),
                      actions: <Widget>[
                        IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {},
                        )
                      ],
                      bottom: snapshot.data != null &&
                              snapshot.connectionState == ConnectionState.done
                          ? getTabBarWhenLogged()
                          : getTabBarWhenIsNotLogged(),
                    ),
                    backgroundColor: Colors.white,
                    body: snapshot.data != null &&
                            snapshot.connectionState == ConnectionState.done
                        ? getTabBarViewWhenIsLogged()
                        : getTabBarViewWhenIsNotLogged(),
                    drawer: DrawerApp(
                      userRepository: widget._userRepository,
                    ),
                    floatingActionButton: snapshot.data != null &&
                            snapshot.connectionState == ConnectionState.done
                        ? Container(height: 0)
                        : FloatingActionButton(
                            onPressed: () async {
                              Navigator.pop(context);
                              await push(
                                  context,
                                  LoginScreen(
                                    userRepository: widget._userRepository,
                                  ));
                            },
                            child: Container(
                              width: 80.0,
                              height: 80.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/gota_sangue.jpg"))),
                            ),
                          )),
              );
            }
          }),
    );
  }

  Widget _floatingDoar() {
    return FloatingActionButton(
      onPressed: () async {
        Navigator.pop(context);
        await push(
            context,
            LoginScreen(
              userRepository: widget._userRepository,
            ));
      },
      child: Container(
        width: 80.0,
        height: 80.0,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image:
                DecorationImage(image: AssetImage("assets/gota_sangue.jpg"))),
      ),
    );
  }

  Widget _floatingAgendar() {
    return FloatingActionButton(
      onPressed: () async {
        Navigator.pop(context);
        await push(
            context,
            LoginScreen(
              userRepository: widget._userRepository,
            ));
      },
      child: Container(
        width: 80.0,
        height: 80.0,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image:
                DecorationImage(image: AssetImage("assets/shedule_icon.png"))),
      ),
    );
  }

  Widget _floatingEfetivar() {
    return FloatingActionButton(
      onPressed: () async {
        Navigator.pop(context);
        await push(
            context,
            LoginScreen(
              userRepository: widget._userRepository,
            ));
      },
      child: Container(
        width: 80.0,
        height: 80.0,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: AssetImage("assets/file_icon.jpg"))),
      ),
    );
  }
}
