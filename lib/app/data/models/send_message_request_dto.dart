class SendMessageRequestDto {
  final int currentPartnerId;
  final int channelId;
  final String message;

  SendMessageRequestDto({this.currentPartnerId, this.channelId, this.message});
}
