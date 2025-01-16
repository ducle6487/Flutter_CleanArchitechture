import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Flutter_CleanArchitechture/app/domain/auth/model/change_password_request_dto.dart';
import 'package:Flutter_CleanArchitechture/core/error/model/failure.dart';
import 'package:Flutter_CleanArchitechture/core/log/extension/log_extension.dart';
import '../../../../core/dialog/dialog_service.dart';
import '../../../../core/error/model/server_failure.dart';
import '../../../../core/loading/provider/loading_provider.dart';
import '../../../../core/localization/enum/text_type.dart';
import '../../../../core/localization/service/localization_service.dart';
import '../../../domain/user/usecase/change_password/change_password_usecase.dart';

class ChangePasswordViewState {
  final TextEditingController currentPasswordTFController;
  final TextEditingController newPasswordTFController;
  final TextEditingController repeatNewPasswordTFController;
  final String? currentPasswordErrorText;
  final String? newPasswordErrorText;
  final String? repeatNewPasswordErrorText;
  final bool isError;
  final bool isSuccess;
  final bool oldPasswordObscure;
  final bool newPasswordObscure;
  final bool repeatNewPasswordObscure;
  final FocusNode currentPasswordFocusNode;
  final FocusNode newPasswordFocusNode;
  final FocusNode repeatNewPasswordFocusNode;

  const ChangePasswordViewState({
    required this.isError,
    required this.isSuccess,
    required this.currentPasswordErrorText,
    required this.newPasswordErrorText,
    required this.repeatNewPasswordErrorText,
    required this.currentPasswordTFController,
    required this.newPasswordTFController,
    required this.repeatNewPasswordTFController,
    required this.oldPasswordObscure,
    required this.newPasswordObscure,
    required this.repeatNewPasswordObscure,
    required this.currentPasswordFocusNode,
    required this.newPasswordFocusNode,
    required this.repeatNewPasswordFocusNode,
  });

  /// Creates a copy of this class.
  ChangePasswordViewState copyWith({
    bool? isError,
    bool? isSuccess,
    String? currentPasswordErrorText,
    String? newPasswordErrorText,
    String? repeatNewPasswordErrorText,
    TextEditingController? currentPasswordTFController,
    TextEditingController? newPasswordTFController,
    TextEditingController? repeatNewPasswordTFController,
    bool? oldPasswordObscure,
    bool? newPasswordObscure,
    bool? repeatNewPasswordObscure,
    FocusNode? currentPasswordFocusNode,
    FocusNode? newPasswordFocusNode,
    FocusNode? repeatNewPasswordFocusNode,
  }) {
    return ChangePasswordViewState(
      isError: isError ?? false,
      isSuccess: isSuccess ?? this.isSuccess,
      currentPasswordErrorText: currentPasswordErrorText,
      newPasswordErrorText: newPasswordErrorText,
      repeatNewPasswordErrorText: repeatNewPasswordErrorText,
      currentPasswordTFController:
          currentPasswordTFController ?? this.currentPasswordTFController,
      newPasswordTFController:
          newPasswordTFController ?? this.newPasswordTFController,
      repeatNewPasswordTFController:
          repeatNewPasswordTFController ?? this.repeatNewPasswordTFController,
      oldPasswordObscure: oldPasswordObscure ?? this.oldPasswordObscure,
      newPasswordObscure: newPasswordObscure ?? this.newPasswordObscure,
      repeatNewPasswordObscure:
          repeatNewPasswordObscure ?? this.repeatNewPasswordObscure,
      currentPasswordFocusNode:
          currentPasswordFocusNode ?? this.currentPasswordFocusNode,
      newPasswordFocusNode: newPasswordFocusNode ?? this.newPasswordFocusNode,
      repeatNewPasswordFocusNode:
          repeatNewPasswordFocusNode ?? this.repeatNewPasswordFocusNode,
    );
  }
}

