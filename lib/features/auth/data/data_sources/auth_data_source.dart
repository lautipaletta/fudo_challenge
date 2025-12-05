import 'package:fudo_challenge/features/auth/data/model/auth_request_dto.dart';

abstract class AuthDataSource {
  Future<void> login(AuthRequestDto authRequestDto);
}
