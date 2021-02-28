class MemoryImage {
  final int id;
  final List<int> image;

  MemoryImage({this.id, this.image});

  factory MemoryImage.fromJson(Map<String, dynamic> json) {
    return MemoryImage(
        id: json["id"], image: json["image"] is! bool ? json["image"] : null);
  }
}
