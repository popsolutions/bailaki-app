import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:location/location.dart';
import 'package:mobx/mobx.dart';
import 'package:odoo_client/app/data/models/channel.dart';
import 'package:odoo_client/app/data/services/channel_service.dart';
import 'package:odoo_client/app/data/services/odoo_api.dart';
import 'package:odoo_client/app/pages/home/home_controller.dart';
import 'package:odoo_client/app/pages/home/select_partner_controller.dart';
import 'package:odoo_client/app/pages/home/select_partner_page.dart';
import 'package:odoo_client/app/pages/map/map_page.dart';
import 'package:odoo_client/app/pages/match/match_page.dart';
import 'package:odoo_client/app/pages/settings/switch_settings_page.dart';
import 'package:odoo_client/app/utility/global.dart';
import 'package:odoo_client/shared/components/dialogs.dart';
import 'package:odoo_client/shared/controllers/authentication_controller.dart';

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

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  HomeController _homeController;
  List<Widget> _widgets;
  ReactionDisposer _locationReaction;
  AuthenticationController _authenticationController;

  @override
  void initState() {
    globalHomePage_logout = homePage_logout;
    _authenticationController = GetIt.I.get<AuthenticationController>();
    WidgetsBinding.instance.addObserver(this);
    _homeController = GetIt.I.get<HomeController>();
    _widgets = [
      SelectPartnerPage(),
      MatchPage(),
      SwitchSettingsPage(),
      MapPage(),
    ];
    _homeController.loadLocation();
    _locationReaction = reaction(
      (_) => _homeController.currentLocation.value,
      _onLocationUpdate,
    );

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      //Receive Firebase notification and show message
      if (message != null) showNotifyMessage(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      //Receive Firebase notification and show message
      showNotifyMessage(message);
    });

    globalHomePageStarted = true;
    super.initState();
  }

  void homePage_logout() async {
    showSnackBar(context,
        'Seu usuário expirou, será necessário efetuar o login novamente.',
        milliseconds: 5000);

    _authenticationController.logout();

    Navigator.pushNamedAndRemoveUntil(
      context,
      '/',
      (route) => false,
    );
  }

  void showNotifyMessage(RemoteMessage message) async {
    ChannelServiceImpl channelService = ChannelServiceImpl(GetIt.I.get<Odoo>());
    List<Channel> listChannel = await channelService.findChannel(
        _authenticationController.currentUser.partnerId,
        true,
        message.data['channel_id']);

    Navigator.of(context).pushNamed("/chat", arguments: listChannel[0]);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        break;

      default:
    }
    super.didChangeAppLifecycleState(state);
  }

  void _onLocationUpdate(LocationData location) {
    _homeController.updateLocation(location, _authenticationController.currentUser.partnerId);
  }

  @override
  void dispose() {
    _locationReaction();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
          child: SafeArea(
            child: Observer(builder: (_) {
              return BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
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
                  _NavigationBarItemModel(
                    selectedIcon: Icon(
                      Icons.map,
                      color: Colors.red,
                    ),
                    icon: Icon(
                      Icons.map,
                      color: Colors.grey[400],
                    ),
                    //TODO: REVER APP BAR EM VEMELHO
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
