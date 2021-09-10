
/*
import 'package:flutter/material.dart';
import 'package:odoo_client/app/data/pojo/user.dart';
import 'package:odoo_client/app/data/services/odoo_api.dart';
import 'package:odoo_client/app/pages/home.dart';
import 'package:odoo_client/app/pages/settings.dart';
import 'package:odoo_client/base.dart';
import 'package:http/http.dart' as http;
import 'package:odoo_client/shared/components/custom_text_form_field.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends Base<Login> {
  String odooURL;
  String _selectedProtocol;
  String _selectedDb;
  String _email;
  String _pass;
  List<String> _dbList = [];
  List dynamicList = [];
  bool isCorrectURL = false;
  bool isDBFilter = false;
  TextEditingController _urlCtrler = new TextEditingController();
  TextEditingController _emailCtrler = new TextEditingController();
  TextEditingController _passCtrler = new TextEditingController();

  _checkFirstTime() {
    if (getURL() != null) {
      odooURL = getURL();
      _checkURL();
    }
  }

  _login() {
  //  if (isValid()) {

          odoo.authenticate(_email, _pass, _selectedDb).then(
            (http.Response auth) {
              if (auth.body != null) {
                User user = User.fromJson(jsonDecode(auth.body));
                if (user != null && user.result != null) {
                  print(auth.body.toString());
                  hideLoadingSuccess("Logged in successfully");
                  saveUser(json.encode(user));
                  saveOdooUrl(odooURL);
                  pushReplacement(Home());
                } else {
                  showMessage("Authentication Failed",
                      "Please Enter Valid Email or Password");
                }
              } else {
                showMessage("Authentication Failed",
                    "Please Enter Valid Email or Password");
              }
            },
          );
  
    //}
  }

  _checkURL() {
    isConnected().then((isInternet) {
      if (isInternet) {
        showLoading();
        // Init Odoo URL when URL is not saved
        odoo = new Odoo(url: odooURL);
        odoo.getDatabases().then((http.Response res) {
          setState(
            () {
              hideLoadingSuccess("Odoo Server Connected");
              isCorrectURL = true;
              dynamicList = json.decode(res.body)['result'] as List;
              saveOdooUrl(odooURL);
              dynamicList.forEach((db) => _dbList.add(db));
              _selectedDb = _dbList[0];
              if (_dbList.length == 1) {
                isDBFilter = true;
              } else {
                isDBFilter = false;
              }
            },
          );
        }).catchError(
          (e) {
            showMessage("Warning", "Invalid URL");
          },
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();

    getOdooInstance().then((odoo) {
      _checkFirstTime();
    });
  }

  bool isValid() {
    _email = _emailCtrler.text;
    _pass = _passCtrler.text;
    if (_email.length > 0 && _pass.length > 0) {
      return true;
    } else {
      showSnackBar("Please enter valid email and password");
      return false;
    }
  }

  _signup() async {
    const url = 'https://bailaki.com.br/web/signup';
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    final checkButton = Container(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      width: MediaQuery.of(context).size.width,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onPressed: !isCorrectURL
            ? () {
                if (_urlCtrler.text.length == 0) {
                  showSnackBar("Please enter valid URL");
                  return;
                }
                odooURL = 'https://bailaki.com.br';
                _checkURL();
              }
            : null,
        padding: EdgeInsets.all(12),
        color: Colors.indigo.shade400,
        child: Text(
          'Connect Odoo Server',
          style: TextStyle(
            fontFamily: "Montserrat",
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );

    final protocol = Container(
      width: MediaQuery.of(context).size.width,
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border:
            Border.all(color: Color.fromRGBO(112, 112, 112, 3.0), width: 1.0),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 20.0),
        child: DropdownButton<String>(
          isExpanded: true,
          value: _selectedProtocol,
          onChanged: (String newValue) {
            setState(
              () {
                _selectedProtocol = newValue;
              },
            );
          },
          underline: SizedBox(height: 0.0),
          items: <String>['http', 'https'].map<DropdownMenuItem<String>>(
            (String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Montserrat",
                  ),
                ),
              );
            },
          ).toList(),
        ), //DropDownButton
      ),
    );

    final dbs = isDBFilter
        ? SizedBox(height: 0.0)
        : Container(
            width: MediaQuery.of(context).size.width,
            decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                    color: Color.fromRGBO(112, 112, 112, 3.0), width: 1.0)),
            child: Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: DropdownButton<String>(
                value: _selectedDb,
                onChanged: (String newValue) {
                  setState(() {
                    _selectedDb = newValue;
                  });
                },
                isExpanded: true,
                underline: SizedBox(height: 0.0),
                hint: Text(
                  "Select Database",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                  ),
                ),
                items: _dbList.map(
                  (db) {
                    return DropdownMenuItem(
                      child: Text(
                        db,
                        style:
                            TextStyle(fontFamily: "Montserrat", fontSize: 18),
                      ),
                      value: db,
                    );
                  },
                ).toList(),
              ),
            ),
          );

    final odooUrl = TextField(
      autofocus: false,
      controller: _urlCtrler,
      decoration: InputDecoration(
        labelText: "Odoo Server URL",
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
    );

    final email = CustomTextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: _emailCtrler,
        labelText: "E-mail",

    );

    final password = CustomTextFormField(
      controller: _passCtrler,
      obscureText: true,
      labelText: "Password",
    );

    final loginButton = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onPressed: () {
          _login();
        },
        padding: EdgeInsets.all(12),
        color: Color.fromRGBO(254, 0, 236, 1),
        child: Text(
          'Log In',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: "Montserrat",
            color: Color.fromRGBO(2, 255, 235, 1),
          ),
        ),
      ),
    );

    final signupButton = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onPressed: () {
          _signup();
        },
        padding: EdgeInsets.all(12),
        color: Color.fromRGBO(254, 0, 236, 1),
        child: Text(
          'Signup',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: "Montserrat",
            color: Color.fromRGBO(2, 255, 235, 1),
          ),
        ),
      ),
    );

    final checkURLWidget = Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 24.0),
          protocol,
          SizedBox(height: 8.0),
          odooUrl,
          SizedBox(height: 8.0),
          checkButton,
          SizedBox(height: 8.0),
        ],
      ),
    );

    final loginWidget = Container(
      alignment: Alignment.bottomCenter,
      child: Column(
        children: <Widget>[
          dbs,
          const SizedBox(height: 18.0),
          email,
          const SizedBox(height: 8.0),
          password,
          const SizedBox(height: 24.0),
          loginButton
        ],
      ),
    );

    final signupWidget = Container(
      alignment: Alignment.bottomCenter,
      child: Column(
        children: <Widget>[signupButton],
      ),
    );

    final loginBackgroud = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(2, 255, 235, 1),
            Color.fromRGBO(128, 128, 236, 1),
            Color.fromRGBO(254, 0, 236, 1),
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Column(children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "./lib/app/assets/bailakil_logo.png",
                width: 40,
                height: 40,
                fit: BoxFit.fill,
              ),
              SizedBox(
                width: 3,
              ),
              Text(
                "Bailaki",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    letterSpacing: -2.0),
              ),
            ],
          ),
        ),
      ]),
    );

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        key: scaffoldKey,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(2, 255, 235, 1),
                Color.fromRGBO(128, 128, 236, 1),
                Color.fromRGBO(254, 0, 236, 1),
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: ListView(
            // padding: EdgeInsets.all(75.0),
            padding: EdgeInsets.fromLTRB(60, 70, 60, 0),
            children: <Widget>[
              Container(
                // margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "./lib/app/assets/bailakil_logo.png",
                      width: 40,
                      height: 40,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text(
                      "Bailaki",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          letterSpacing: -2.0),
                    )
                  ],
                ),
              ),
              getURL() == null ? checkURLWidget : SizedBox(height: 0.0),
              loginWidget,
              signupWidget,
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "By tapping Log in, you agree with our",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Terms of service",
                            style: TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            " and ",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Privacy Policy",
                            style: TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Trouble logging in?",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "We don't post anything on Facebook",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        floatingActionButton: isLoggedIn()
            ? FloatingActionButton(
                child: Icon(Icons.settings),
                onPressed: () {
                  pushReplacement(Settings());
                },
              )
            : SizedBox(height: 0.0),
      ),
    );
  }
}
*/