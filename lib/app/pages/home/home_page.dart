import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:odoo_client/app/pages/home/home_controller.dart';
import 'package:odoo_client/app/pages/home/select_partner_page.dart';
import 'package:odoo_client/app/pages/match/match_page.dart';
import 'package:odoo_client/app/pages/settings/switch_settings_page.dart';

class _NavigationBarItemModel {
  final Widget icon;
  final Widget selectedIcon;
  _NavigationBarItemModel({this.icon, this.selectedIcon});
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController _homeController;
  List<Widget> _widgets;

  @override
  void initState() {
    _homeController = GetIt.I.get<HomeController>();
    _widgets = const [
      SelectPartnerPage(),
      MatchPage(),
      SwitchSettingsPage(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: SafeArea(
            child: Observer(builder: (_) {
              return BottomNavigationBar(
                showUnselectedLabels: true,
                onTap: (index) {
                  _homeController.currentIndex = index;
                },
                items: [
                  _NavigationBarItemModel(
                    selectedIcon: Icon(
                      Icons.event,
                      color: Colors.red,
                    ),
                    icon: Icon(
                      Icons.event,
                      color: Colors.grey[400],
                    ),
                  ),
                  _NavigationBarItemModel(
                    selectedIcon: Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.grey[400],
                    ),
                  ),
                  _NavigationBarItemModel(
                    selectedIcon: Icon(
                      Icons.person,
                      color: Colors.red,
                    ),
                    icon: Icon(
                      Icons.person,
                      color: Colors.grey[400],
                    ),
                  ),
                ]
                    .map(
                      (e) => BottomNavigationBarItem(
                          backgroundColor: Colors.red,
                          title: Container(
                            width: 0,
                            height: 0,
                          ),
                          icon: e.icon,
                          activeIcon: e.selectedIcon),
                    )
                    .toList(),
                currentIndex: _homeController.currentIndex,
              );
            }),
          ),
          preferredSize: const Size.fromHeight(60)),
      backgroundColor: Colors.grey[100],
      body: Observer(
        builder: (_) => _widgets[_homeController.currentIndex],
      ),
    );
  }
}
