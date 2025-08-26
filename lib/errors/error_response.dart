import 'package:equatable/equatable.dart';

class ErrorResponse extends Equatable {
  const ErrorResponse({
    required this.code,
    required this.status,
    required this.message,
    required this.response,
  });

  final int code;
  final String status;
  final String message;
  final String response;

  @override
  List<Object> get props => [code, message, status, response];
}
