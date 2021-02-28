import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:odoo_client/app/data/services/odoo_api.dart';
import 'package:odoo_client/app/pages/home/home_controller.dart';
import 'package:odoo_client/main.dart';
import 'package:odoo_client/shared/components/circular_inkwell.dart';
import 'package:odoo_client/shared/controllers/authentication_controller.dart';
/*
class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthenticationController _authenticationController;
  HomeController _homeController;

  @override
  void initState() {
    _authenticationController = GetIt.I.get<AuthenticationController>();
    _homeController = GetIt.I.get<HomeController>();
    _homeController.userPartnerId =
        _authenticationController.currentUser.result.partnerId;
    _homeController.loadPartners();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () async {
                final odoo = Odoo();
                final relationTypeResponse =
                    await odoo.searchRead('res.partner.relation.type', [], []);
                final relationTypeId =
                    relationTypeResponse.getRecords()[0]["id"];
                print(relationTypeId);
              }),
          IconButton(
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('/profile');
              //  push(ProfilePage());
            },
          ),
        ],
      ),
      body: Observer(
        builder: (_) {
          final response = _homeController.partners;
          final data = response.value;
          switch (response.status) {
            case FutureStatus.rejected:
              return const Center(
                child: Text('Is empty'),
              );
            case FutureStatus.pending:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (data.isEmpty) {
                return Center(
                  child: Text('Is empty'),
                );
              } else {
                return 
              }
          }
        },
      ),
    );
  }
}

*/

class _NavigationBarItemModel {
  final String route;
  final Widget icon;
  _NavigationBarItemModel({this.route, this.icon});
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthenticationController _authenticationController;
  HomeController _homeController;

  @override
  void initState() {
    _authenticationController = GetIt.I.get<AuthenticationController>();
    _homeController = GetIt.I.get<HomeController>();
    _homeController.userPartnerId =
        _authenticationController.currentUser.partnerId;
    _homeController.loadPartners();
    super.initState();
  }

  Widget _buildCard({String url, String name, int age, VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Color.fromRGBO(15, 18, 14, 1),
          ),
        ),
        margin: const EdgeInsets.all(15),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              url,
              fit: BoxFit.fill,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Color.fromRGBO(15, 18, 14, 1),
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  right: 10,
                  left: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        "$name, $age - 139.96 km",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Icon(Icons.zoom_out_outlined, color: Colors.white, size: 25)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _like() {
    _homeController.like();
  }

  void _deslike() {
    _homeController.deslike();
  }

  final _navigationModels = [
    _NavigationBarItemModel(
        route: "/switch_settings",
        icon: Icon(
          Icons.person,
          color: Colors.white,
        )),
    _NavigationBarItemModel(
        route: null,
        icon: Icon(
          Icons.event,
          color: Colors.white,
        )),
    _NavigationBarItemModel(
        route: "/settings",
        icon: Icon(
          Icons.settings,
          color: Colors.white,
        )),
  ];

  @override
  Widget build(BuildContext context) {
    final user = _authenticationController.currentUser;
   
    return Scaffold(
      appBar: PreferredSize(
          child: SafeArea(
            child: BottomNavigationBar(
              backgroundColor: Colors.black,
              showUnselectedLabels: true,
              onTap: (index) {
                _homeController.currentIndex = index;
                final item = _navigationModels[index];
                if (item.route != null)
                  Navigator.pushNamed(context, item.route);
              },
              items: _navigationModels
                  .map(
                    (e) => BottomNavigationBarItem(
                        title: Container(
                          width: 0,
                          height: 0,
                        ),
                        icon: e.icon),
                  )
                  .toList(),
              currentIndex: _homeController.currentIndex,
            ),
          ),
          preferredSize: Size.fromHeight(60)),
      backgroundColor: Color.fromRGBO(239, 242, 239, 1),
      body: Observer(
        builder: (_) {
          final response = _homeController.partners;
          final data = response.value;
          switch (response.status) {
            case FutureStatus.rejected:
              return const Center(
                child: Text('Is empty'),
              );
            case FutureStatus.pending:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (data.isEmpty) {
                const Center(
                  child: Text(
                      "Não tem nenhum parceiro na sua área, tente alterar as configurações",
                      textAlign: TextAlign.center),
                );
              } else {
                final current = data.first;
                
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 2,
                      child: _buildCard(
                        name: current.name,
                        age: 19,
                        url: 
                          "https://bailaki.com.br/web/image?model=res.partner&field=image&${user.sessionId}&id=${current.id}",
                        onTap: () => Navigator.of(context).pushNamed(
                            '/partner_detail',
                            arguments: current.id),
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircularInkWell(
                                  color: Color.fromRGBO(0, 255, 253, 1),
                                  child: const Icon(
                                    Icons.close,
                                    size: 45,
                                    color: Colors.white,
                                  ),
                                  onTap: _deslike),
                              CircularInkWell(
                                  radius: 40,
                                  color: Color.fromRGBO(202, 205, 202, 1),
                                  child: Icon(Icons.hourglass_empty_sharp),
                                  onTap: () {}),
                              CircularInkWell(
                                  color: Color.fromRGBO(254, 0, 236, 1),
                                  child: const Icon(
                                    Icons.search,
                                    size: 45,
                                    color: Colors.white,
                                  ),
                                  onTap: _like),
                            ],
                          ),
                        ],
                      ),
                    ))
                  ],
                );
              }
          }
        },
      ),
    );
  }
}
