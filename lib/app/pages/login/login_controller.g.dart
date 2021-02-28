// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginController on _LoginControllerBase, Store {
  Computed<bool> _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: '_LoginControllerBase.isLoading'))
          .value;

  final _$_emailAtom = Atom(name: '_LoginControllerBase._email');

  @override
  String get _email {
    _$_emailAtom.reportRead();
    return super._email;
  }

  @override
  set _email(String value) {
    _$_emailAtom.reportWrite(value, super._email, () {
      super._email = value;
    });
  }

  final _$_passwordAtom = Atom(name: '_LoginControllerBase._password');

  @override
  String get _password {
    _$_passwordAtom.reportRead();
    return super._password;
  }

  @override
  set _password(String value) {
    _$_passwordAtom.reportWrite(value, super._password, () {
      super._password = value;
    });
  }

  final _$_loginRequestAtom = Atom(name: '_LoginControllerBase._loginRequest');

  @override
  ObservableFuture<LoginResult> get _loginRequest {
    _$_loginRequestAtom.reportRead();
    return super._loginRequest;
  }

  @override
  set _loginRequest(ObservableFuture<LoginResult> value) {
    _$_loginRequestAtom.reportWrite(value, super._loginRequest, () {
      super._loginRequest = value;
    });
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading}
    ''';
  }
}
