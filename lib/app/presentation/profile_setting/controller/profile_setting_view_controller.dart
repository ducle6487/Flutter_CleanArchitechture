import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Flutter_CleanArchitechture/app/data/gender/gender.dart';
import 'package:Flutter_CleanArchitechture/app/domain/user/model/user_profile_request_dto.dart';
import 'package:Flutter_CleanArchitechture/app/domain/user/model/user_profile_response_dto.dart';
import 'package:Flutter_CleanArchitechture/app/domain/user/usecase/delete_account/delete_account_usecase.dart.dart';
import 'package:Flutter_CleanArchitechture/app/domain/user/usecase/get_my_profile/get_my_profile_usecase.dart';
import 'package:Flutter_CleanArchitechture/config/app_strings.dart';
import 'package:Flutter_CleanArchitechture/core/animation/constants/animation_constants.dart';
import 'package:Flutter_CleanArchitechture/core/dialog/dialog_service.dart';
import 'package:Flutter_CleanArchitechture/core/error/model/server_failure.dart';
import 'package:Flutter_CleanArchitechture/core/localization/enum/text_type.dart';
import 'package:Flutter_CleanArchitechture/core/localization/service/localization_service.dart';
import 'package:Flutter_CleanArchitechture/core/widgets/model/advanced_dropdown_item_model.dart';
import '../../../../core/loading/provider/loading_provider.dart';
import '../../../domain/user/usecase/update_my_profile/update_my_profile_usecase.dart';

class ProfileSettingViewState {
  final TextEditingController emailTFController;
  final TextEditingController nameTFController;
  final TextEditingController phoneTFController;
  final TextEditingController addressTFController;
  final FocusNode nameFocusNode;
  final FocusNode addressFocusNode;
  final FocusNode phoneFocusNode;
  final AdvancedDropdownItemModel? selectedGender;
  final DateTime? selectedDayOfBirth;
  final String? avatarUrl;
  final String? nameErrorText;
  final String? emailErrorText;
  final String? phoneErrorText;
  final String? addressErrorText;
  final bool isLoading;
  final bool isImageLoading;
  final bool isSuccess;
  final bool isEditing;
  final UserProfileResponseDTO? userProfileResponseDTO;

  const ProfileSettingViewState({
    required this.emailTFController,
    required this.nameTFController,
    required this.phoneTFController,
    required this.addressTFController,
    required this.selectedGender,
    required this.selectedDayOfBirth,
    required this.avatarUrl,
    required this.nameErrorText,
    required this.phoneErrorText,
    required this.isLoading,
    required this.isImageLoading,
    required this.isSuccess,
    required this.userProfileResponseDTO,
    required this.addressErrorText,
    required this.emailErrorText,
    required this.addressFocusNode,
    required this.nameFocusNode,
    required this.phoneFocusNode,
    required this.isEditing,
  });

  /// Creates a copy of this class.
  ProfileSettingViewState copyWith({
    TextEditingController? emailTFController,
    TextEditingController? nameTFController,
    TextEditingController? phoneTFController,
    TextEditingController? addressTFController,
    TextEditingController? jobTFController,
    AdvancedDropdownItemModel? selectedGender,
    DateTime? selectedDayOfBirth,
    String? avatarUrl,
    String? nameErrorText,
    String? phoneErrorText,
    bool? isLoading,
    bool? isImageLoading,
    bool? isSuccess,
    UserProfileResponseDTO? userProfileResponseDTO,
    String? emailErrorText,
    String? addressErrorText,
    FocusNode? nameFocusNode,
    FocusNode? addressFocusNode,
    FocusNode? phoneFocusNode,
    bool? isEditing,
  }) {
    return ProfileSettingViewState(
      emailTFController: emailTFController ?? this.emailTFController,
      nameTFController: nameTFController ?? this.nameTFController,
      phoneTFController: phoneTFController ?? this.phoneTFController,
      addressTFController: addressTFController ?? this.addressTFController,
      selectedGender: selectedGender ?? this.selectedGender,
      selectedDayOfBirth: selectedDayOfBirth ?? this.selectedDayOfBirth,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      nameErrorText: nameErrorText ?? this.nameErrorText,
      phoneErrorText: phoneErrorText ?? this.phoneErrorText,
      isLoading: isLoading ?? this.isLoading,
      isImageLoading: isImageLoading ?? this.isImageLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      userProfileResponseDTO:
          userProfileResponseDTO ?? this.userProfileResponseDTO,
      emailErrorText: emailErrorText ?? this.emailErrorText,
      addressErrorText: addressErrorText ?? this.addressErrorText,
      nameFocusNode: nameFocusNode ?? this.nameFocusNode,
      addressFocusNode: addressFocusNode ?? this.addressFocusNode,
      phoneFocusNode: phoneFocusNode ?? this.phoneFocusNode,
      isEditing: isEditing ?? this.isEditing,
    );
  }
}

