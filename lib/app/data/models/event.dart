import 'dart:convert';
import 'dart:ffi';

import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:odoo_client/app/data/services/utils.dart';
import 'package:odoo_client/app/utility/global.dart';

class EventModel {
  int id;
  String state;
  String name;
  DateTime date_begin;
  DateTime date_end;
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
    this.date_begin,
    this.date_end,
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
  //   date_end = json['date_end'];
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
  //   data['date_end'] = this.date_end;
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
      'date_begin': date_begin,
      'date_end': date_end,
      'organizerId': organizerId,
      'organizerName': organizerName,
      'street': street,
      'zip': zip,
      'city': city,
      'statename': statename,
      'partner_current_latitude': partnerCurrentLatitude,
      'partner_current_longitude': partnerCurrentLongitude,
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
      date_begin: map['date_begin'] is! bool ? DateTime.parse(map['date_begin']) : null,
      date_end: map['date_end'] is! bool ? DateTime.parse(map['date_end']) : null,
      organizerId: map['organizerId'],
      organizerName: map['organizerName'],
      street: map['street'],
      zip: map['zip'],
      city: map['city'],
      statename: map['statename'],
      partnerCurrentLatitude: map['partner_current_latitude'],
      partnerCurrentLongitude: map['partner_current_longitude'],
      position: LatLng(
        map['partner_current_latitude'],
        map['partner_current_longitude'],
      ),
    );
  }

  String toJson() => json.encode(toMap());
  factory EventModel.fromJson(dynamic source) => EventModel.fromMap(source);

  String urlEventOdoo(){
    //Gerar a Url equivalente a url gerada pelo gerador de site do Odoo:
    // A url é gerada no formato <host>event/<Nome_Evento>-<startdate_YYYY_DD_MM>-<enddate_YYYY_DD_MM>-<id>/register

    String dateStr(DateTime date) => DateFormat('yyyy-MM-dd').format(date);

    String url = '/event/${Utils.removeDiacritics(name.replaceAll(' ', '-'))}-${dateStr(date_begin)}-${dateStr(date_end)}-${id.toString()}/register';
    url = globalConfig.serverURL + url;
    return url;
  }
}
