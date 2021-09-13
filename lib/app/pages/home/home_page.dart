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

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  HomeController _homeController;
  List<Widget> _widgets;
  ReactionDisposer _locationReaction;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _homeController = GetIt.I.get<HomeController>();
    _widgets = const [
      SelectPartnerPage(),
      MatchPage(),
      SwitchSettingsPage(),
    ];
    _homeController.loadLocation();
    _locationReaction = reaction(
        (_) => _homeController.currentLocation.value, _onLocationUpdate);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      //Receive Firebase notification and show message
      ChannelServiceImpl channelService = ChannelServiceImpl(Odoo());
      List<Channel> listChannel = await channelService.findByMatch([0], int.parse(message.data['channel_id']));

      Navigator.of(context).pushNamed("/chat", arguments: listChannel[0]);
    });

    super.initState();
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
    _homeController.updateLocation(location);
  }

  @override
  void dispose() {
    _locationReaction();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     final odoo = Odoo();

/*
          EventServiceImpl(odoo).findEvents().then((value) {
            print(value);
          });
          */

      /*
          final odoo = Odoo();
          final channelService = ChannelServiceImpl(odoo);
          final service = SendLikeFacace(MatchServiceImpl(odoo),
              RelationServiceImpl(odoo), channelService);
              */

      // 8,7
      // service.sendLike(LikeDto(8,7));

/*
  channelService.findByMatch([8,7])
  .then((value) {
    print(value);
  });
  */
      // },
      // ),
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
