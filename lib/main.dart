import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:odoo_client/app/pages/home/home_page.dart';
import 'package:odoo_client/app/pages/login/login_page.dart';
import 'package:odoo_client/app/pages/match/chat_page.dart';
import 'package:odoo_client/app/pages/patner/partner_detail_page.dart';
import 'package:odoo_client/app/pages/profile/dance_level_page.dart';
import 'package:odoo_client/app/pages/profile/dance_style_page.dart';
import 'package:odoo_client/app/pages/profile/genre_page.dart';
import 'package:odoo_client/app/pages/profile/my_profile_page.dart';
import 'package:odoo_client/app/pages/profile/profile_edit_page.dart';
import 'package:odoo_client/app/pages/settings/settings_page.dart';
import 'package:odoo_client/shared/injector/all_modules.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'app/utility/strings.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  setupAllModules();
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

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

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Strings.app_title,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: "Montserrat",
      ),
      initialRoute: "/login",
      builder: EasyLoading.init(),
      routes: {
        "/chat": (_) => const ChatPage(),
        "/settings": (_) => const SettingsPage(),
        "/login": (_) => const LoginPage(),
        "/profile": (_) => const MyProfilePage(),
        "/profile_edit": (_) => const ProfileEditPage(),
        "/home": (_) => const HomePage(),
        "/partner_detail": (_) => const PartnerDetailsPage(),
        "/musical_preferences": (_) => const MusicalPreferencesPage(),
        "/genree": (_) => const GenrePage(),
        "/dance_level": (_) => const DanceLevelPage()
      },
    );
  }
}
