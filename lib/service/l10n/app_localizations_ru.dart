import 'app_localizations.dart';

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get speak => 'ГОВОРИТЬ';

  @override
  String get see => 'ВИДЕТЬ';

  @override
  String get hear => 'СЛЫШАТЬ';

  @override
  String get sos => 'СОС';

  @override
  String get settings => 'НАСТРОЙКИ';

  @override
  String get language => 'ЯЗЫК';

  @override
  String get location => 'РАСПОЛОЖЕНИЕ';

  @override
  String get aboutApp => 'О ПРИЛОЖЕНИИ';

  @override
  String get tapToStartListening => 'Нажмите кнопку «говорить», чтобы начать слушать';

  @override
  String get speechNotAvailable => 'Речь недоступна';

  @override
  String get listening => 'Прослушивание ...';

  @override
  String get scanImage => 'сканировать изображение';

  @override
  String get voice => 'голос';

  @override
  String get share => 'делиться';

  @override
  String get currentLocation => 'текущее местоположение';

  @override
  String get lng => 'долгота';

  @override
  String get lat => 'широта';
}
