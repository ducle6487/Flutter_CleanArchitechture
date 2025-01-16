import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_clean_architechture/app/domain/auth/usecase/sign_out/sign_out_usecase.dart';
import 'package:flutter_clean_architechture/app/domain/user/model/user_profile_response_dto.dart';
import 'package:flutter_clean_architechture/app/domain/user/usecase/get_my_profile/get_my_profile_usecase.dart';
import 'package:flutter_clean_architechture/core/animation/constants/animation_constants.dart';
import 'package:flutter_clean_architechture/core/authorization/service/authorization_service.dart';
import 'package:flutter_clean_architechture/core/loading/provider/loading_provider.dart';

class SettingsViewState {
  final bool isSignOutError;
  final bool isLoading;
  final UserProfileResponseDTO? userProfileResponseDTO;

  const SettingsViewState({
    required this.isSignOutError,
    required this.isLoading,
    required this.userProfileResponseDTO,
  });

  /// Creates a copy of this class.
  SettingsViewState copyWith({
    bool? isSignOutError,
    bool? isLoading,
    UserProfileResponseDTO? userProfileResponseDTO,
  }) {
    return SettingsViewState(
      isSignOutError: isSignOutError ?? this.isSignOutError,
      isLoading: isLoading ?? this.isLoading,
      userProfileResponseDTO:
          userProfileResponseDTO ?? this.userProfileResponseDTO,
    );
  }
}

class SettingsViewController extends StateNotifier<SettingsViewState> {
  final SignOutUsecase _signOutUsecase;
  final GetMyProfileUsecase _getMyProfileUsecase;
  SettingsViewController({
    required SignOutUsecase signOutUsecase,
    required GetMyProfileUsecase getMyProfileUsecase,
  })  : _signOutUsecase = signOutUsecase,
        _getMyProfileUsecase = getMyProfileUsecase,
        super(
          const SettingsViewState(
            isSignOutError: false,
            isLoading: true,
            userProfileResponseDTO: null,
          ),
        ) {
    getMyProfile();
  }

  /// Setter for [userProfileResponseDTO].
  set userProfileResponseDTO(UserProfileResponseDTO? userProfileResponseDTO) =>
      state = state.copyWith(userProfileResponseDTO: userProfileResponseDTO);

  Future<void> getMyProfile() async {
    state = state.copyWith(isLoading: true);
    try {
      UserProfileResponseDTO? response = await _getMyProfileUsecase.execute();
      Future.delayed(
        const Duration(
          milliseconds: AnimationConstants.loadingAnimationExtraDelayDurationMS,
        ),
        () {
          state = state.copyWith(
            userProfileResponseDTO: response,
            isLoading: false,
          );
        },
      );
    } catch (err) {
      Future.delayed(
        const Duration(
          milliseconds: AnimationConstants.loadingAnimationExtraDelayDurationMS,
        ),
        () {
          state = state.copyWith(isLoading: false);
        },
      );
    }
  }

  Future<void> signOut(WidgetRef ref) async {
    state = state.copyWith(isSignOutError: false);
    final loadingController =
        ref.read(LoadingProvider.loadingControllerProvider.notifier);
    loadingController.isLoading = true;
    try {
      await _signOutUsecase.execute();
      Future.delayed(
        const Duration(
          milliseconds: AnimationConstants.loadingAnimationExtraDelayDurationMS,
        ),
        () {
          AuthorizationService.instance.clearToken();
          loadingController.isLoading = false;
        },
      );
    } catch (error) {
      Future.delayed(
        const Duration(
          milliseconds: AnimationConstants.loadingAnimationExtraDelayDurationMS,
        ),
        () {
          state = state.copyWith(isSignOutError: true);
          loadingController.isLoading = false;
        },
      );
    }
  }
}
