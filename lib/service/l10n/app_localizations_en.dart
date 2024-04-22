import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get speak => 'SPEAK';

  @override
  String get see => 'SEE';

  @override
  String get hear => 'HEAR';

  @override
  String get sos => 'SOS';

  @override
  String get settings => 'SETTINGS';

  @override
  String get language => 'LANGUAGE';

  @override
  String get location => 'LOCATION';

  @override
  String get aboutApp => 'ABOUT APP';

  @override
  String get tapToStartListening => 'Tap the speak button to start listening';

  @override
  String get speechNotAvailable => 'Speech is not available';

  @override
  String get listening => 'Listening ...';

  @override
  String get scanImage => 'scan image';

  @override
  String get voice => 'voice';

  @override
  String get share => 'share';

  @override
  String get currentLocation => 'get current location';

  @override
  String get lng => 'longitude';

  @override
  String get lat => 'latitude';
}
