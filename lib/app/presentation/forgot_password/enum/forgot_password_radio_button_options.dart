import '../../../../core/localization/enum/text_type.dart';

enum ForgotPasswordRadioButtonOptions {
  email('email', TextType.email),
  textSMS('textSms', TextType.textMessageSMS),
  ;

  final String name;
  final TextType value;

  const ForgotPasswordRadioButtonOptions(
    this.name,
    this.value,
  );
}
