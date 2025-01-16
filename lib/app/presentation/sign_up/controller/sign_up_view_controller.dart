import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_clean_architechture/app/domain/auth/model/sign_in_response_dto.dart';
import 'package:flutter_clean_architechture/app/domain/auth/model/sign_up_request_dto.dart';
import 'package:flutter_clean_architechture/app/domain/auth/usecase/sign_up/sign_up_usecase.dart';
import 'package:flutter_clean_architechture/core/animation/constants/animation_constants.dart';
import 'package:flutter_clean_architechture/core/dialog/dialog_service.dart';
import 'package:flutter_clean_architechture/core/error/model/failure.dart';
import 'package:flutter_clean_architechture/core/error/model/server_failure.dart';
import 'package:flutter_clean_architechture/core/localization/enum/text_type.dart';
import 'package:flutter_clean_architechture/core/localization/service/localization_service.dart';
import 'package:flutter_clean_architechture/core/log/extension/log_extension.dart';
import 'package:flutter_clean_architechture/core/widgets/model/advanced_dropdown_item_model.dart';

class SignUpViewState {
  final String? uuid;
  final TextEditingController emailTFController;
  final TextEditingController passwordTFController;
  final TextEditingController phoneTFController;
  final TextEditingController addressTFController;
  final AdvancedDropdownItemModel? selectedGender;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;
  final FocusNode phoneFocusNode;
  final FocusNode addressFocusNode;
  final DateTime? selectedDayOfBirth;
  final bool isSelectedAgreement;
  final bool isSelectedAgreementHighlight;
  final bool isLoading;
  final bool isSuccess;
  final bool isObscureTextField;

  const SignUpViewState({
    required this.uuid,
    required this.emailTFController,
    required this.passwordTFController,
    required this.phoneTFController,
    required this.addressTFController,
    required this.selectedGender,
    required this.selectedDayOfBirth,
    required this.isLoading,
    required this.isSuccess,
    required this.emailFocusNode,
    required this.passwordFocusNode,
    required this.addressFocusNode,
    required this.phoneFocusNode,
    required this.isObscureTextField,
    required this.isSelectedAgreement,
    required this.isSelectedAgreementHighlight,
  });

  /// Creates a copy of this class.
  SignUpViewState copyWith({
    TextEditingController? emailTFController,
    TextEditingController? passwordTFController,
    TextEditingController? phoneTFController,
    TextEditingController? addressTFController,
    AdvancedDropdownItemModel? selectedCountry,
    AdvancedDropdownItemModel? selectedGender,
    FocusNode? emailFocusNode,
    FocusNode? passwordFocusNode,
    FocusNode? phoneFocusNode,
    FocusNode? addressFocusNode,
    DateTime? selectedDayOfBirth,
    bool? isLoading,
    bool? isSuccess,
    String? uuid,
    bool? isObscureTextField,
    bool? isSelectedAgreement,
    bool? isSelectedAgreementHighlight,
  }) {
    return SignUpViewState(
      emailTFController: emailTFController ?? this.emailTFController,
      passwordTFController: passwordTFController ?? this.passwordTFController,
      phoneTFController: phoneTFController ?? this.phoneTFController,
      addressTFController: addressTFController ?? this.addressTFController,
      selectedGender: selectedGender ?? this.selectedGender,
      selectedDayOfBirth: selectedDayOfBirth ?? this.selectedDayOfBirth,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      uuid: uuid ?? this.uuid,
      emailFocusNode: emailFocusNode ?? this.emailFocusNode,
      passwordFocusNode: passwordFocusNode ?? this.passwordFocusNode,
      phoneFocusNode: phoneFocusNode ?? this.phoneFocusNode,
      addressFocusNode: addressFocusNode ?? this.addressFocusNode,
      isObscureTextField: isObscureTextField ?? this.isObscureTextField,
      isSelectedAgreement: isSelectedAgreement ?? this.isSelectedAgreement,
      isSelectedAgreementHighlight:
          isSelectedAgreementHighlight ?? this.isSelectedAgreementHighlight,
    );
  }
}

class SignUpViewController extends StateNotifier<SignUpViewState> {
  final SignUpUsecase _signUpUsecase;

