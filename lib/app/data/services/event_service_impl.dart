import 'package:odoo_client/app/data/models/social_event.dart';
import 'package:odoo_client/app/data/services/event_service.dart';
import 'package:odoo_client/app/data/services/odoo_api.dart';

class EventServiceImpl implements EventService {
  final Odoo _odoo;

  EventServiceImpl(this._odoo);
  @override
  Future<List> findEvents() async {
    final eventsResponse = await _odoo.searchRead('event.event', [], [
      'id',
      'name',
      'date_begin',
      'date_end',
      'description',
      'event_logo',
      'event_type_id',
      'organizer_id',
      'is_online',
      'active'
    ]);
    final events = eventsResponse.getRecords() as List;
    for (var event in events) {
      final organizerResponse = await _odoo.searchRead('res.partner', [], [
        'id',
        'name',
        'partner_current_latitude',
        'partner_current_longitude'
      ]);

      final organizer = organizerResponse.getRecords().first;

      event['organizer_id'] = organizer['id'];
      event['organizer_name'] = organizer['name'];
      event['partner_current_latitude'] = organizer['partner_current_latitude'];
      event['partner_current_longitude'] =
          organizer['partner_current_longitude'];
    }

    return events.map((e) => SocialEvent.fromJson(e)).toList();
  }
}
