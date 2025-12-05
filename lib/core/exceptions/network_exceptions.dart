import 'package:fudo_challenge/core/exceptions/fudo_exception.dart';

class NetworkException extends FudoException {
  NetworkException({required super.message});
}

class BadRequestException extends NetworkException {
  BadRequestException({required super.message});
}

class UnauthorizedException extends NetworkException {
  UnauthorizedException({required super.message});
}

class ForbiddenException extends NetworkException {
  ForbiddenException({required super.message});
}
