import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Flutter_CleanArchitechture/app/domain/auth/model/resent_otp_request_dto.dart';
import 'package:Flutter_CleanArchitechture/app/domain/auth/model/sign_in_request_dto.dart';
import 'package:Flutter_CleanArchitechture/app/domain/auth/model/sign_in_response_dto.dart';
import 'package:Flutter_CleanArchitechture/app/domain/auth/model/verify_request_dto.dart';
import 'package:Flutter_CleanArchitechture/app/domain/auth/usecase/resent_otp/resent_otp_usecase.dart';
import 'package:Flutter_CleanArchitechture/app/domain/auth/usecase/sign_in/sign_in_usecase.dart';
import 'package:Flutter_CleanArchitechture/app/domain/auth/usecase/verify/verify_usecase.dart';
import 'package:Flutter_CleanArchitechture/app/presentation/verify/enum/verify_view_type.dart';
import 'package:Flutter_CleanArchitechture/core/animation/constants/animation_constants.dart';
import 'package:Flutter_CleanArchitechture/core/authorization/service/authorization_service.dart';
import 'package:Flutter_CleanArchitechture/core/firebase/firebase_messaging_service.dart';

class VerifyViewState {
  static const int initMin = 600;
  final VerifyViewType viewType;
  final int remaining;
  final String uuid;
  final String email;
  final String password;
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;
  final bool isResentFail;
  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;
  final SignInResponseDTO? signInResponseDTO;

  const VerifyViewState({
    required this.signInResponseDTO,
    required this.password,
    required this.viewType,
    required this.remaining,
    required this.uuid,
    required this.email,
    required this.isLoading,
    required this.isSuccess,
    required this.isFailure,
    required this.isResentFail,
    required this.controllers,
    required this.focusNodes,
  });

