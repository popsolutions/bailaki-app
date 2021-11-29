import 'dart:async';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:odoo_client/app/data/services/odoo_api.dart';
import 'package:odoo_client/app/pages/home/home_page.dart';
import 'package:odoo_client/app/pages/login/login_page.dart';
import 'package:odoo_client/app/pages/match/chat_page.dart';
import 'package:odoo_client/app/pages/patner/partner_detail_page.dart';
import 'package:odoo_client/app/pages/profile/dance_level_page.dart';
import 'package:odoo_client/app/pages/profile/dance_style_page.dart';
import 'package:odoo_client/app/pages/profile/genre_page.dart';
import 'package:odoo_client/app/pages/profile/my_profile_page.dart';
import 'package:odoo_client/app/pages/profile/profile_edit_page.dart';
import 'package:odoo_client/app/pages/register/register_page.dart';
import 'package:odoo_client/app/pages/root_page.dart';
import 'package:odoo_client/app/pages/settings/settings_page.dart';
import 'package:odoo_client/app/utility/global.dart';
import 'package:odoo_client/shared/components/dialogs.dart';
import 'package:odoo_client/shared/injector/all_modules.dart';
import 'package:odoo_client/shared/injector/shared_module_injector.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'app/data/services/login_service_impl.dart';
import 'app/pages/map/map_page.dart';
import 'app/utility/strings.dart';
import 'package:path/path.dart';

AppLifecycleState
    appLifecycleState; //t.todo - Verificar com Rully onde colocar esta variável de sinalização do status da aplicação

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  setupAllModules();
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  OneSignal.shared.init("8b92f59d-a196-4d52-b9a5-173a82819ab7", iOSSettings: {
    OSiOSSettings.autoPrompt: false,
    OSiOSSettings.inAppLaunchUrl: false
  });
  OneSignal.shared
      .setInFocusDisplayType(OSNotificationDisplayType.notification);

  OneSignal.shared
      .setNotificationReceivedHandler((OSNotification notification) {
    print(notification);
  });

  // runApp(const App());

  // setupSharedModule();

  final _odoo = GetIt.I.get<Odoo>();

  runZoned(() {
    runApp(App());
  }, zoneSpecification: new ZoneSpecification(
      print: (Zone self, ZoneDelegate parent, Zone zone, String line) async {
    parent.print(zone, line);

    if (!globalHomePageStarted) return;

    if (!globalConfig.activeRegisterLogApiUser) return;

    try {
      if (globalConfig.activeRegisterLogApiUser_QtdeChar > 0) if (line.length >
          globalConfig.activeRegisterLogApiUser_QtdeChar)
        line =
            line.substring(0, globalConfig.activeRegisterLogApiUser_QtdeChar);

      _odoo.callRequestGetLogConsoleRegister(line);
      Future.delayed(Duration.zero);
    } catch (e) {}
  }));
}

class App extends StatefulWidget {
  const App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  FirebaseMessaging messaging;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    // messaging = FirebaseMessaging.instance;
    firebaseToken = '';

    // messaging.getToken().then((value) {
    //   firebaseToken =
    //       value; //t.todo - Verificar com Rully onde é melhor colocar a parte de informar o token para o odoo
    // });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    appLifecycleState = state;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Strings.app_title,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: "Montserrat",
      ),
      initialRoute: "/",
      builder: EasyLoading.init(),
      routes: {
        "/": (_) => RootPage(),
        "/chat": (_) => const ChatPage(),
        "/settings": (_) => const SettingsPage(),
        "/login": (_) => const LoginPage(),
        "/profile": (_) => const MyProfilePage(),
        "/profile_edit": (_) => const ProfileEditPage(),
        "/home": (_) => const HomePage(),
        "/partner_detail": (_) => const PartnerDetailsPage(),
        "/musical_preferences": (_) => const MusicalPreferencesPage(),
        "/genree": (_) => const GenrePage(),
        "/dance_level": (_) => const DanceLevelPage(),
        "/register": (_) => RegisterPage(),
        "/map": (_) => MapPage(),
      },
    );
  }
}
