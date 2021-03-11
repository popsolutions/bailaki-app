import 'package:flutter/material.dart';
import 'package:odoo_client/app/pages/match/components/chat_tile.dart';

class MatchPage extends StatefulWidget {
  const MatchPage({Key key}) : super(key: key);
  @override
  _MatchPageState createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //onTap: Focus.of(context).unfocus,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          leading: Navigator.canPop(context)
              ? BackButton(
                  color: Colors.black,
                )
              : null,
          title: Text(
            "Match",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.grey[100],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18, right: 18, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.red,
                          size: 27,
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: TextField(
                            decoration: InputDecoration.collapsed(
                                enabled: true,
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 0.5,
                                    color: Colors.red,
                                  ),
                                ),
                                hintText: "Buscar matches",
                                hintStyle: TextStyle(
                                  fontSize: 22,
                                )),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    Text(
                      "Mensagens",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 19,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                  padding: const EdgeInsets.only(top: 25),
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    return ChatTile(
                      padding: const EdgeInsets.all(18),
                      onTap: () {
                        Navigator.of(context).pushNamed("/chat");
                      },
                    );
                  },
                  itemCount: 2)
            ],
          ),
        ),
      ),
    );
  }
}
