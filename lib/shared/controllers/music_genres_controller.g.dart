// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_genres_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MusicGenresController on _MusicGenresControllerBase, Store {
  final _$_musicGenresAtom =
      Atom(name: '_MusicGenresControllerBase._musicGenres');

  @override
  ObservableList<MusicGenre> get _musicGenres {
    _$_musicGenresAtom.reportRead();
    return super._musicGenres;
  }

  @override
  set _musicGenres(ObservableList<MusicGenre> value) {
    _$_musicGenresAtom.reportWrite(value, super._musicGenres, () {
      super._musicGenres = value;
    });
  }

  final _$_selectedMusicGenresAtom =
      Atom(name: '_MusicGenresControllerBase._selectedMusicGenres');

  @override
  ObservableSet<MusicGenre> get _selectedMusicGenres {
    _$_selectedMusicGenresAtom.reportRead();
    return super._selectedMusicGenres;
  }

  @override
  set _selectedMusicGenres(ObservableSet<MusicGenre> value) {
    _$_selectedMusicGenresAtom.reportWrite(value, super._selectedMusicGenres,
        () {
      super._selectedMusicGenres = value;
    });
  }

  final _$_MusicGenresControllerBaseActionController =
      ActionController(name: '_MusicGenresControllerBase');

  @override
  bool addSelected(MusicGenre item) {
    final _$actionInfo = _$_MusicGenresControllerBaseActionController
        .startAction(name: '_MusicGenresControllerBase.addSelected');
    try {
      return super.addSelected(item);
    } finally {
      _$_MusicGenresControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool removeSelected(MusicGenre item) {
    final _$actionInfo = _$_MusicGenresControllerBaseActionController
        .startAction(name: '_MusicGenresControllerBase.removeSelected');
    try {
      return super.removeSelected(item);
    } finally {
      _$_MusicGenresControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void init(List<MusicGenre> items, List<int> selectedItems) {
    final _$actionInfo = _$_MusicGenresControllerBaseActionController
        .startAction(name: '_MusicGenresControllerBase.init');
    try {
      return super.init(items, selectedItems);
    } finally {
      _$_MusicGenresControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
