class SubHeader {
  final double id;
  final String title;
  final String description;

  SubHeader({required this.id, required this.title, required this.description});

  factory SubHeader.fromJson(Map<String, dynamic> json) {
    return SubHeader(
      id: json['id'],
      title: json['title'],
      description: json['description'],
    );
  }
}
