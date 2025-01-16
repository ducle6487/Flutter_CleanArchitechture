import 'package:Flutter_CleanArchitechture/app/domain/auth/model/sign_in_response_dto.dart';

abstract interface class RefreshTokenUsecase {
  Future<SignInResponseDTO?> execute();
}
