
import 'package:equatable/equatable.dart';
import 'package:number_game/errors/common_error_response.dart';


abstract class Failure extends Equatable {
  const Failure();
  String get message;

  @override
  List<Object> get props => [message];
}

// General failures
class ServerFailure extends Failure {
  const ServerFailure(this.errorResponse);
  final ErrorResponseModel errorResponse;

  @override
  String get message => errorResponse.response;
}

//hive fialure
class HIveFailure extends Failure {
  const HIveFailure(this.errorResponse);
  final ErrorResponseModel errorResponse;

  @override
  String get message => errorResponse.response;
}


//class Save User Data failure
class SaveUserDataFailure extends Failure {
  const SaveUserDataFailure(this.errorResponse);
  final ErrorResponseModel errorResponse;

  @override
  String get message => errorResponse.response;
}

class CacheFailure extends Failure {
  @override
  String get message => 'Cache Failure';
}

class ConnectionFailure extends Failure {
  @override
  String get message => 'No Internet Connection';
}

class AuthorizedFailure extends Failure {
  const AuthorizedFailure(this.errorResponse);
  final ErrorResponseModel errorResponse;

  @override
  String get message => errorResponse.response;
}

// BadRequestFailure
class BadRequestFailure extends Failure {
  const BadRequestFailure(this.errorResponse);

  final ErrorResponseModel errorResponse;

  @override
  String get message => errorResponse.response;
}

// auth failure
class AuthFailure extends Failure {
  const AuthFailure(this.errorResponse);
  final ErrorResponseModel errorResponse;

  @override
  String get message => errorResponse.response;
}

// Location Permission
class LocationPermissionFailure extends Failure {
  const LocationPermissionFailure(this.errorResponse);
  final ErrorResponseModel errorResponse;

  @override
  String get message => errorResponse.response;
}

// Background Location Permission
class BackgroundLocationPermissionFailure extends Failure {
  const BackgroundLocationPermissionFailure(this.errorResponse);
  final ErrorResponseModel errorResponse;

  @override
  String get message => errorResponse.response;
}
