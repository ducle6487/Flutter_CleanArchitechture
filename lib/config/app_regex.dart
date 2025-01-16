enum AppRegex {
  email(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"),
  password(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*?&]{8,}$'),
  vietnamPhone(r'^0[35789]\d{8}$'),
  upperCharacter(r'[A-Z]'),
  specialCharacter(r'[!@#$%^&*(),.?":{}|<>]'),
  http(r'http[s]?://[^ ]+'),
  https(r"^https:\/\/[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}(\/\S*)?$"),
  ;

  final String pattern;

  const AppRegex(this.pattern);

  // Method to get the regex pattern string
  String get regex => pattern;

  // Method to get the compiled RegExp object
  RegExp get regExp => RegExp(pattern);
}
