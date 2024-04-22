import 'package:flutter/material.dart';
import 'package:nogironlar_ilovasi/features/sos/sos_screen.dart';
import 'package:nogironlar_ilovasi/features/speech_to_text/speech_to_text_screen.dart';
import 'package:nogironlar_ilovasi/features/widgets/main_button.dart';
import 'package:nogironlar_ilovasi/features/widgets/navigate.dart';
import 'package:nogironlar_ilovasi/service/l10n/app_localizations.dart';

import '../location/location_screen.dart';
import '../picture_to_text/picture_to_text_screen.dart';
import '../settings/settings_screen.dart';
import '../text_to_speech/text_to_speech_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    const gap = 20.0;
    final lang = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () => navigateTo(context, const SettingScreen()),
            icon: const Image(
              image: AssetImage("assets/images/95631.png"),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          const Text(
            "CEREBRO",
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              letterSpacing: 6,
            ),
          ),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: size.width / 5),
              children: [
                const SizedBox(height: gap),
                MainButton(
                  lang.speak,
                  onPressed: () =>
                      navigateTo(context, const SpeechToTextScreen()),
                ),
                const SizedBox(height: gap),
                MainButton(
                  lang.see,
                  onPressed: () => navigateTo(context, const PictureToText()),
                ),
                const SizedBox(height: gap),
                MainButton(
                  lang.hear,
                  onPressed: () => navigateTo(context, const TextToSpeech()),
                ),
                const SizedBox(height: gap),
                MainButton(
                  lang.location,
                  onPressed: () => navigateTo(context, const LocationScreen()),
                ),
                const SizedBox(height: gap),
                MainButton(
                  lang.sos,
                  onPressed: () => navigateTo(context, const SOSScreen()),
                ),
                const SizedBox(height: gap),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
