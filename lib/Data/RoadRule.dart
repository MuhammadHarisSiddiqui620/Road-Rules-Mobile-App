import 'SubHeader.dart';

class RoadRule {
  final int id;
  final String header;
  final List<SubHeader> subHeaders;

  RoadRule({required this.id, required this.header, required this.subHeaders});

  factory RoadRule.fromJson(Map<String, dynamic> json) {
    var list = json['sub_headers'] as List;
    List<SubHeader> subHeaderList =
        list.map((i) => SubHeader.fromJson(i)).toList();

    return RoadRule(
      id: json['id'],
      header: json['header'],
      subHeaders: subHeaderList,
    );
  }
}
