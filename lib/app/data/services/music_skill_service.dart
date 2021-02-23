import 'package:odoo_client/app/data/pojo/music_skill.dart';

abstract class MusicSkillService {
  Future<List<MusicSkill>> findAll();
}

