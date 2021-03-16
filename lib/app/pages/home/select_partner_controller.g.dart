// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'select_partner_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SelectPartnerController on _SelectPartnerControllerBase, Store {
  final _$_partnersAtom = Atom(name: '_SelectPartnerControllerBase._partners');

  @override
  ObservableFuture<List<Partner>> get _partners {
    _$_partnersAtom.reportRead();
    return super._partners;
  }

  @override
  set _partners(ObservableFuture<List<Partner>> value) {
    _$_partnersAtom.reportWrite(value, super._partners, () {
      super._partners = value;
    });
  }

  final _$_SelectPartnerControllerBaseActionController =
      ActionController(name: '_SelectPartnerControllerBase');

  @override
  void loadPartners() {
    final _$actionInfo = _$_SelectPartnerControllerBaseActionController
        .startAction(name: '_SelectPartnerControllerBase.loadPartners');
    try {
      return super.loadPartners();
    } finally {
      _$_SelectPartnerControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void like() {
    final _$actionInfo = _$_SelectPartnerControllerBaseActionController
        .startAction(name: '_SelectPartnerControllerBase.like');
    try {
      return super.like();
    } finally {
      _$_SelectPartnerControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deslike() {
    final _$actionInfo = _$_SelectPartnerControllerBaseActionController
        .startAction(name: '_SelectPartnerControllerBase.deslike');
    try {
      return super.deslike();
    } finally {
      _$_SelectPartnerControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void update(List<Partner> items) {
    final _$actionInfo = _$_SelectPartnerControllerBaseActionController
        .startAction(name: '_SelectPartnerControllerBase.update');
    try {
      return super.update(items);
    } finally {
      _$_SelectPartnerControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
