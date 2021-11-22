// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  final _$_currentLocationAtom =
      Atom(name: '_HomeControllerBase._currentLocation');

  @override
  ObservableStream<LocationData> get _currentLocation {
    _$_currentLocationAtom.reportRead();
    return super._currentLocation;
  }

  @override
  set _currentLocation(ObservableStream<LocationData> value) {
    _$_currentLocationAtom.reportWrite(value, super._currentLocation, () {
      super._currentLocation = value;
    });
  }

  final _$_currentIndexAtom = Atom(name: '_HomeControllerBase._currentIndex');

  @override
  int get _currentIndex {
    _$_currentIndexAtom.reportRead();
    return super._currentIndex;
  }

  @override
  set _currentIndex(int value) {
    _$_currentIndexAtom.reportWrite(value, super._currentIndex, () {
      super._currentIndex = value;
    });
  }

  final _$_HomeControllerBaseActionController =
      ActionController(name: '_HomeControllerBase');

  @override
  void loadLocation() {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.loadLocation');
    try {
      return super.loadLocation();
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateLocation(LocationData locationData, int partnerId) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.updateLocation');
    try {
      return super.updateLocation(locationData, partnerId);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
