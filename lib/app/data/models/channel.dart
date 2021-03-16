import 'package:odoo_client/app/data/models/message.dart';

class Channel {
  final int channelId;
  final String name;
  final List<Message> messages;
  final int leftPartnerId;
  final int rightPartnerId;
  Channel(
      {this.channelId,
      this.name,
      this.messages,
      this.leftPartnerId,
      this.rightPartnerId});

  String get lastMessage => messages.isNotEmpty ? messages.last.body : '';

  String chatterName(int partnerId) {
    final partnerNames = name.split(',');
    return leftPartnerId == partnerId ? partnerNames.first : partnerNames.last;
  }

  factory Channel.fromJson(Map<String, dynamic> json) {
    return Channel(
      name: json['name'],
      channelId: json['id'],
      messages: json['messages']
          ?.map((e) => Message.fromJson(json['messages']))
          ?.toList(),
      leftPartnerId: json['left_partner_id'],
      rightPartnerId: json['right_partner_id'],
    );
  }
}