import 'package:flutter/material.dart';

import '../features/speech_to_text/speech_to_text_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: "Nogironlar ilovasi",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
      ),
      home: const SpeechToTextScreen(),
    );
  }
}
