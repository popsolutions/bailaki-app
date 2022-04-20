import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:odoo_client/app/utility/global.dart';

class ForgotoPasswordPage extends StatefulWidget {
  @override
  _ForgotoPasswordPageState createState() => _ForgotoPasswordPageState();
}

class _ForgotoPasswordPageState extends State<ForgotoPasswordPage> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  bool popExecuted = false;

  void initState() {
    super.initState();

    flutterWebviewPlugin.onUrlChanged.listen((String url) {
      print('*** url:' + url);
      if (url != globalConfig.serverForgotoPassword) {
        if (popExecuted) return;

        print('*** url--- POP');
        Navigator.pushReplacementNamed(context, '/login');
        popExecuted = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recuperar Senha'),
        centerTitle: true,
      ),
      body: WebviewScaffold(url: globalConfig.serverForgotoPassword),
    );
  }
}
