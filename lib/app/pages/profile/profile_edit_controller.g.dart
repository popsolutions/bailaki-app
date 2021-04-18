// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_edit_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProfileEditController on _ProfileEditControllerBase, Store {
  final _$_imagesAtom = Atom(name: '_ProfileEditControllerBase._images');

  @override
  ObservableList<Photo> get _images {
    _$_imagesAtom.reportRead();
    return super._images;
  }

  @override
  set _images(ObservableList<Photo> value) {
    _$_imagesAtom.reportWrite(value, super._images, () {
      super._images = value;
    });
  }

  final _$_updateProfileRequestAtom =
      Atom(name: '_ProfileEditControllerBase._updateProfileRequest');

  @override
  ObservableFuture<dynamic> get _updateProfileRequest {
    _$_updateProfileRequestAtom.reportRead();
    return super._updateProfileRequest;
  }

  @override
  set _updateProfileRequest(ObservableFuture<dynamic> value) {
    _$_updateProfileRequestAtom.reportWrite(value, super._updateProfileRequest,
        () {
      super._updateProfileRequest = value;
    });
  }

  final _$_genderAtom = Atom(name: '_ProfileEditControllerBase._gender');

  @override
  String get _gender {
    _$_genderAtom.reportRead();
    return super._gender;
  }

  @override
  set _gender(String value) {
    _$_genderAtom.reportWrite(value, super._gender, () {
      super._gender = value;
    });
  }

  final _$_birthdateAtom = Atom(name: '_ProfileEditControllerBase._birthdate');

  @override
  DateTime get _birthdate {
    _$_birthdateAtom.reportRead();
    return super._birthdate;
  }

  @override
  set _birthdate(DateTime value) {
    _$_birthdateAtom.reportWrite(value, super._birthdate, () {
      super._birthdate = value;
    });
  }

  final _$_ProfileEditControllerBaseActionController =
      ActionController(name: '_ProfileEditControllerBase');

  @override
  void submit() {
    final _$actionInfo = _$_ProfileEditControllerBaseActionController
        .startAction(name: '_ProfileEditControllerBase.submit');
    try {
      return super.submit();
    } finally {
      _$_ProfileEditControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
