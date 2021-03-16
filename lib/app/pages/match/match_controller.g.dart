// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MatchController on _MatchControllerBase, Store {
  final _$_matchesRequestAtom =
      Atom(name: '_MatchControllerBase._matchesRequest');

  @override
  ObservableFuture<List<Channel>> get _matchesRequest {
    _$_matchesRequestAtom.reportRead();
    return super._matchesRequest;
  }

  @override
  set _matchesRequest(ObservableFuture<List<Channel>> value) {
    _$_matchesRequestAtom.reportWrite(value, super._matchesRequest, () {
      super._matchesRequest = value;
    });
  }

  final _$_MatchControllerBaseActionController =
      ActionController(name: '_MatchControllerBase');

  @override
  void load() {
    final _$actionInfo = _$_MatchControllerBaseActionController.startAction(
        name: '_MatchControllerBase.load');
    try {
      return super.load();
    } finally {
      _$_MatchControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
