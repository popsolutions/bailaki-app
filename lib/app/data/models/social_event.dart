import 'package:latlng/latlng.dart';

class SocialEvent {
  int id;
  String name;
  DateTime dateBegin;
  DateTime dateEnd;
  String description;
  String eventLogo;
  int eventTypeId;
  bool isOnline;
  bool active;
  LatLng position;
  int organizerId;
  String organizerName;

  SocialEvent(
      {this.id,
      this.name,
      this.dateBegin,
      this.dateEnd,
      this.description,
      this.eventLogo,
      this.eventTypeId,
      this.isOnline,
      this.active});

  SocialEvent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] is! bool ? json['name'] : null;
    dateBegin =
        json['date_begin'] is! bool ? DateTime.parse(json['date_begin']) : null;
    dateEnd =
        json['date_end'] is! bool ? DateTime.parse(json['date_end']) : null;
    description = json['description'] is! bool ? json['description'] : null;
    eventLogo = json['event_logo'] is! bool ? json['event_logo'] : null;
    eventTypeId = json['event_type_id'].first;
    isOnline = json['is_online'];
    active = json['active'];
    position = LatLng(
        json['partner_current_latitude'], json['partner_current_longitude']);
    organizerId = json['organizer_id'];
    organizerName = json['organizer_name'];
  }
}
