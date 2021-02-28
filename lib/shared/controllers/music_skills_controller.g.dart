// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_skills_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MusicSkillsController on _MusicSkillsControllerBase, Store {
  final _$_musicSkillsAtom =
      Atom(name: '_MusicSkillsControllerBase._musicSkills');

  @override
  ObservableList<MusicSkill> get _musicSkills {
    _$_musicSkillsAtom.reportRead();
    return super._musicSkills;
  }

  @override
  set _musicSkills(ObservableList<MusicSkill> value) {
    _$_musicSkillsAtom.reportWrite(value, super._musicSkills, () {
      super._musicSkills = value;
    });
  }

  final _$_selectedAtom = Atom(name: '_MusicSkillsControllerBase._selected');

  @override
  MusicSkill get _selected {
    _$_selectedAtom.reportRead();
    return super._selected;
  }

  @override
  set _selected(MusicSkill value) {
    _$_selectedAtom.reportWrite(value, super._selected, () {
      super._selected = value;
    });
  }

  final _$_MusicSkillsControllerBaseActionController =
      ActionController(name: '_MusicSkillsControllerBase');

  @override
  void select(MusicSkill musicSkill) {
    final _$actionInfo = _$_MusicSkillsControllerBaseActionController
        .startAction(name: '_MusicSkillsControllerBase.select');
    try {
      return super.select(musicSkill);
    } finally {
      _$_MusicSkillsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void init(List<MusicSkill> items, int musicSkillId) {
    final _$actionInfo = _$_MusicSkillsControllerBaseActionController
        .startAction(name: '_MusicSkillsControllerBase.init');
    try {
      return super.init(items, musicSkillId);
    } finally {
      _$_MusicSkillsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
