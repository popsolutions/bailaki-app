import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:odoo_client/app/utility/global.dart';
import 'package:odoo_client/shared/components/dialogs.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  bool popExecuted = false;

  void initState() {
    super.initState();

    flutterWebviewPlugin.onUrlChanged.listen((String url) async {
      print('*** url:' + url);
      if (url != globalConfig.serverURLRegisterPage) {
        if (popExecuted) return;

        if (url == 'https://bailaki.com.br/web?')
          globalServiceNotifier.cadastroRealizado = true;

        Navigator.pop(context);
        popExecuted = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastre-se'),
        centerTitle: true,
      ),
      body: WebviewScaffold(url: globalConfig.serverURLRegisterPage),
    );
  }
}
