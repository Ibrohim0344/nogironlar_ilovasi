import 'package:flutter/material.dart';
import 'package:nogironlar_ilovasi/service/controller/app_model.dart';
import 'package:nogironlar_ilovasi/service/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../features/home/home_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppModel(),
      child: Builder(
        builder: (context) {
          final locale = context.watch<AppModel>().locale;
          return MaterialApp(
            title: "Nogironlar ilovasi",
            debugShowCheckedModeBanner: false,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: Locale(locale),
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
            ),
            home: const HomeScreen(),
          );
        }
      ),
    );
  }
}
