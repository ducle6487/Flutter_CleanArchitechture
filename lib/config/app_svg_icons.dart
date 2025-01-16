enum AppSvgIcons {
  eyeShow('eye_show'),
  eyeHide('eye_hide'),
  calendar('calendar'),
  bell('notification_bell'),
  darkMode('dark_mode'),
  language('language'),
  profile('profile'),
  termOfUse('term_of_use'),
  chevron('chevron'),
  defaultAvatar('default_appbar_avatar'),
  candle('candle'),
  gender('gender'),
  location('location'),
  lock('lock'),
  mail('mail'),
  phone('phone'),
  deleteAccount('delete_account'),
  x('x'),
  ;

  final String _fileName;
  static const String _svgIconAsset = "assets/svg_icons/";

  const AppSvgIcons(this._fileName);

  // Method to get the full path of the SVG icon
  String get svg => '$_svgIconAsset$_fileName.svg';
}
