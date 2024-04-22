import 'package:flutter/material.dart';
import 'package:nogironlar_ilovasi/features/language/language_screen.dart';
import 'package:nogironlar_ilovasi/features/widgets/main_button.dart';
import 'package:nogironlar_ilovasi/features/widgets/navigate.dart';

import '../../service/l10n/app_localizations.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                lang.settings,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              MainButton(
                lang.language,
                width: size.width / 2,
                onPressed: () =>
                    navigateTo(context, const LanguageScreen()),
              ),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}
