// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preferences_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PreferencesController on _PreferencesControllerBase, Store {
  final _$maxDistanceAtom =
      Atom(name: '_PreferencesControllerBase.maxDistance');

  @override
  int get maxDistance {
    _$maxDistanceAtom.reportRead();
    return super.maxDistance;
  }

  @override
  set maxDistance(int value) {
    _$maxDistanceAtom.reportWrite(value, super.maxDistance, () {
      super.maxDistance = value;
    });
  }

  final _$ageRangeAtom = Atom(name: '_PreferencesControllerBase.ageRange');

  @override
  RangeValues get ageRange {
    _$ageRangeAtom.reportRead();
    return super.ageRange;
  }

  @override
  set ageRange(RangeValues value) {
    _$ageRangeAtom.reportWrite(value, super.ageRange, () {
      super.ageRange = value;
    });
  }

  final _$interestingInMalesAtom =
      Atom(name: '_PreferencesControllerBase.interestingInMales');

  @override
  bool get interestingInMales {
    _$interestingInMalesAtom.reportRead();
    return super.interestingInMales;
  }

  @override
  set interestingInMales(bool value) {
    _$interestingInMalesAtom.reportWrite(value, super.interestingInMales, () {
      super.interestingInMales = value;
    });
  }

  final _$interestingInFemalesAtom =
      Atom(name: '_PreferencesControllerBase.interestingInFemales');

  @override
  bool get interestingInFemales {
    _$interestingInFemalesAtom.reportRead();
    return super.interestingInFemales;
  }

  @override
  set interestingInFemales(bool value) {
    _$interestingInFemalesAtom.reportWrite(value, super.interestingInFemales,
        () {
      super.interestingInFemales = value;
    });
  }

  final _$interestingInOthersAtom =
      Atom(name: '_PreferencesControllerBase.interestingInOthers');

  @override
  bool get interestingInOthers {
    _$interestingInOthersAtom.reportRead();
    return super.interestingInOthers;
  }

  @override
  set interestingInOthers(bool value) {
    _$interestingInOthersAtom.reportWrite(value, super.interestingInOthers, () {
      super.interestingInOthers = value;
    });
  }

  final _$receiveNewMatchesNotificationsAtom =
      Atom(name: '_PreferencesControllerBase.receiveNewMatchesNotifications');

  @override
  bool get receiveNewMatchesNotifications {
    _$receiveNewMatchesNotificationsAtom.reportRead();
    return super.receiveNewMatchesNotifications;
  }

  @override
  set receiveNewMatchesNotifications(bool value) {
    _$receiveNewMatchesNotificationsAtom
        .reportWrite(value, super.receiveNewMatchesNotifications, () {
      super.receiveNewMatchesNotifications = value;
    });
  }

  final _$receiveChatNotificationsAtom =
      Atom(name: '_PreferencesControllerBase.receiveChatNotifications');

  @override
  bool get receiveChatNotifications {
    _$receiveChatNotificationsAtom.reportRead();
    return super.receiveChatNotifications;
  }

  @override
  set receiveChatNotifications(bool value) {
    _$receiveChatNotificationsAtom
        .reportWrite(value, super.receiveChatNotifications, () {
      super.receiveChatNotifications = value;
    });
  }

  final _$_updateRequestAtom =
      Atom(name: '_PreferencesControllerBase._updateRequest');

  @override
  ObservableFuture<dynamic> get _updateRequest {
    _$_updateRequestAtom.reportRead();
    return super._updateRequest;
  }

  @override
  set _updateRequest(ObservableFuture<dynamic> value) {
    _$_updateRequestAtom.reportWrite(value, super._updateRequest, () {
      super._updateRequest = value;
    });
  }

  final _$_PreferencesControllerBaseActionController =
      ActionController(name: '_PreferencesControllerBase');

  @override
  void submit() {
    final _$actionInfo = _$_PreferencesControllerBaseActionController
        .startAction(name: '_PreferencesControllerBase.submit');
    try {
      return super.submit();
    } finally {
      _$_PreferencesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
maxDistance: ${maxDistance},
ageRange: ${ageRange},
interestingInMales: ${interestingInMales},
interestingInFemales: ${interestingInFemales},
interestingInOthers: ${interestingInOthers},
receiveNewMatchesNotifications: ${receiveNewMatchesNotifications},
receiveChatNotifications: ${receiveChatNotifications}
    ''';
  }
}
