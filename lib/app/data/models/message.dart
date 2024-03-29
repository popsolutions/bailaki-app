class Message {
  final int id;
  final int authorId;
  final String body;
  final DateTime date;
  final int channelId;
  bool fromServer = false;

  Message({this.id, this.authorId, this.body, this.date, this.channelId, this.fromServer = true});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        id: json['id'],
        authorId: json['author_id'][0],
        body: json['body']?.replaceAll('<p>', '')?.replaceAll('</p>', ''),
        date: json['date'] is! bool ? DateTime.parse(json['date']) : null,
        channelId: json['res_id'],
        fromServer: true);
  }
}
