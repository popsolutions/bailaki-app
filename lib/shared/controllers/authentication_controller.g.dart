// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthenticationController on _AuthenticationControllerBase, Store {
  Computed<UserProfile> _$currentUserComputed;

  @override
  UserProfile get currentUser =>
      (_$currentUserComputed ??= Computed<UserProfile>(() => super.currentUser,
              name: '_AuthenticationControllerBase.currentUser'))
          .value;

  final _$_currentUserAtom =
      Atom(name: '_AuthenticationControllerBase._currentUser');

  @override
  ObservableFuture<UserProfile> get _currentUser {
    _$_currentUserAtom.reportRead();
    return super._currentUser;
  }

  @override
  set _currentUser(ObservableFuture<UserProfile> value) {
    _$_currentUserAtom.reportWrite(value, super._currentUser, () {
      super._currentUser = value;
    });
  }

  final _$initialAuthenticationAsyncAction =
      AsyncAction('_AuthenticationControllerBase.initialAuthentication');

  @override
  Future<UserProfile> initialAuthentication() {
    return _$initialAuthenticationAsyncAction
        .run(() => super.initialAuthentication());
  }

  final _$_AuthenticationControllerBaseActionController =
      ActionController(name: '_AuthenticationControllerBase');

  @override
  void authenticate(UserProfile user) {
    final _$actionInfo = _$_AuthenticationControllerBaseActionController
        .startAction(name: '_AuthenticationControllerBase.authenticate');
    try {
      return super.authenticate(user);
    } finally {
      _$_AuthenticationControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void logout() {
    final _$actionInfo = _$_AuthenticationControllerBaseActionController
        .startAction(name: '_AuthenticationControllerBase.logout');
    try {
      return super.logout();
    } finally {
      _$_AuthenticationControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentUser: ${currentUser}
    ''';
  }
}