class ChangePasswordViewController
    extends StateNotifier<ChangePasswordViewState> {
  final ChangePasswordUsecase _changePasswordUsecase;

  ChangePasswordViewController({
    required ChangePasswordUsecase changePasswordUsecase,
  })  : _changePasswordUsecase = changePasswordUsecase,
        super(
          ChangePasswordViewState(
            isError: false,
            isSuccess: false,
            currentPasswordErrorText: null,
            newPasswordErrorText: null,
            repeatNewPasswordErrorText: null,
            currentPasswordTFController: TextEditingController(),
            newPasswordTFController: TextEditingController(),
            repeatNewPasswordTFController: TextEditingController(),
            oldPasswordObscure: false,
            newPasswordObscure: false,
            repeatNewPasswordObscure: false,
            currentPasswordFocusNode: FocusNode(),
            newPasswordFocusNode: FocusNode(),
            repeatNewPasswordFocusNode: FocusNode(),
          ),
        );

  /// Setter for [currentPasswordTFController].
  set currentPasswordTFController(
          TextEditingController? currentPasswordTFController) =>
      state = state.copyWith(
        currentPasswordTFController: currentPasswordTFController,
      );

  /// Setter for [newPasswordTFController].
  set newPasswordTFController(TextEditingController? newPasswordTFController) =>
      state = state.copyWith(
        newPasswordTFController: newPasswordTFController,
      );

  /// Setter for [repeatNewPasswordTFController].
  set repeatNewPasswordTFController(
          TextEditingController? repeatNewPasswordTFController) =>
      state = state.copyWith(
        repeatNewPasswordTFController: repeatNewPasswordTFController,
      );

  /// Setter for [currentPasswordErrorText].
  set currentPasswordErrorText(String? currentPasswordErrorText) =>
      state = state.copyWith(
        currentPasswordErrorText: currentPasswordErrorText,
      );

  /// Setter for [newPasswordErrorText].
  set newPasswordErrorText(String? newPasswordErrorText) =>
      state = state.copyWith(
        newPasswordErrorText: newPasswordErrorText,
      );

  /// Setter for [repeatNewPasswordErrorText].
  set repeatNewPasswordErrorText(String? repeatNewPasswordErrorText) =>
      state = state.copyWith(
        repeatNewPasswordErrorText: repeatNewPasswordErrorText,
      );

  /// Setter for [isError].
  set isError(bool? isError) => state = state.copyWith(isError: isError);

  /// Setter for [isSuccess].
  set isSuccess(bool? isSuccess) =>
      state = state.copyWith(isSuccess: isSuccess);

  /// set validate for change password form
  void validateChangePasswordForm({
    String? currentPasswordErrorText,
    String? newPasswordErrorText,
    String? repeatPasswordErrorText,
  }) {
    state = state.copyWith(
      currentPasswordErrorText: currentPasswordErrorText,
      newPasswordErrorText: newPasswordErrorText,
      repeatNewPasswordErrorText: repeatPasswordErrorText,
    );
  }

  /// Resets the state.
  void resetState() => state = ChangePasswordViewState(
        isError: false,
        isSuccess: false,
        currentPasswordErrorText: null,
        newPasswordErrorText: null,
        repeatNewPasswordErrorText: null,
        currentPasswordTFController: TextEditingController(),
        newPasswordTFController: TextEditingController(),
        repeatNewPasswordTFController: TextEditingController(),
        newPasswordObscure: true,
        oldPasswordObscure: true,
        repeatNewPasswordObscure: true,
        currentPasswordFocusNode: FocusNode(),
        newPasswordFocusNode: FocusNode(),
        repeatNewPasswordFocusNode: FocusNode(),
      );

  /// Change password
  Future<void> changePassword({
    required ChangePasswordRequestDTO changePasswordRequestDTO,
    required WidgetRef ref,
  }) async {
    final loadingController =
        ref.read(LoadingProvider.loadingControllerProvider.notifier);
    loadingController.isLoading = true;
    state = state.copyWith(
      isError: false,
      isSuccess: false,
    );
    try {
      await _changePasswordUsecase.execute(
        changePasswordRequestDTO: changePasswordRequestDTO,
      );
      loadingController.isLoading = false;
      state = state.copyWith(
        isSuccess: true,
      );
      resetState();
    } on Failure catch (failure) {
      StackTrace.current.printErrorMessage(failure: failure);
      loadingController.isLoading = false;
      state = state.copyWith(
        isError: true,
      );
      DialogService().failDialog(
        message: (failure as ServerFailure).failureData?.message ??
            LocalizationService.translateText(TextType.someErrorOccurred),
      );
    }
  }

  void toggleOldPasswordObscure() {
    state = state.copyWith(oldPasswordObscure: !state.oldPasswordObscure);
  }

  void toggleNewPasswordObscure() {
    state = state.copyWith(newPasswordObscure: !state.newPasswordObscure);
  }

  void toggleRepeatNewPasswordObscure() {
    state = state.copyWith(
        repeatNewPasswordObscure: !state.repeatNewPasswordObscure);
  }
}
