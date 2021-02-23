// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partner_detail_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PartnerDetailController on _PartnerDetailControllerBase, Store {
  final _$_partnerAtom = Atom(name: '_PartnerDetailControllerBase._partner');

  @override
  ObservableFuture<PartnerDetail> get _partner {
    _$_partnerAtom.reportRead();
    return super._partner;
  }

  @override
  set _partner(ObservableFuture<PartnerDetail> value) {
    _$_partnerAtom.reportWrite(value, super._partner, () {
      super._partner = value;
    });
  }

  final _$_PartnerDetailControllerBaseActionController =
      ActionController(name: '_PartnerDetailControllerBase');

  @override
  void loadPartner(int id) {
    final _$actionInfo = _$_PartnerDetailControllerBaseActionController
        .startAction(name: '_PartnerDetailControllerBase.loadPartner');
    try {
      return super.loadPartner(id);
    } finally {
      _$_PartnerDetailControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
