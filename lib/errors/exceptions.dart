
import 'package:number_game/errors/common_error_response.dart';



class ServerException implements Exception {
  ServerException(this.errorResponseModel);
  final ErrorResponseModel errorResponseModel;
}

//class Save User Data Exception
class SaveUserDataException implements Exception {
  SaveUserDataException(this.errorResponseModel);
  final ErrorResponseModel errorResponseModel;
}

// auth exception
class AuthException implements Exception {
  AuthException(this.errorResponseModel);
  final ErrorResponseModel errorResponseModel;
}

class CacheException implements Exception {}

class UnAuthorizedException implements Exception {
  UnAuthorizedException(this.errorResponseModel);
  final ErrorResponseModel errorResponseModel;
}

class ResponseModelException implements Exception {
  ResponseModelException({required this.errorResponseModel});
  final ErrorResponseModel errorResponseModel;
}

// BadRequestException to handle 400 errors
class BadRequestException implements Exception {
  BadRequestException(this.errorResponseModel);
  final ErrorResponseModel errorResponseModel;
}

// Location Permission Exception
class LocationPermissionException implements Exception {
  LocationPermissionException(this.errorResponseModel);
  final ErrorResponseModel errorResponseModel;
}

//Background Location Permission Exception
class BackgroundLocationPermissionException implements Exception {
  BackgroundLocationPermissionException(this.errorResponseModel);
  final ErrorResponseModel errorResponseModel;
}
class HiveException implements Exception {
  HiveException(this.errorResponseModel);
  final ErrorResponseModel errorResponseModel;
}