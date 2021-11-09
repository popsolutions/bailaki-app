import 'package:latlong2/latlong.dart';

class EventModel {
  int id;
  String name;
  bool active;
  List<int> userId;
  List<int> companyId;
  List<int> organizerId;
  String dateBegin;
  String dateEnd;
  String state;
  List<int> addressId;
  LatLng position;

  EventModel({
    this.id,
    this.name,
    this.active,
    this.userId,
    this.companyId,
    this.organizerId,
    this.dateBegin,
    this.dateEnd,
    this.state,
    this.addressId,
    this.position,
  });

  EventModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    active = json['active'];
    userId = json['user_id'].cast<int>();
    companyId = json['company_id'].cast<int>();
    organizerId = json['organizer_id'].cast<int>();
    dateBegin = json['date_begin'];
    dateEnd = json['date_end'];
    state = json['state'];
    addressId = json['address_id'].cast<int>();
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['active'] = this.active;
    data['user_id'] = this.userId;
    data['company_id'] = this.companyId;
    data['organizer_id'] = this.organizerId;
    data['date_begin'] = this.dateBegin;
    data['date_end'] = this.dateEnd;
    data['state'] = this.state;
    data['address_id'] = this.addressId;
    data['position'] = this.position;
    return data;
  }
}
