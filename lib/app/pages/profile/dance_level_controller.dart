import 'package:mobx/mobx.dart';
import 'package:odoo_client/app/data/pojo/music_skill.dart';
import 'package:odoo_client/app/data/services/music_skill_service.dart';
part 'dance_level_controller.g.dart';

class DanceLevelController = _DanceLevelControllerBase
    with _$DanceLevelController;

abstract class _DanceLevelControllerBase with Store {
  final MusicSkillService _musicSkillService;
  _DanceLevelControllerBase(this._musicSkillService);

  @observable
  ObservableFuture<List<MusicSkill>> _musicSkillRequest =
      ObservableFuture.value(null);

  ObservableFuture<List<MusicSkill>> get musicSkillRequest =>
      _musicSkillRequest;

  @action
  void load() {
    _musicSkillRequest = _musicSkillService.findAll().asObservable();
  }
}
