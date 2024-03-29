import 'dart:convert';

class ResponseModel {
  String status;
  String message;
  Map<String, dynamic> data;

  ResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ResponseModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return ResponseModel(
      status: map['status'] as String,
      message: map['message'] as String,
      data: (map['data']),
    );
  }

  factory ResponseModel.fromJson(
    String source,
  ) =>
      ResponseModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}


//final response = ResponseModel.fromJson<User>(jsonString, (json) => User.fromJson(json as Map<String, dynamic>));