import 'dart:convert';

import 'package:number_game/errors/error_response.dart';



class ErrorResponseModel extends ErrorResponse {
  const ErrorResponseModel({
    required this.code,
    required this.status,
    required this.message,
    required this.response,
    this.timestamp,
  }) : super(code: code, status: status, message: message, response: response);

  factory ErrorResponseModel.fromRawJson(String str) =>
      ErrorResponseModel.fromJson(json.decode(str));

  factory ErrorResponseModel.fromJson(dynamic json) {
    try {
      if (json is Map<String, dynamic>) {
        // Handle string type explicitly for each field
        final code = json['code'] as int;
        final status = json['status']?.toString() ?? 'ERROR';
        final message = json['message']?.toString() ?? 'Unknown error';
        final response = json['response']?.toString() ?? message;
        final timestamp = json['timestamp']?.toString();

        return ErrorResponseModel(
          code: code,
          status: status,
          message: message,
          response: response,
          timestamp: timestamp,
        );
      } else if (json is String) {
        return ErrorResponseModel(
          code: 400,
          status: 'ERROR',
          message: json,
          response: json,
        );
      } else {
        return const ErrorResponseModel(
          code: 400,
          status: 'ERROR',
          message: 'Unknown error',
          response: 'An unexpected error occurred',
        );
      }
    } catch (e) {
      return ErrorResponseModel(
        code: 400,
        status: 'ERROR',
        message: 'Error parsing response',
        response: json.toString(),
      );
    }
  }

  @override
  final int code;
  @override
  final String status;
  @override
  final String message;
  @override
  final String response;
  final String? timestamp;

  Map<String, dynamic> toJson() => {
        'code': code,
        'status': status,
        'message': message,
        'response': response,
        if (timestamp != null) 'timestamp': timestamp,
      };
}
