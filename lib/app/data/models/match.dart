class Match {
  final int id;
  final int leftPartnerId;
  final int rightPartnerId;

  Match({this.id, this.leftPartnerId, this.rightPartnerId});

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
        id: json['id'],
        leftPartnerId: json['left_partner_id'][0],
        rightPartnerId: json['right_partner_id'][0]);
  }
}