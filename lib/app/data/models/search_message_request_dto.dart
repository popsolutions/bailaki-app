class SearchMessageRequestDto{
  final int channelId;
  int lastIdReceived = 0;
  int author_idNot = 0;

  SearchMessageRequestDto({this.channelId, this.lastIdReceived = 0, this.author_idNot});
}