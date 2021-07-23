import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:odoo_client/app/data/services/channel_facade.dart';
import 'package:odoo_client/app/pages/match/components/chat_tile.dart';
import 'package:odoo_client/app/pages/match/match_controller.dart';
import 'package:odoo_client/shared/controllers/authentication_controller.dart';

class MatchPage extends StatefulWidget {
  const MatchPage({Key key}) : super(key: key);
  @override
  _MatchPageState createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  AuthenticationController _authenticationController;
  MatchController _matchController;

  @override
  void initState() {
    super.initState();
    _authenticationController = GetIt.I.get<AuthenticationController>();
    _matchController = GetIt.I.get<MatchController>();
    _matchController.currentPartnerId =
        _authenticationController.currentUser.partnerId;
    _matchController.load();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
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
                          ),
                        ),
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
                const SizedBox(height: 10),
              ],
            ),
          ),
          Expanded(
            child: Observer(builder: (_) {
              final response = _matchController.matchesRequest;
              final items = response.value;
              switch (response.status) {
                case FutureStatus.rejected:
                  return Center(child: Text("erro"));
                case FutureStatus.pending:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                default:
                  if (items.isEmpty) {
                    return Center(
                        child: Text('Você ainda não possui mensagens'));
                  }

                  return ListView.builder(
                      physics: ScrollPhysics(),
                      padding: const EdgeInsets.only(top: 12),
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        final item = items[index];
                        final inverseChatter = item.inverseChatter(
                            _authenticationController.currentUser.partnerId);
                        return ChatTile(
                          imageBytes: inverseChatter?.photo?.bytes,
                          description: item.lastMessage ?? '',
                          name: inverseChatter.name,
                          padding: const EdgeInsets.all(18),
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed("/chat", arguments: item);
                          },
                        );
                      },
                      itemCount: items.length);
              }
            }),
          )
        ],
      ),
    );
  }
}
