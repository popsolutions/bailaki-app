// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChatController on _ChatControllerBase, Store {
  Computed<bool> _$isEmptyMessageComputed;

  @override
  bool get isEmptyMessage =>
      (_$isEmptyMessageComputed ??= Computed<bool>(() => super.isEmptyMessage,
              name: '_ChatControllerBase.isEmptyMessage'))
          .value;

  final _$_messageAtom = Atom(name: '_ChatControllerBase._message');

  @override
  String get _message {
    _$_messageAtom.reportRead();
    return super._message;
  }

  @override
  set _message(String value) {
    _$_messageAtom.reportWrite(value, super._message, () {
      super._message = value;
    });
  }

  final _$_sendMessageRequestAtom =
      Atom(name: '_ChatControllerBase._sendMessageRequest');

  @override
  ObservableFuture<dynamic> get _sendMessageRequest {
    _$_sendMessageRequestAtom.reportRead();
    return super._sendMessageRequest;
  }

  @override
  set _sendMessageRequest(ObservableFuture<dynamic> value) {
    _$_sendMessageRequestAtom.reportWrite(value, super._sendMessageRequest, () {
      super._sendMessageRequest = value;
    });
  }

  final _$_messagesRequestAtom =
      Atom(name: '_ChatControllerBase._messagesRequest');

  @override
  ObservableFuture<List<DayMessage>> get _messagesRequest {
    _$_messagesRequestAtom.reportRead();
    return super._messagesRequest;
  }

  @override
  set _messagesRequest(ObservableFuture<List<DayMessage>> value) {
    _$_messagesRequestAtom.reportWrite(value, super._messagesRequest, () {
      super._messagesRequest = value;
    });
  }

  final _$_ChatControllerBaseActionController =
      ActionController(name: '_ChatControllerBase');

  @override
  void load() {
    final _$actionInfo = _$_ChatControllerBaseActionController.startAction(
        name: '_ChatControllerBase.load');
    try {
      return super.load();
    } finally {
      _$_ChatControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addMessage(Message message) {
    final _$actionInfo = _$_ChatControllerBaseActionController.startAction(
        name: '_ChatControllerBase.addMessage');
    try {
      return super.addMessage(message);
    } finally {
      _$_ChatControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void send() {
    final _$actionInfo = _$_ChatControllerBaseActionController.startAction(
        name: '_ChatControllerBase.send');
    try {
      return super.send();
    } finally {
      _$_ChatControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isEmptyMessage: ${isEmptyMessage}
    ''';
  }
}
