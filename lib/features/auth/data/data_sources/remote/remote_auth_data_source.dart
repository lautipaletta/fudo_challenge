import 'package:fudo_challenge/core/exceptions/network_exceptions.dart';
import 'package:fudo_challenge/features/auth/data/data_sources/auth_data_source.dart';
import 'package:fudo_challenge/features/auth/data/model/auth_request_dto.dart';

class RemoteAuthDataSource implements AuthDataSource {
  @override
  Future<void> login(AuthRequestDto authRequestDto) async {
    await Future.delayed(const Duration(seconds: 2)); // Delay artificial
    if (authRequestDto.email != 'challenge@fudo' ||
        authRequestDto.password != 'password') {
      throw BadRequestException(message: 'Invalid email or password');
    }
  }
}
