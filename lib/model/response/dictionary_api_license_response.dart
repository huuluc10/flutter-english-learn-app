// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class License {
  String name;
  String url;

  License({
    required this.name,
    required this.url,
  });

  factory License.fromMap(Map<String, dynamic> map) {
    return License(
      name: map['name'] as String,
      url: map['url'] as String,
    );
  }

  factory License.fromJson(String source) =>
      License.fromMap(json.decode(source) as Map<String, dynamic>);
}
