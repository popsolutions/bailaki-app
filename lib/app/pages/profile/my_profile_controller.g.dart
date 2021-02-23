// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_profile_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MyProfileController on _MyProfileControllerBase, Store {
  final _$_profileAtom = Atom(name: '_MyProfileControllerBase._profile');

  @override
  ObservableFuture<UserProfileDto> get _profile {
    _$_profileAtom.reportRead();
    return super._profile;
  }

  @override
  set _profile(ObservableFuture<UserProfileDto> value) {
    _$_profileAtom.reportWrite(value, super._profile, () {
      super._profile = value;
    });
  }

  final _$_MyProfileControllerBaseActionController =
      ActionController(name: '_MyProfileControllerBase');

  @override
  void loadProfile(int userId, int userPartnerId) {
    final _$actionInfo = _$_MyProfileControllerBaseActionController.startAction(
        name: '_MyProfileControllerBase.loadProfile');
    try {
      return super.loadProfile(userId, userPartnerId);
    } finally {
      _$_MyProfileControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
