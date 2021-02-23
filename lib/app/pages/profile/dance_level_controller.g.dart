// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dance_level_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DanceLevelController on _DanceLevelControllerBase, Store {
  final _$_musicSkillRequestAtom =
      Atom(name: '_DanceLevelControllerBase._musicSkillRequest');

  @override
  ObservableFuture<List<MusicSkill>> get _musicSkillRequest {
    _$_musicSkillRequestAtom.reportRead();
    return super._musicSkillRequest;
  }

  @override
  set _musicSkillRequest(ObservableFuture<List<MusicSkill>> value) {
    _$_musicSkillRequestAtom.reportWrite(value, super._musicSkillRequest, () {
      super._musicSkillRequest = value;
    });
  }

  final _$_DanceLevelControllerBaseActionController =
      ActionController(name: '_DanceLevelControllerBase');

  @override
  void load() {
    final _$actionInfo = _$_DanceLevelControllerBaseActionController
        .startAction(name: '_DanceLevelControllerBase.load');
    try {
      return super.load();
    } finally {
      _$_DanceLevelControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
