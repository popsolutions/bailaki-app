import 'package:odoo_client/app/data/models/memory_image.dart';
import 'package:collection/collection.dart';

class Channel {
  final int channelId;
  final String name;
  final int leftPartnerId;
  final int rightPartnerId;
  String lastMessage;
  int amount_newmessages;
  bool newChannel = false;
  final List<PartnerChannel> partners;

  Channel({
    this.channelId,
    this.name,
    this.leftPartnerId,
    this.rightPartnerId,
    this.lastMessage,
    this.partners,
    this.amount_newmessages
  });

  PartnerChannel inverseChatter(int partnerId) {
    return partners.firstWhere((element) => element.id != partnerId,
        orElse: () => null);
  }

  factory Channel.fromJson(Map<String, dynamic> json) {
    return Channel(
      partners: json['partners']
          .map<PartnerChannel>((e) => PartnerChannel.fromJson(e))
          .toList(),
      name: json['name'],
      channelId: json['channelId'],
      lastMessage: json['lastMessage']?.replaceAll('<p>', '')?.replaceAll('</p>', ''),
      leftPartnerId: json['leftPartnerId'],
      rightPartnerId: json['rightPartnerId'],
      amount_newmessages: json['amount_newmessages']
    );
  }

  PartnerChannel getPartnerOther(int partnerIdOther){
    return partners.firstWhereOrNull((element) => element.id != partnerIdOther);
  }
}

class PartnerChannel {
  int id;
  String name;
  Photo photo;

  PartnerChannel({this.id, this.name});

  PartnerChannel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'] != null ? Photo.fromJsonImage(json['photo']) : null;
  }
}
