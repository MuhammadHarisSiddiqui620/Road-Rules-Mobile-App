class SubHeader {
  final double id;
  final String title;
  final String? description;
  final String? picture;

  SubHeader(
      {required this.id, required this.title, this.description, this.picture});

  factory SubHeader.fromJson(Map<String, dynamic> json) {
    return SubHeader(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      picture: json['picture'],
    );
  }
}
