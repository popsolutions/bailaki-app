import 'package:odoo_client/app/data/pojo/music_skill.dart';
import 'package:odoo_client/app/data/services/music_skill_service.dart';
import 'package:odoo_client/app/data/services/odoo_api.dart';

class MusicSkillServiceImpl implements MusicSkillService {
  final Odoo _odoo;

  MusicSkillServiceImpl(this._odoo);

  @override
  Future<List<MusicSkill>> findAll() async {
    final response =
        await _odoo.searchRead('res.partner.music.skill', [], ["id", "name"]);
    final items = response
        .getRecords()
        .map<MusicSkill>((e) => MusicSkill.fromJson(e))
        .toList();

    return items;
  }
}
