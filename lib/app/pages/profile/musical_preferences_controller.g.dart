// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'musical_preferences_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MusicalPreferencesController
    on _MusicalPreferencesControllerBase, Store {
  final _$_musicGenreRequestAtom =
      Atom(name: '_MusicalPreferencesControllerBase._musicGenreRequest');

  @override
  ObservableFuture<List<MusicGenre>> get _musicGenreRequest {
    _$_musicGenreRequestAtom.reportRead();
    return super._musicGenreRequest;
  }

  @override
  set _musicGenreRequest(ObservableFuture<List<MusicGenre>> value) {
    _$_musicGenreRequestAtom.reportWrite(value, super._musicGenreRequest, () {
      super._musicGenreRequest = value;
    });
  }

  final _$_MusicalPreferencesControllerBaseActionController =
      ActionController(name: '_MusicalPreferencesControllerBase');

  @override
  void load() {
    final _$actionInfo = _$_MusicalPreferencesControllerBaseActionController
        .startAction(name: '_MusicalPreferencesControllerBase.load');
    try {
      return super.load();
    } finally {
      _$_MusicalPreferencesControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
