import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:http/http.dart' as http;
import 'package:nogironlar_ilovasi/main.dart';

import '../../service/l10n/app_localizations.dart';

class TextToSpeech extends StatefulWidget {
  const TextToSpeech({super.key});

  @override
  State<TextToSpeech> createState() => _TextToSpeechState();
}

class _TextToSpeechState extends State<TextToSpeech> {
  late final TextEditingController controller;
  final player = AudioPlayer();
  bool _isLoadingVoice = false;

  //For the Text To Speech
  Future<void> playTextToSpeech(String text) async {
    setState(() => _isLoadingVoice = true);

    String voiceRachel = '21m00Tcm4TlvDq8ikWAM';

    String url = 'https://api.elevenlabs.io/v1/text-to-speech/$voiceRachel';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'accept': 'audio/mpeg',
        'xi-api-key': elApiKey,
        'Content-Type': 'application/json',
      },
      body: json.encode({
        "text": text,
        "model_id": "eleven_multilingual_v2",
        "voice_settings": {"stability": .15, "similarity_boost": .5}
      }),
    );

    setState(() => _isLoadingVoice = false);

    if (response.statusCode == 200) {
      final bytes = response.bodyBytes;
      await player.setAudioSource(MyCustomSource(bytes));
      player.play();
    } else {
      throw Exception('Failed to load audio');
      // return;
    }
  }

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.cyanAccent,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                lang.hear,
                style: const TextStyle(fontSize: 40),
              ),
            ),
            Center(
              child: SizedBox(
                width: 280,
                child: TextField(
                  maxLines: 12,
                  autocorrect: true,
                  controller: controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(
                        color: CupertinoColors.systemOrange,
                        width: 4,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                playTextToSpeech(controller.text);
              },
              icon: _isLoadingVoice
                  ? const SizedBox.square(
                      dimension: 120,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.transparent,
                        color: Colors.cyan,
                      ),
                    )
                  : Image.asset(width: 100, "assets/images/speaker.png"),
            ),
          ],
        ),
      ),
    );
  }
}

// Feed your own stream of bytes into the player
class MyCustomSource extends StreamAudioSource {
  final List<int> bytes;

  MyCustomSource(this.bytes);

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    start ??= 0;
    end ??= bytes.length;
    return StreamAudioResponse(
      sourceLength: bytes.length,
      contentLength: end - start,
      offset: start,
      stream: Stream.value(bytes.sublist(start, end)),
      contentType: 'audio/mpeg',
    );
  }
}
