import 'package:odoo_client/app/data/services/odoo_api.dart';
import 'package:odoo_client/app/data/models/match.dart';

abstract class MatchService {
  Future<List<Match>> findByPartnerId(MatchRequestDto matchRequestDto);
  Future<List<Match>> findAll(int currentPartnerId);
}

class MatchServiceImpl implements MatchService {
  final Odoo _odoo;

  MatchServiceImpl(this._odoo);

  Future<List<Match>> findAll(int currentPartnerId) async {
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
      [
        'left_partner_id',
        'in',
        [currentPartnerId]
      ],
      [
        'right_partner_id',
        'in',
        [currentPartnerId]
      ]
    ], []);

    final matches = (matchsResponse.getRecords() as List)
        ?.map<Match>((e) => Match.fromJson(e))
        ?.toList();

    return matches;
  }

  Future<List<Match>> findByPartnerId(MatchRequestDto matchRequestDto) async {
    final partnerIds = [
      matchRequestDto.currentPartnerId,
      matchRequestDto.partnerId
    ];
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
      ['left_partner_id', 'in', partnerIds],
      ['right_partner_id', 'in', partnerIds]
    ], []);

    final matches = (matchsResponse.getRecords() as List)
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
