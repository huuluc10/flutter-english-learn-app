import 'dart:convert';

class ResponseModel<T> {
  String status;
  String message;
  T data;

  ResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ResponseModel.fromMap(
    Map<String, dynamic> map,
    T Function(Object? json) fromJsonT,
  ) {
    return ResponseModel(
      status: map['status'] as String,
      message: map['message'] as String,
      data: fromJsonT(map['data']),
    );
  }

  factory ResponseModel.fromJson(
    String source,
    T Function(Object? json) fromJsonT,
  ) =>
      ResponseModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
        fromJsonT,
      );
}


//final response = ResponseModel.fromJson<User>(jsonString, (json) => User.fromJson(json as Map<String, dynamic>));