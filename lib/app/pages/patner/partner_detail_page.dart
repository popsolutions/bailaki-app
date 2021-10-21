import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:odoo_client/app/pages/patner/partner_detail_controller.dart';
import 'package:odoo_client/shared/controllers/authentication_controller.dart';
import 'package:odoo_client/shared/utils/distance_between.dart';

class PartnerDetailsPage extends StatefulWidget {
  const PartnerDetailsPage({Key key}) : super(key: key);
  @override
  _PartnerDetailsPageState createState() => _PartnerDetailsPageState();
}

class _PartnerDetailsPageState extends State<PartnerDetailsPage>
    with SingleTickerProviderStateMixin {
  int id;

  PartnerDetailController _partnerDetailController;
  AuthenticationController _authenticationController;

  @override
  void initState() {
    _authenticationController = GetIt.I.get<AuthenticationController>();
    _partnerDetailController = GetIt.I.get<PartnerDetailController>();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (id == null) {
      id = ModalRoute.of(context).settings.arguments as int;
      _partnerDetailController.loadPartner(id);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final user = _authenticationController.currentUser;
    return Scaffold(
      appBar: AppBar(
          leading: Navigator.canPop(context)
              ? BackButton(
                  color: Colors.black,
                )
              : null,
          backgroundColor: Colors.grey[100]),
      backgroundColor: Colors.grey[100],
      body: Observer(builder: (_) {
        final response = _partnerDetailController.partner;
        final data = response.value;
        switch (response.status) {
          case FutureStatus.rejected:
            return Center(
              child: Text('Error has occurred'),
            );
          case FutureStatus.pending:
            return Center(
              child: CircularProgressIndicator(),
            );
          default:
            final distance = distanceBetween(
                user.position.latitude,
                user.position.longitude,
                data.position.latitude,
                data.position.longitude);
            return SafeArea(
              child: LayoutBuilder(builder: (context, constraints) {
                return SingleChildScrollView(
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DefaultTabController(
                          initialIndex: 0,
                          length: data.images.length,
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Container(
                                height: 350,
                                child: TabBarView(
                                  children: data.images
                                      .map(
                                        (e) => Image.memory(
                                          e.bytes,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: TabPageSelector(
                                  indicatorSize: 8,
                                  selectedColor: Colors.white,
                                  color: Colors.grey[400],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${data.name}, ${data.age}",
                                      style: TextStyle(fontSize: 24),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "${data.city}/${data.activityState} - ${distance} Km",
                                      style: TextStyle(
                                        color: Color.fromRGBO(142, 144, 141, 1),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: const Divider(
                                        thickness: 1,
                                        color: Color.fromRGBO(200, 203, 199, 1),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      "${data.bio}",
                                      style: TextStyle(
                                        color: Color.fromRGBO(142, 144, 141, 1),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: const Divider(
                                        thickness: 1,
                                        color: Color.fromRGBO(200, 203, 199, 1),
                                      ),
                                    ),
                                    /*
                                    const SizedBox(height: 12),
                                    Text(
                                      "3 amigos em comum",
                                      style: TextStyle(
                                        color: Color.fromRGBO(142, 144, 141, 1),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    */
                                  ],
                                ),
                              ),
                              /*
                              Container(
                                height: 100,
                                child: ListView.separated(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 20),
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder: (_, index) =>
                                      const SizedBox(width: 20),
                                  itemBuilder: (_, index) {
                                    final item = imgs[index];

                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 36,
                                          backgroundImage: NetworkImage(item),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          "Ada Lovelace",
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Color.fromRGBO(
                                                  161, 166, 164, 1)),
                                        )
                                      ],
                                    );
                                  },
                                  itemCount: 5,
                                ),
                              )
                              */
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            );
        }
      }),
    );
  }
}

/*
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:odoo_client/app/pages/patner/partner_detail_controller.dart';

class PartnerDetailsPage extends StatefulWidget {
  const PartnerDetailsPage({Key key}) : super(key: key);
  @override
  _PartnerDetailsPageState createState() => _PartnerDetailsPageState();
}

class _PartnerDetailsPageState extends State<PartnerDetailsPage> {
  PartnerDetailController _partnerDetailController;
  int id;

  @override
  void initState() {
    _partnerDetailController = GetIt.I.get<PartnerDetailController>();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (id == null) {
      id = ModalRoute.of(context).settings.arguments as int;
      _partnerDetailController.loadPartner(id);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
        final response = _partnerDetailController.partner;
        final data = response.value;
        switch (response.status) {
          case FutureStatus.rejected:
            return Center(
              child: Text('Error has occurred'),
            );
          case FutureStatus.pending:
            return Center(
              child: CircularProgressIndicator(),
            );
          default:
            return Scaffold(
      
      body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    expandedHeight: 260.0,
                    floating: false,
                    pinned: false,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 50),
                            ),
                            new Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.pink, width: 1.0),
                                borderRadius: BorderRadius.circular(70.0),
                              ),
                              padding: EdgeInsets.all(8.0),
                              child: Container(
                                height: 110,
                                width: 110,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.pink,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    data.imageUrl ??
                                        "https://image.flaticon.com/icons/png/512/1144/1144760.png",
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                                padding:
                                    EdgeInsets.only(top: 5.0, bottom: 5.0)),
                            Text(
                              data.name,
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                                padding:
                                    EdgeInsets.only(top: 2.0, bottom: 2.0)),
                            Text(
                              '${data.age}',
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                                padding:
                                    EdgeInsets.only(top: 8.0, bottom: 35.0)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ];
              },
              body: Container(
                child: ListView(
                  children: <Widget>[
                    //BIOGRAPHY
                    Container(
                      height: 75,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(10.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.grey.shade100,
                        child: Row(
                          children: <Widget>[
                            Padding(padding: EdgeInsets.only(right: 10.0)),
                            Image(
                              image: AssetImage("assets/worker.png"),
                              height: 30.0,
                              width: 30.0,
                            ),
                            Padding(padding: EdgeInsets.only(left: 10.0)),
                            Text(
                              data.bio ?? "",
                              style: TextStyle(
                                fontSize: 19.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Montserrat",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: 75,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(10.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          color: Colors.grey.shade100,
                          child: Row(
                            children: <Widget>[
                              Padding(padding: EdgeInsets.only(right: 10.0)),
                              Image(
                                image: AssetImage("assets/mister.png"),
                                height: 30.0,
                                width: 30.0,
                              ),
                              Padding(padding: EdgeInsets.only(left: 10.0)),
                              Text(
                                data.title ?? "",
                                style: TextStyle(
                                  fontSize: 19.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Montserrat",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      child: Container(
                        height: 75,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(10.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          color: Colors.grey.shade100,
                          child: Row(
                            children: <Widget>[
                              Padding(padding: EdgeInsets.only(right: 10.0)),
                              Image(
                                image: AssetImage("assets/web.png"),
                                height: 30.0,
                                width: 30.0,
                              ),
                              Padding(padding: EdgeInsets.only(left: 10.0)),
                              Text(
                                data.website ?? "",
                                style: TextStyle(
                                  fontSize: 19.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Montserrat",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      child: Container(
                        height: 75,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(10.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          color: Colors.grey.shade100,
                          child: Row(
                            children: <Widget>[
                              Padding(padding: EdgeInsets.only(right: 10.0)),
                              Image(
                                image: AssetImage("assets/mobile.png"),
                                height: 30.0,
                                width: 30.0,
                              ),
                              Padding(padding: EdgeInsets.only(left: 10.0)),
                              Text(
                                data.mobile ?? "",
                                style: TextStyle(
                                  fontSize: 19.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Montserrat",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      child: Container(
                        height: 75,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(10.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          color: Colors.grey.shade100,
                          child: Row(
                            children: <Widget>[
                              Padding(padding: EdgeInsets.only(right: 10.0)),
                              Image(
                                image: AssetImage("assets/call.png"),
                                height: 30.0,
                                width: 30.0,
                              ),
                              Padding(padding: EdgeInsets.only(left: 10.0)),
                              Text(
                                data.phone ?? "",
                                style: TextStyle(
                                  fontSize: 19.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Montserrat",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      child: Container(
                        height: 163,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(10.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          color: Colors.grey.shade100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(padding: EdgeInsets.only(right: 10.0)),
                              Image(
                                image: AssetImage("assets/user_location.png"),
                                height: 30.0,
                                width: 30.0,
                              ),
                              Padding(padding: EdgeInsets.only(left: 10.0)),
                              Container(
                                padding: EdgeInsets.only(
                                    left: 10.0, bottom: 9.0, top: 9.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      data.street,
                                      style: TextStyle(
                                        fontSize: 19.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Montserrat",
                                      ),
                                    ),
                                    Text(
                                      data.city,
                                      style: TextStyle(
                                        fontSize: 19.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Montserrat",
                                      ),
                                    ),
                                    Text(
                                      data.stateId,
                                      style: TextStyle(
                                        fontSize: 19.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Montserrat",
                                      ),
                                    ),
                                    Text(
                                      data.zip,
                                      style: TextStyle(
                                        fontSize: 19.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Montserrat",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
            );
        }
      });
    
  }
}
*/