  VerifyViewState copyWith({
    int? remaining,
    String? email,
    String? password,
    String? uuid,
    bool? isLoading,
    bool? isSuccess,
    bool? isFailure,
    bool? isResentFail,
    List<TextEditingController>? controllers,
    List<FocusNode>? focusNodes,
    VerifyViewType? viewType,
    SignInResponseDTO? signInResponseDTO,
  }) {
    if (signInResponseDTO != null) {
      _saveToken(signInResponseDTO);
    }
    if (isFailure != null && isFailure) {
      _clearToken();
    }
    return VerifyViewState(
      signInResponseDTO: signInResponseDTO ?? this.signInResponseDTO,
      viewType: viewType ?? this.viewType,
      remaining: remaining ?? this.remaining,
      email: email ?? this.email,
      password: password ?? this.password,
      uuid: uuid ?? this.uuid,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      isResentFail: isResentFail ?? this.isResentFail,
      controllers: controllers ?? this.controllers,
      focusNodes: focusNodes ?? this.focusNodes,
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

class VerifyViewController extends StateNotifier<VerifyViewState> {
  final VerifyUsecase _verifyUsecase;
  final ResentOTPUsecase _resentOTPUsecase;
  final SignInUsecase _signInUsecase;

  VerifyViewController({
    required VerifyUsecase verifyUsecase,
    required ResentOTPUsecase resentOTPUsecase,
    required SignInUsecase signInUsecase,
  })  : _verifyUsecase = verifyUsecase,
        _resentOTPUsecase = resentOTPUsecase,
        _signInUsecase = signInUsecase,
        super(
          VerifyViewState(
            signInResponseDTO: null,
            viewType: VerifyViewType.fromSignUp,
            remaining: 0,
            email: "",
            password: "",
            uuid: "",
            isLoading: false,
            isSuccess: false,
            isFailure: false,
            isResentFail: false,
            controllers: [
              TextEditingController(),
              TextEditingController(),
              TextEditingController(),
              TextEditingController(),
              TextEditingController(),
              TextEditingController(),
            ],
            focusNodes: [
              FocusNode(),
              FocusNode(),
              FocusNode(),
              FocusNode(),
              FocusNode(),
              FocusNode(),
            ],
          ),
        );

  /// Setter for [viewType].
  set viewType(VerifyViewType? viewType) =>
      state = state.copyWith(viewType: viewType);

  /// Setter for [email].
  set email(String? email) => state = state.copyWith(email: email);

  /// Setter for [password].
  set password(String? password) => state = state.copyWith(password: password);

  /// Setter for [isLoading].
  set isLoading(bool? isLoading) =>
      state = state.copyWith(isLoading: isLoading);

  /// Setter for [isSuccess].
  set isSuccess(bool? isSuccess) =>
      state = state.copyWith(isSuccess: isSuccess);

  /// Setter for [isFailure].
  set isFailure(bool? isFailure) =>
      state = state.copyWith(isFailure: isFailure);

  /// Setter for [controllers].
  set controllers(List<TextEditingController>? controllers) =>
      state = state.copyWith(controllers: controllers);

  /// Setter for [focusNodes].
  set focusNodes(List<FocusNode>? focusNodes) =>
      state = state.copyWith(focusNodes: focusNodes);

  /// Setter for [remaining].
  set remaining(int? remaining) => state = state.copyWith(remaining: remaining);

  /// Setter for [uuid].
  set uuid(String? uuid) => state = state.copyWith(uuid: uuid);

  /// Getter for [otp].
  String get otp =>
      state.controllers.map((controller) => controller.text).join();

  void resetState() {
    state = state.copyWith(
      signInResponseDTO: null,
      viewType: VerifyViewType.fromSignUp,
      remaining: 0,
      email: "",
      uuid: "",
      isLoading: false,
      isSuccess: false,
      isFailure: false,
      isResentFail: false,
      controllers: [
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
      ],
      focusNodes: [
        FocusNode(),
        FocusNode(),
        FocusNode(),
        FocusNode(),
        FocusNode(),
        FocusNode(),
      ],
    );
  }

  _countDownTimer() {
    remaining = VerifyViewState.initMin;
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (mounted && state.remaining > 0) {
          remaining = state.remaining - 1;
        } else {
          timer.cancel();
        }
      },
    );
  }

  Future<void> verify() async {
    state = state.copyWith(
      isSuccess: false,
      isFailure: false,
      isLoading: true,
      isResentFail: false,
    );

    try {
      VerifyRequestDTO verifyRequestDTO = VerifyRequestDTO(state.uuid, otp);
      await _verifyUsecase.execute(verifyRequestDTO: verifyRequestDTO);
      SignInRequestDTO signInRequestDTO =
          SignInRequestDTO(state.email, state.password);
      SignInResponseDTO? signInResponseDTO;
      if (state.viewType == VerifyViewType.fromSignIn) {
        signInResponseDTO =
            await _signInUsecase.execute(signInRequestDTO: signInRequestDTO);
        FirebaseMessagingService.shared.registerFirebaseMessage();
      }
      Future.delayed(
        const Duration(
          milliseconds: AnimationConstants.loadingAuthAnimationDurationMS,
        ),
        () {
          state = state.copyWith(
            signInResponseDTO: signInResponseDTO,
            isSuccess: true,
            isLoading: false,
            controllers: [
              TextEditingController(),
              TextEditingController(),
              TextEditingController(),
              TextEditingController(),
              TextEditingController(),
              TextEditingController(),
            ],
          );
        },
      );
    } catch (error) {
      Future.delayed(
        const Duration(
          milliseconds: AnimationConstants.loadingAnimationExtraDelayDurationMS,
        ),
        () {
          state = state.copyWith(
            isFailure: true,
            isLoading: false,
            controllers: [
              TextEditingController(),
              TextEditingController(),
              TextEditingController(),
              TextEditingController(),
              TextEditingController(),
              TextEditingController(),
            ],
          );
        },
      );
    }
  }

  Future<void> resentOTP() async {
    state = state.copyWith(
      isSuccess: false,
      isFailure: false,
      isLoading: false,
      isResentFail: false,
    );

    try {
      ResentOTPRequestDTO resentOTPRequestDTO =
          ResentOTPRequestDTO(state.email, state.uuid);
      await _resentOTPUsecase.execute(resentOTPRequestDTO: resentOTPRequestDTO);
      _countDownTimer();
    } catch (error) {
      state = state.copyWith(
        isResentFail: true,
      );
    }
  }
}
