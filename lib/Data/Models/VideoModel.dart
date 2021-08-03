import 'dart:convert';

Video videoFromJson(String str) => Video.fromJson(json.decode(str));

String videoToJson(Video data) => json.encode(data.toJson());

class Video {

  Video({
    required this.description,
    required this.sources,
    required this.thumb,
    required this.title,
  });

  String description;
  List<String> sources;
  String thumb;
  String title;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    description: json["description"],
    sources: List<String>.from(json["sources"].map((x) => x)),
    thumb: json["thumb"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "description": description,
    "sources": List<dynamic>.from(sources.map((x) => x)),
    "thumb": thumb,
    "title": title,
  };
}
