import 'package:mobx/mobx.dart';
import 'package:odoo_client/app/data/pojo/music_skill.dart';
part 'music_skills_controller.g.dart';

class MusicSkillsController = _MusicSkillsControllerBase
    with _$MusicSkillsController;

abstract class _MusicSkillsControllerBase with Store {
  @observable
  ObservableList<MusicSkill> _musicSkills = <MusicSkill>[].asObservable();

  ObservableList<MusicSkill> get musicSkills => _musicSkills;

  @observable
  MusicSkill _selected;

  MusicSkill get selected => _selected;

  @action
  void select(MusicSkill musicSkill) {
    _selected = musicSkill;
  }

  @action
  void init(List<MusicSkill> items, int musicSkillId) {
    _musicSkills = items.asObservable();
    _selected = items.firstWhere((element) => element.id == musicSkillId,
        orElse: () => null);
  }
}
