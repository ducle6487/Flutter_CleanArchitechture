import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_clean_architechture/app/domain/auth/model/sign_in_request_dto.dart';
import 'package:flutter_clean_architechture/app/domain/auth/model/sign_in_response_dto.dart';
import 'package:flutter_clean_architechture/app/domain/auth/usecase/sign_in/sign_in_usecase.dart';
import 'package:flutter_clean_architechture/config/app_strings.dart';
import 'package:flutter_clean_architechture/core/animation/constants/animation_constants.dart';
import 'package:flutter_clean_architechture/core/api/enum/status_code.dart';
import 'package:flutter_clean_architechture/core/authorization/service/authorization_service.dart';
import 'package:flutter_clean_architechture/core/dialog/dialog_service.dart';
import 'package:flutter_clean_architechture/core/error/model/failure.dart';
import 'package:flutter_clean_architechture/core/error/model/server_failure.dart';
import 'package:flutter_clean_architechture/core/firebase/firebase_messaging_service.dart';
import 'package:flutter_clean_architechture/core/localization/enum/text_type.dart';
import 'package:flutter_clean_architechture/core/localization/service/localization_service.dart';
import 'package:flutter_clean_architechture/core/log/extension/log_extension.dart';

class SignInViewState {
  final TextEditingController emailTFController;
  final TextEditingController passwordTFController;
  final SignInResponseDTO? signInResponseDTO;
  final String? emailErrorText;
  final String? passwordErrorText;
  final bool isLoading;
  final bool isUnVerify;
  final bool isObscureTextField;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;

  const SignInViewState({
    required this.signInResponseDTO,
    required this.isLoading,
    required this.isUnVerify,
    required this.emailTFController,
    required this.passwordTFController,
    required this.emailErrorText,
    required this.passwordErrorText,
    required this.isObscureTextField,
    required this.emailFocusNode,
    required this.passwordFocusNode,
  });

  /// Creates a copy of this class.
  SignInViewState copyWith({
    SignInResponseDTO? signInResponseDTO,
    bool? isError,
    bool? isLoading,
    bool? isUnVerify,
    TextEditingController? emailTFController,
    TextEditingController? passwordTFController,
    String? emailErrorText,
    String? passwordErrorText,
    bool? isObscureTextField,
    FocusNode? emailFocusNode,
    FocusNode? passwordFocusNode,
  }) {
    if (signInResponseDTO != null) {
      _saveToken(signInResponseDTO);
    }
    if (isError != null && isError) {
      _clearToken();
    }
    return SignInViewState(
      signInResponseDTO: signInResponseDTO ?? this.signInResponseDTO,
      isLoading: isLoading ?? this.isLoading,
      isUnVerify: isUnVerify ?? this.isUnVerify,
      emailTFController: emailTFController ?? this.emailTFController,
      passwordTFController: passwordTFController ?? this.passwordTFController,
      emailErrorText: emailErrorText,
      passwordErrorText: passwordErrorText,
      isObscureTextField: isObscureTextField ?? this.isObscureTextField,
      emailFocusNode: emailFocusNode ?? this.emailFocusNode,
      passwordFocusNode: passwordFocusNode ?? this.passwordFocusNode,
    );
  }

  void _saveToken(SignInResponseDTO signInResponseDTO) {
    AuthorizationService.instance.refreshToken = signInResponseDTO.refreshToken;
    AuthorizationService.instance.accessToken = signInResponseDTO.accessToken;
  }

  void _clearToken() {
    AuthorizationService.instance.clearToken(isNotPop: true);
  }
}

class SignInViewController extends StateNotifier<SignInViewState> {
  final SignInUsecase _signInUsecase;

  SignInViewController({
    required SignInUsecase signInUsecase,
  })  : _signInUsecase = signInUsecase,
        super(SignInViewState(
          signInResponseDTO: null,
          isLoading: false,
          isUnVerify: false,
          emailErrorText: null,
          passwordErrorText: null,
          emailTFController: TextEditingController(),
          passwordTFController: TextEditingController(),
          isObscureTextField: true,
          emailFocusNode: FocusNode(),
          passwordFocusNode: FocusNode(),
        ));

  /// Getter for [isObscureTextField].
  bool get isObscureTextField => state.isObscureTextField;

  /// Setter for [isObscureTextField].
  set isObscureTextField(bool isObscureTextField) =>
      state = state.copyWith(isObscureTextField: isObscureTextField);

  /// Setter for [signInResponseDTO].
  set signInResponseDTO(SignInResponseDTO? signInResponseDTO) =>
      state = state.copyWith(signInResponseDTO: signInResponseDTO);

  /// Setter for [emailTFController].
  set emailTFController(TextEditingController? emailTFController) =>
      state = state.copyWith(emailTFController: emailTFController);

  /// Setter for [passwordTFController].
  set passwordTFController(TextEditingController? passwordTFController) =>
      state = state.copyWith(passwordTFController: passwordTFController);

  /// Setter for [emailErrorText].
  set emailErrorText(String? emailErrorText) =>
      state = state.copyWith(emailErrorText: emailErrorText);

  /// Setter for [passwordErrorText].
  set passwordErrorText(String? passwordErrorText) =>
      state = state.copyWith(passwordErrorText: passwordErrorText);

  /// Setter for [isError].
  set isError(bool? isError) => state = state.copyWith(isError: isError);

  /// Setter for [isLoading].
  set isLoading(bool? isLoading) =>
      state = state.copyWith(isLoading: isLoading);

  /// Setter for [isUnVerify].
  set isUnVerify(bool? isUnVerify) =>
      state = state.copyWith(isUnVerify: isUnVerify);

  /// set validate for sign in form
  void validateSignInForm({
    String? emailErrorText,
    String? passwordErrorText,
  }) {
    state = state.copyWith(
      emailErrorText: emailErrorText,
      passwordErrorText: passwordErrorText,
    );
  }

  /// Resets the state.
  void resetState() => state = SignInViewState(
        signInResponseDTO: null,
        emailErrorText: null,
        passwordErrorText: null,
        isLoading: false,
        isUnVerify: false,
        emailTFController: TextEditingController(),
        passwordTFController: TextEditingController(),
        isObscureTextField: true,
        emailFocusNode: FocusNode(),
        passwordFocusNode: FocusNode(),
      );

  /// Sign in
  Future<void> signIn({required SignInRequestDTO signInRequestDTO}) async {
    state = state.copyWith(
      isError: false,
      isUnVerify: false,
      isLoading: true,
    );
    try {
      final SignInResponseDTO? response =
          await _signInUsecase.execute(signInRequestDTO: signInRequestDTO);
      Future.delayed(
        const Duration(
          milliseconds: AnimationConstants.loadingAuthAnimationDurationMS,
        ),
        () {
          if (response != null &&
              response.statusCode != null &&
              response.statusCode == StatusCode.unVerifyAccount.code) {
            state = state.copyWith(
                isUnVerify: true,
                isLoading: false,
                signInResponseDTO: response);
          } else if (response != null &&
              response.statusCode != null &&
              response.statusCode == StatusCode.deletedAccount.code) {
            state = state.copyWith(
              isLoading: false,
            );
            DialogService().failDialog(
              message: response.message ?? AppStrings.emptyText.text,
            );
          } else {
            state = state.copyWith(
              signInResponseDTO: response,
              isLoading: false,
            );
            FirebaseMessagingService.shared.registerFirebaseMessage();
          }
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
            isError: true,
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
