import 'package:fudo_challenge/features/auth/data/model/auth_request_dto.dart';
import 'package:fudo_challenge/features/auth/data/model/auth_user_dto.dart';

abstract class AuthDataSource {
  Future<AuthUserDto> login(AuthRequestDto authRequestDto);
}