  SignUpViewController({
    required SignUpUsecase signUpUsecase,
  })  : _signUpUsecase = signUpUsecase,
        super(
          SignUpViewState(
            emailTFController: TextEditingController(),
            passwordTFController: TextEditingController(),
            phoneTFController: TextEditingController(),
            addressTFController: TextEditingController(),
            selectedGender: null,
            selectedDayOfBirth: null,
            isLoading: false,
            isSuccess: false,
            uuid: null,
            emailFocusNode: FocusNode(),
            passwordFocusNode: FocusNode(),
            addressFocusNode: FocusNode(),
            phoneFocusNode: FocusNode(),
            isObscureTextField: true,
            isSelectedAgreement: false,
            isSelectedAgreementHighlight: false,
          ),
        );

  /// Setter for [isSelectedAgreementHighlight]
  set isSelectedAgreementHighlight(bool? isHighlight) =>
      state = state.copyWith(isSelectedAgreementHighlight: isHighlight);

  /// Setter for [isSelectedAgreement]
  set isSelectedAgreement(bool? isSelected) =>
      state = state.copyWith(isSelectedAgreement: isSelected);

  /// Setter for [emailTFController].
  set emailTFController(TextEditingController? emailTFController) =>
      state = state.copyWith(emailTFController: emailTFController);

  /// Setter for [passwordTFController].
  set passwordTFController(TextEditingController? passwordTFController) =>
      state = state.copyWith(passwordTFController: passwordTFController);

  /// Setter for [phoneTFController].
  set phoneTFController(TextEditingController? phoneTFController) =>
      state = state.copyWith(phoneTFController: phoneTFController);

  /// Setter for [addressTFController].
  set addressTFController(TextEditingController? addressTFController) =>
      state = state.copyWith(addressTFController: addressTFController);

  /// Setter for [selectedGender].
  set selectedGender(AdvancedDropdownItemModel? selectedGender) =>
      state = state.copyWith(selectedGender: selectedGender);

  /// Setter for [selectedDayOfBirth].
  set selectedDayOfBirth(DateTime? selectedDayOfBirth) =>
      state = state.copyWith(selectedDayOfBirth: selectedDayOfBirth);

  /// Setter for [isLoading].
  set isLoading(bool? isLoading) =>
      state = state.copyWith(isLoading: isLoading);

  /// Setter for [isSuccess].
  set isSuccess(bool? isSuccess) =>
      state = state.copyWith(isSuccess: isSuccess);

  /// Setter for [isObscureTextField].
  set isObscureTextField(bool isObscureTextField) =>
      state = state.copyWith(isObscureTextField: isObscureTextField);

  /// Resets the state.
  void resetState() => state = SignUpViewState(
        uuid: null,
        emailTFController: TextEditingController(),
        passwordTFController: TextEditingController(),
        phoneTFController: TextEditingController(),
        addressTFController: TextEditingController(),
        selectedGender: null,
        selectedDayOfBirth: null,
        isLoading: false,
        isSuccess: false,
        emailFocusNode: FocusNode(),
        passwordFocusNode: FocusNode(),
        addressFocusNode: FocusNode(),
        phoneFocusNode: FocusNode(),
        isObscureTextField: true,
        isSelectedAgreement: false,
        isSelectedAgreementHighlight: false,
      );

  Future<void> signUp(SignUpRequestDTO signUpRequestDTO) async {
    state = state.copyWith(
      isSuccess: false,
      isLoading: true,
    );
    try {
      SignInResponseDTO? response =
          await _signUpUsecase.execute(signUpRequestDTO: signUpRequestDTO);
      Future.delayed(
        const Duration(
          milliseconds: AnimationConstants.loadingAuthAnimationDurationMS,
        ),
        () {
          state = state.copyWith(
            isSuccess: true,
            isLoading: false,
            uuid: response?.uuid,
          );
        },
      );
    } on Failure catch (failure) {
      Future.delayed(
        const Duration(
          milliseconds: AnimationConstants.loadingAnimationExtraDelayDurationMS,
        ),
        () {
          StackTrace.current.printErrorMessage(failure: failure);
          state = state.copyWith(
            isLoading: false,
          );
          DialogService().failDialog(
            message: (failure as ServerFailure).failureData?.message ??
                LocalizationService.translateText(TextType.someErrorOccurred),
          );
        },
      );
    }
  }

  void toggleObscureText() {
    state = state.copyWith(isObscureTextField: !state.isObscureTextField);
  }
}