class ProfileSettingViewController
    extends StateNotifier<ProfileSettingViewState> {
  final GetMyProfileUsecase _getMyProfileUsecase;
  final UpdateMyProfileUsecase _updateMyProfileUsecase;
  final DeleteAccountUsecase _deleteAccountUsecase;

  ProfileSettingViewController({
    required GetMyProfileUsecase getMyProfileUsecase,
    required UpdateMyProfileUsecase updateMyProfileUsecase,
    required DeleteAccountUsecase deleteAccountUsecase,
  })  : _getMyProfileUsecase = getMyProfileUsecase,
        _updateMyProfileUsecase = updateMyProfileUsecase,
        _deleteAccountUsecase = deleteAccountUsecase,
        super(
          ProfileSettingViewState(
            emailTFController: TextEditingController(),
            nameTFController: TextEditingController(),
            phoneTFController: TextEditingController(),
            addressTFController: TextEditingController(),
            selectedGender: null,
            selectedDayOfBirth: null,
            avatarUrl: null,
            nameErrorText: null,
            isLoading: false,
            isImageLoading: false,
            isSuccess: false,
            userProfileResponseDTO: null,
            emailErrorText: null,
            addressErrorText: null,
            nameFocusNode: FocusNode(),
            addressFocusNode: FocusNode(),
            phoneFocusNode: FocusNode(),
            phoneErrorText: null,
            isEditing: false,
          ),
        ) {
    getMyProfile();
  }

  /// Setter for [emailTFController].
  set emailTFController(TextEditingController? emailTFController) =>
      state = state.copyWith(emailTFController: emailTFController);

  /// Setter for [nameTFController].
  set nameTFController(TextEditingController? nameTFController) =>
      state = state.copyWith(nameTFController: nameTFController);

  /// Setter for [phoneTFController].
  set phoneTFController(TextEditingController? phoneTFController) =>
      state = state.copyWith(phoneTFController: phoneTFController);

  /// Setter for [addressTFController].
  set addressTFController(TextEditingController? addressTFController) =>
      state = state.copyWith(addressTFController: addressTFController);

  /// Setter for [jobTFController].
  set jobTFController(TextEditingController? jobTFController) =>
      state = state.copyWith(jobTFController: jobTFController);

  /// Setter for [selectedGender].
  set selectedGender(AdvancedDropdownItemModel? selectedGender) =>
      state = state.copyWith(selectedGender: selectedGender);

  /// Setter for [selectedDayOfBirth].
  set selectedDayOfBirth(DateTime? selectedDayOfBirth) =>
      state = state.copyWith(selectedDayOfBirth: selectedDayOfBirth);

  /// Setter for [avatarUrl].
  set avatarUrl(String? avatarUrl) =>
      state = state.copyWith(avatarUrl: avatarUrl);

  /// Setter for [nameErrorText].
  set nameErrorText(String? nameErrorText) =>
      state = state.copyWith(nameErrorText: nameErrorText);

  /// Setter for [emailErrorText].
  set emailErrorText(String? emailErrorText) =>
      state = state.copyWith(emailErrorText: emailErrorText);

  /// Setter for [addressErrorText].
  set addressErrorText(String? addressErrorText) =>
      state = state.copyWith(addressErrorText: addressErrorText);

  /// Setter for [phoneErrorText].
  set phoneErrorText(String? phoneErrorText) =>
      state = state.copyWith(phoneErrorText: phoneErrorText);

  /// Setter for [isImageLoading].
  set isImageLoading(bool? isImageLoading) =>
      state = state.copyWith(isImageLoading: isImageLoading);

  /// Setter for [isSuccess].
  set isSuccess(bool? isSuccess) =>
      state = state.copyWith(isSuccess: isSuccess);

  set isEditing(bool isEditing) => state = state.copyWith(isEditing: isEditing);

  void resetState() => state = ProfileSettingViewState(
        emailTFController: TextEditingController(),
        nameTFController: TextEditingController(),
        phoneTFController: TextEditingController(),
        addressTFController: TextEditingController(),
        selectedGender: null,
        selectedDayOfBirth: null,
        avatarUrl: null,
        nameErrorText: null,
        isLoading: false,
        isImageLoading: false,
        isSuccess: false,
        userProfileResponseDTO: null,
        emailErrorText: null,
        addressErrorText: null,
        nameFocusNode: FocusNode(),
        addressFocusNode: FocusNode(),
        phoneFocusNode: FocusNode(),
        isEditing: false,
        phoneErrorText: null,
      );

  Future<bool> deleteAccount() async {
    try {
      await _deleteAccountUsecase.excute();
      return true;
    } catch (e) {
      return false;
    }
  }

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
            emailTFController: TextEditingController(text: response?.email),
            nameTFController:
                TextEditingController(text: response?.profile?.fullName),
            phoneTFController: TextEditingController(text: response?.phone),
            addressTFController:
                TextEditingController(text: response?.profile?.address),
            jobTFController:
                TextEditingController(text: response?.profile?.job),
            selectedDayOfBirth: response?.profile?.birthDay != null
                ? DateTime.parse(response!.profile!.birthDay!)
                : null,
            selectedGender: response?.profile?.gender != null
                ? AdvancedDropdownItemModel(
                    title: AppStrings.emptyText.text,
                    value: response?.profile?.gender == true
                        ? Gender.male
                        : Gender.female,
                  )
                : null,
            avatarUrl: response?.profile?.avatarUrl,
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

  Future<void> updateMyAvatar({
    required String avatarUrl,
  }) async {
    state = state.copyWith(
      isImageLoading: true,
    );
    try {
      final requestDTO = UserProfileRequestDTO(
        avatarUrl: avatarUrl,
      );
      UserProfileResponseDTO? response = await _updateMyProfileUsecase.execute(
        userProfileRequestDTO: requestDTO,
      );
      Future.delayed(
        const Duration(
          milliseconds: AnimationConstants.loadingAnimationExtraDelayDurationMS,
        ),
        () {
          state = state.copyWith(
            isImageLoading: false,
            userProfileResponseDTO: response,
          );
        },
      );
    } catch (err) {
      Future.delayed(
        const Duration(
          milliseconds: AnimationConstants.loadingAnimationExtraDelayDurationMS,
        ),
        () {
          state = state.copyWith(
            isImageLoading: false,
          );
          DialogService().failDialog(
            message: (err as ServerFailure).failureData?.message ??
                LocalizationService.translateText(TextType.someErrorOccurred),
          );
        },
      );
    }
  }

  Future<void> updateMyProfile({
    required WidgetRef ref,
  }) async {
    final loadingController =
        ref.read(LoadingProvider.loadingControllerProvider.notifier);
    loadingController.isLoading = true;
    state = state.copyWith(
      isSuccess: false,
    );
    try {
      final requestDTO = UserProfileRequestDTO(
        email: state.emailTFController.text,
        fullName: state.nameTFController.text,
        gender: state.selectedGender != null
            ? state.selectedGender?.value == Gender.male
                ? Gender.male.value
                : Gender.female.value
            : null,
        address: state.addressTFController.text,
        phone: state.phoneTFController.text,
        birthDay: state.selectedDayOfBirth.toString(),
      );
      UserProfileResponseDTO? response = await _updateMyProfileUsecase.execute(
        userProfileRequestDTO: requestDTO,
      );
      Future.delayed(
        const Duration(
          milliseconds: AnimationConstants.loadingAnimationExtraDelayDurationMS,
        ),
        () {
          loadingController.isLoading = false;
          state = state.copyWith(
            isSuccess: true,
            userProfileResponseDTO: response,
            isEditing: false,
          );
          DialogService().updateProfileSuccessDialog();
        },
      );
    } catch (err) {
      Future.delayed(
        const Duration(
          milliseconds: AnimationConstants.loadingAnimationExtraDelayDurationMS,
        ),
        () {
          loadingController.isLoading = false;
          DialogService().failDialog(
            message: (err as ServerFailure).failureData?.message ??
                LocalizationService.translateText(TextType.someErrorOccurred),
          );
        },
      );
    }
  }
}
