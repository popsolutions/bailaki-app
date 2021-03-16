import 'package:odoo_client/app/data/services/odoo_api.dart';
import 'package:odoo_client/app/data/models/match.dart';

abstract class MatchService {
  Future<List<Match>> findByPartnerId(MatchRequestDto matchRequestDto);
}

class MatchServiceImpl implements MatchService {
  final Odoo _odoo;

  MatchServiceImpl(this._odoo);

  Future<List<Match>> findByPartnerId(MatchRequestDto matchRequestDto) async {
    final relationTypeResponse =
        await _odoo.searchRead('res.partner.relation.type', [
      ['name', '=', 'Match']
    ], [
      'id',
      'name'
    ]);

    final relationTypeId = relationTypeResponse.getRecords()[0]["id"];

    final matchsResponse = await _odoo.searchRead('res.partner.relation', [
      ['type_id', '=', relationTypeId],
      '|',
      ['left_partner_id', '=', matchRequestDto.currentPartnerId],
      ['right_partner_id', '=', matchRequestDto.partnerId],
      '|',
      ['left_partner_id', '=', matchRequestDto.partnerId],
      ['right_partner_id', '=', matchRequestDto.currentPartnerId],
    ], []);

    final matches = matchsResponse
        .getRecords()
        ?.map<Match>((e) => Match.fromJson(e))
        ?.toList();
    return matches;
  }
}

class MatchRequestDto {
  final int partnerId;
  final int currentPartnerId;

  MatchRequestDto({this.partnerId, this.currentPartnerId});
}
