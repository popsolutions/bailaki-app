import 'package:odoo_client/app/data/models/message.dart';

class Channel {
  final int channelId;
  final String name;
  final List<Message> messages;
  final int leftPartnerId;
  final int rightPartnerId;
  final List<PartnerChannel> partners;

  Channel({
    this.channelId,
    this.name,
    this.messages,
    this.leftPartnerId,
    this.rightPartnerId,
    this.partners,
  });

  String get lastMessage => messages.isNotEmpty ? messages.last.body : '';

  String chatterName(int partnerId) {
    return partners
        .firstWhere((element) => element.id != partnerId, orElse: () => null)
        ?.name;
  }

  factory Channel.fromJson(Map<String, dynamic> json) {
    return Channel(
      partners: json['partners']
          .map<PartnerChannel>((e) => PartnerChannel.fromJson(e))
          .toList(),
      name: json['name'],
      channelId: json['id'],
      messages: json['messages']
          ?.map((e) => Message.fromJson(json['messages']))
          ?.toList(),
      leftPartnerId: json['channel_partner_ids'].isNotEmpty
          ? json['channel_partner_ids'].first
          : null,
      rightPartnerId: json['channel_partner_ids'].isNotEmpty
          ? json['channel_partner_ids'].last
          : null,
    );
  }
}

class PartnerChannel {
  int id;
  String name;

  PartnerChannel({this.id, this.name});

  PartnerChannel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
