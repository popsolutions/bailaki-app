import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:odoo_client/app/data/models/event.dart';
import 'package:odoo_client/app/utility/global.dart';

class WebView_eventPage extends StatefulWidget {
  EventModel eventModel;

  WebView_eventPage(this.eventModel);
  @override
  _WebView_eventStatePage createState() => _WebView_eventStatePage();
}

class _WebView_eventStatePage extends State<WebView_eventPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dados do envento'),
        centerTitle: true,
      ),
      body: WebviewScaffold(url: widget.eventModel.urlEventOdoo()),
    );
  }
}
