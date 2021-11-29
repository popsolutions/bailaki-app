import 'package:odoo_client/app/data/models/memory_image.dart';
import 'package:odoo_client/app/data/pojo/partner_detail.dart';
import 'package:odoo_client/app/data/pojo/partners.dart';
import 'package:odoo_client/app/data/services/odoo_api.dart';
import 'package:odoo_client/app/data/services/partner_service.dart';
import 'package:odoo_client/app/utility/strings.dart';

class PartnerServiceImpl implements PartnerService {
  final Odoo _odoo;

  PartnerServiceImpl(this._odoo);

  @override
  Future<List<Partner>> finAll(int currentPartnerId) async {
    final refferedFriendsResponse = await _odoo.searchRead('res.partner', [
      ['id', '=', currentPartnerId]
    ], [
      'referred_friend_ids'
    ]);

    final referredFriendsIds =
        refferedFriendsResponse.getRecords().first['referred_friend_ids'];

    final response = await _odoo.searchRead('res.partner', [
      ['id', 'in', referredFriendsIds]
    ], [
      'name',
      'birthdate_date',
      'partner_current_latitude',
      'partner_current_longitude',
      'res.partner.image'
    ]);

    final List<Partner> items =
        response.getRecords().map<Partner>((e) => Partner.fromJson(e)).toList();
    for (var item in items) {
      final response = (await _odoo.searchRead('res.partner.image', [
        ['res_partner_id', '=', item.id]
      ], [
        'id',
        'image'
      ]));
      item.photos =
          response.getRecords().map<Photo>((e) => Photo.fromJson(e)).toList();
    }
    print(items);

    return items;
  }

  @override
  Future<PartnerDetail> finById(int id) async {
    final partnerDetailResponse = await _odoo.searchRead(Strings.res_partner, [
      ["id", "=", id]
    ], [
      "age",
      "bio",
      "name",
      "email",
      "phone",
      "city",
      "title",
      "website",
      "jobPosition",
      "country",
      "birthdate",
      "gender",
      "activityState",
      "position",
      "images",
      "partner_current_latitude",
      "partner_current_longitude",
    ]);

    final photosResponse = await _odoo.searchRead('res.partner.image', [
      ['res_partner_id', '=', id]
    ], [
      'id',
      'image'
    ]);
    final images = photosResponse.getRecords() as List;

    final json = partnerDetailResponse?.getRecords()?.first;
    final item = PartnerDetail.fromJson({...json, "images": images});
    return item;
  }
}
