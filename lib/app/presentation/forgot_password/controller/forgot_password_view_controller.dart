import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_clean_architechture/app/domain/auth/model/forgot_password_request_dto.dart';
import 'package:flutter_clean_architechture/app/domain/auth/usecase/forgot_password/forgot_password_usecase.dart';
import 'package:flutter_clean_architechture/core/animation/constants/animation_constants.dart';
import 'package:flutter_clean_architechture/core/error/model/failure.dart';
import 'package:flutter_clean_architechture/core/error/model/server_failure.dart';
import 'package:flutter_clean_architechture/core/log/extension/log_extension.dart';
import '../../../../core/dialog/dialog_service.dart';
import '../../../../core/localization/enum/text_type.dart';
import '../../../../core/localization/service/localization_service.dart';
import '../enum/forgot_password_view_type.dart';

class ForgotPasswordViewState {
  final TextEditingController emailTFController;
  final String? radioButtonSelected;
  final ForgotPasswordViewType? viewType;
  final bool isLoading;
  final bool isError;
  final bool isSuccess;

  const ForgotPasswordViewState({
    required this.emailTFController,
    this.radioButtonSelected,
    this.viewType,
    required this.isLoading,
    required this.isError,
    required this.isSuccess,
  });

  /// Creates a copy of this class.
  ForgotPasswordViewState copyWith({
    TextEditingController? emailTFController,
    String? radioButtonSelected,
    ForgotPasswordViewType? viewType,
    bool? isLoading,
    bool? isError,
    bool? isSuccess,
  }) {
    return ForgotPasswordViewState(
      emailTFController: emailTFController ?? this.emailTFController,
      radioButtonSelected: radioButtonSelected ?? this.radioButtonSelected,
      viewType: viewType ?? this.viewType,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

class ForgotPasswordViewController
    extends StateNotifier<ForgotPasswordViewState> {
  final ForgotPasswordUsecase forgotPasswordUsecase;

  ForgotPasswordViewController({
    required this.forgotPasswordUsecase,
  }) : super(
          ForgotPasswordViewState(
            emailTFController: TextEditingController(),
            radioButtonSelected: null,
            viewType: ForgotPasswordViewType.selectMethod,
            isLoading: false,
            isError: false,
            isSuccess: false,
          ),
        );

  /// Setter for [emailTFController].
  set emailTFController(TextEditingController? emailTFController) =>
      state = state.copyWith(emailTFController: emailTFController);

  /// Setter for [isLoading].
  set isLoading(bool? isLoading) =>
      state = state.copyWith(isLoading: isLoading);

  /// Setter for [isError].
  set isError(bool? isError) => state = state.copyWith(isError: isError);

  /// Setter for [isSuccess].
  set isSuccess(bool? isSuccess) =>
      state = state.copyWith(isSuccess: isSuccess);

  ///Setter for [radioButtonSelected]
  set radioButtonSelected(String? radioButtonSelected) {
    state = state.copyWith(radioButtonSelected: radioButtonSelected);
  }

  ///Setter for [viewType]
  set viewType(ForgotPasswordViewType? viewType) {
    state = state.copyWith(viewType: viewType);
  }

  /// Resets the state.
  void resetState() => state = ForgotPasswordViewState(
        emailTFController: TextEditingController(),
        viewType: ForgotPasswordViewType.selectMethod,
        radioButtonSelected: state.radioButtonSelected,
        isLoading: false,
        isSuccess: false,
        isError: false,
      );

  Future<void> resetPassword({
    required ForgotPasswordRequestDTO forgotPasswordRequestDTO,
  }) async {
    state = state.copyWith(
      isError: false,
      isSuccess: false,
      isLoading: true,
    );
    try {
      await forgotPasswordUsecase.execute(
        forgotPasswordRequestDTO: forgotPasswordRequestDTO,
      );
      Future.delayed(
        const Duration(
          milliseconds: AnimationConstants.loadingAuthAnimationDurationMS,
        ),
        () {
          state = state.copyWith(
            isSuccess: true,
            isLoading: false,
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
            isError: true,
            isLoading: false,
          );
        },
      );
      DialogService().failDialog(
        message: (failure as ServerFailure).failureData?.message ??
            LocalizationService.translateText(TextType.someErrorOccurred),
      );
    }
  }
}
