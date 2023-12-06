// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BookModel {
  final int id;
  final String title;
  final String author;
  final String coverUrl;
  final String downloadUrl;

  BookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.downloadUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'author': author,
      'coverUrl': coverUrl,
      'downloadUrl': downloadUrl,
    };
  }

  factory BookModel.fromMap(Map<String, dynamic> map) {
    return BookModel(
      id: map['id'] as int,
      title: map['title'] as String,
      author: map['author'] as String,
      coverUrl: map['coverUrl'] as String,
      downloadUrl: map['downloadUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookModel.fromJson(String source) => BookModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
