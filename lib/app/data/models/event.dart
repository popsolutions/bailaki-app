import 'dart:convert';
import 'dart:ffi';

import 'package:latlong2/latlong.dart';

class EventModel {
  int id;
  String state;
  String name;
  String dateBegin;
  String dateEnd;
  int organizerId;
  String organizerName;
  String street;
  String zip;
  String city;
  String statename;
  LatLng position;
  double partnerCurrentLatitude;
  double partnerCurrentLongitude;

  EventModel({
    this.id,
    this.state,
    this.name,
    this.dateBegin,
    this.dateEnd,
    this.organizerId,
    this.organizerName,
    this.street,
    this.zip,
    this.city,
    this.statename,
    this.position,
    this.partnerCurrentLatitude,
    this.partnerCurrentLongitude,
  });

  // EventModel.fromJson(dynamic json) {
  //   id = json['id'];
  //   state = json['state'];
  //   name = json['name'];
  //   dateBegin = json['date_begin'];
  //   dateEnd = json['date_end'];
  //   organizerId = json['organizer_id'];
  //   organizerName = json['organizer_name'];
  //   street = json['street'];
  //   zip = json['zip'];
  //   city = json['city'];
  //   statename = json['statename'];
  //   partnerCurrentLatitude = json['partner_current_latitude'];
  //   partnerCurrentLongitude = json['partner_current_longitude'];
  //   position.latitude = json['partner_current_latitude'];
  //   position.longitude = json['partner_current_longitude'];
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['state'] = this.state;
  //   data['name'] = this.name;
  //   data['date_begin'] = this.dateBegin;
  //   data['date_end'] = this.dateEnd;
  //   data['organizer_id'] = this.organizerId;
  //   data['organizer_name'] = this.organizerName;
  //   data['street'] = this.street;
  //   data['zip'] = this.zip;
  //   data['city'] = this.city;
  //   data['statename'] = this.statename;
  //   data['partner_current_latitude'] = this.partnerCurrentLatitude;
  //   data['partner_current_longitude'] = this.partnerCurrentLongitude;
  //   data['partner_current_latitude'] = this.position.latitude;
  //   data['partner_current_longitude'] = this.position.longitude;
  //   return data;
  // }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'state': state,
      'name': name,
      'dateBegin': dateBegin,
      'dateEnd': dateEnd,
      'organizerId': organizerId,
      'organizerName': organizerName,
      'street': street,
      'zip': zip,
      'city': city,
      'statename': statename,
      'partnerCurrentLatitude': partnerCurrentLatitude,
      'partnerCurrentLongitude': partnerCurrentLongitude,
      'position': LatLng(
        partnerCurrentLatitude,
        partnerCurrentLongitude,
      ),
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      id: map['id'],
      state: map['state'],
      name: map['name'],
      dateBegin: map['dateBegin'],
      dateEnd: map['dateEnd'],
      organizerId: map['organizerId'],
      organizerName: map['organizerName'],
      street: map['street'],
      zip: map['zip'],
      city: map['city'],
      statename: map['statename'],
      partnerCurrentLatitude: map['partnerCurrentLatitude'],
      partnerCurrentLongitude: map['partnerCurrentLongitude'],
      position: LatLng(
        map['partnerCurrentLatitude'],
        map['partnerCurrentLongitude'],
      ),
    );
  }

  String toJson() => json.encode(toMap());
  factory EventModel.fromJson(dynamic source) => EventModel.fromMap(source);
}
