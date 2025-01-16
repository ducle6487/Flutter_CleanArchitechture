import 'package:flutter_clean_architechture/config/app_resources.dart';

enum AuthEndPoint {
  register('/register'),
  signIn('/sign-in'),
  signOut('/sign-out'),
  refreshToken('/refresh-token'),
  active('/active'),
  sendOtp('/send-otp'),
  forgotPassword('/forgot-password'),
  setPassword('/set-password'),
  verifyForgotPassword('/verify-forgot-password');

  final String value;
  const AuthEndPoint(this.value);

  String getUrl() {
    return AppResources.authBaseUrl + value;
  }
}
