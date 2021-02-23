import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:odoo_client/app/pages/profile/my_profile_controller.dart';
import 'package:odoo_client/shared/controllers/authentication_controller.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key key}) : super(key: key);
  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  AuthenticationController _authenticationController;
  MyProfileController _myProfileController;

  @override
  void initState() {
    _authenticationController = GetIt.I.get<AuthenticationController>();
    final user = _authenticationController.currentUser;
    _myProfileController = GetIt.I.get<MyProfileController>();
    _myProfileController.loadProfile(user.uid, user.partnerId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      final response = _myProfileController.profile;
      final data = response.value;
      switch (response.status) {
        case FutureStatus.rejected:
          return Center(
            child: Text('Erro has occurred'),
          );
        case FutureStatus.pending:
          return Center(
            child: CircularProgressIndicator(),
          );
        default:
          return Scaffold(
            appBar: AppBar(
              title: Text("Profile"),
              actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.exit_to_app),
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext ctxt) {
                          return AlertDialog(
                            title: Text(
                              "Logged Out",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            content: Text(
                              "Are you sure you want to logged out?",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              FlatButton(
                                onPressed: () {
                                  // _clearPrefs();
                                },
                                child: Text(
                                  "Logout",
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    })
              ],
            ),
            body: Column(
              children: <Widget>[
                Container(
                  color: Colors.pink,
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () => Navigator.of(context)
                                .pushNamed("/profile_edit"),
                            child: Container(
                              width: 150.0,
                              height: 150.0,
                              padding: EdgeInsets.all(10.0),
                              margin: EdgeInsets.all(25.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 25.0,
                                    color: Colors.pink,
                                  )
                                ],
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                    data.imageUrl ??
                                        "https://i1.wp.com/www.molddrsusa.com/wp-content/uploads/2015/11/profile-empty.png.250x250_q85_crop.jpg?ssl=1",
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              data.name ?? '',
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Montserrat",
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              data.email ?? '',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontFamily: "Montserrat",
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: ListView(
                      children: <Widget>[
                        //Biography
                        Container(
                          height: 120,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(padding: EdgeInsets.only(right: 10.0)),
                              Icon(Icons.location_city),
                              Padding(padding: EdgeInsets.only(left: 10.0)),
                              Container(
                                padding: EdgeInsets.only(
                                    left: 10.0, bottom: 9.0, top: 9.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      data.bio ?? '',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: "Montserrat",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(),

                        //Gender
                        Container(
                          height: 75,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(padding: EdgeInsets.only(right: 10.0)),
                              Icon(Icons.person_pin),
                              Padding(padding: EdgeInsets.only(left: 10.0)),
                              Text(
                                data.gender ?? '',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: "Montserrat",
                                ),
                              ),
                            ],
                          ),
                        ),
                        //Birth Date
                        Divider(),
                        Container(
                          height: 75,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            children: <Widget>[
                              Padding(padding: EdgeInsets.only(right: 10.0)),
                              Icon(Icons.title, color: Colors.black),
                              Padding(padding: EdgeInsets.only(left: 10.0)),
                              Text(
                                data.birth ?? '',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: "Montserrat",
                                ),
                              ),
                            ],
                          ),
                        ),
                        //Title
                        Divider(),
                        Container(
                          height: 75,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            children: <Widget>[
                              Padding(padding: EdgeInsets.only(right: 10.0)),
                              Icon(Icons.title, color: Colors.black),
                              Padding(padding: EdgeInsets.only(left: 10.0)),
                              Text(
                                data.title ?? '',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: "Montserrat",
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        Container(
                          height: 75,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            children: <Widget>[
                              Padding(padding: EdgeInsets.only(right: 10.0)),
                              Icon(Icons.web_asset, color: Colors.black),
                              Padding(padding: EdgeInsets.only(left: 10.0)),
                              Text(
                                data.website ?? '',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: "Montserrat",
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        Container(
                          height: 75,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            children: <Widget>[
                              Padding(padding: EdgeInsets.only(right: 10.0)),
                              Icon(Icons.phone_android, color: Colors.black),
                              Padding(padding: EdgeInsets.only(left: 10.0)),
                              Text(
                                data.mobile ?? '',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: "Montserrat",
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        Container(
                          height: 75,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            children: <Widget>[
                              Padding(padding: EdgeInsets.only(right: 10.0)),
                              Icon(Icons.phone, color: Colors.black),
                              Padding(padding: EdgeInsets.only(left: 10.0)),
                              Text(
                                data.phone ?? '',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: "Montserrat",
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
      }
    });
  }
}
