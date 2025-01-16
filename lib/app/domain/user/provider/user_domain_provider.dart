import 'package:Flutter_CleanArchitechture/app/data/user/provider/user_data_provider.dart';
import 'package:Flutter_CleanArchitechture/app/domain/user/usecase/change_password/change_password_usecase.dart';
import 'package:Flutter_CleanArchitechture/app/domain/user/usecase/change_password/change_password_usecase_impl.dart';
import 'package:Flutter_CleanArchitechture/app/domain/user/usecase/delete_account/delete_account_usecase.dart.dart';
import 'package:Flutter_CleanArchitechture/app/domain/user/usecase/delete_account/delete_account_usecase_impl.dart';
import 'package:Flutter_CleanArchitechture/app/domain/user/usecase/get_my_profile/get_my_profile_usecase.dart';
import 'package:Flutter_CleanArchitechture/app/domain/user/usecase/get_my_profile/get_my_profile_usecase_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../usecase/update_my_profile/update_my_profile_usecase.dart';
import '../usecase/update_my_profile/update_my_profile_usecase_impl.dart';

class UserDomainProvider {
  const UserDomainProvider._();

  /// Provider for [GetMyProfileUsecase].
  static final getMyProfileUsecaseProvider = Provider<GetMyProfileUsecase>(
    (ref) {
      return GetMyProfileUsecaseImpl(
        userRepository: ref.watch(
          UserDataProvider.userRepositoryProvider,
        ),
      );
    },
  );

  /// Provider for [UpdateMyProfileUsecase].
  static final updateMyProfileUsecaseProvider =
      Provider<UpdateMyProfileUsecase>(
    (ref) {
      return UpdateMyProfileUsecaseImpl(
        userRepository: ref.watch(
          UserDataProvider.userRepositoryProvider,
        ),
      );
    },
  );

  /// Provider for [ChangePasswordUsecase].
  static final changePasswordUsecaseProvider = Provider<ChangePasswordUsecase>(
    (ref) {
      return ChangePasswordUsecaseImpl(
        userRepository: ref.watch(
          UserDataProvider.userRepositoryProvider,
        ),
      );
    },
  );

  /// Provider for [DeleteAccountUsecase].
  static final deleteAccountUsecaseProvider = Provider<DeleteAccountUsecase>(
    (ref) {
      return DeleteAccountUsecaseImpl(
        userRepository: ref.watch(
          UserDataProvider.userRepositoryProvider,
        ),
      );
    },
  );
}
