import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_audio/just_audio.dart';
import 'package:nogironlar_ilovasi/features/widgets/main_button.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';

import '../../main.dart';
import '../../service/l10n/app_localizations.dart';
import '../text_to_speech/text_to_speech_screen.dart';

class PictureToText extends StatefulWidget {
  const PictureToText({super.key});

  @override
  State<PictureToText> createState() => _PictureToTextState();
}

class _PictureToTextState extends State<PictureToText> {
  File? _image;
  String textFromPicture = "";
  final player = AudioPlayer();

  Future<void> pickPicture() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
    await readTextFromImage();
  }

  Future<void> readTextFromImage() async {
    final inputImage = InputImage.fromFile(_image!);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    textFromPicture = recognizedText.text;
    setState(() {});
    textRecognizer.close();
  }

  Future<void> playTextToSpeech(String text) async {
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
        "model_id": "eleven_monolingual_v1",
        "voice_settings": {"stability": .15, "similarity_boost": .5}
      }),
    );

    if (response.statusCode == 200) {
      final bytes = response.bodyBytes;
      await player.setAudioSource(MyCustomSource(bytes));
      player.play();
    } else {
      throw Exception('Failed to load audio');
      // return;
    }
  }

  void shareText(String text) => Share.share(text);

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                lang.see,
                style: const TextStyle(fontSize: 40),
              ),
            ),
            SizedBox(
              width: 300,
              height: size.height / 4,
              child: ColoredBox(
                color: Colors.cyanAccent,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: Text(textFromPicture),
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * .01),
            MainButton(
              lang.scanImage,
              onPressed: pickPicture,
            ),
            SizedBox(height: size.height * .015),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MainButton(
                  lang.voice,
                  width: size.width / 3,
                  onPressed: () => playTextToSpeech(textFromPicture),
                ),
                MainButton(
                  lang.share,
                  width: size.width / 3,
                  onPressed: () => shareText(textFromPicture),
                ),
              ],
            ),
            SizedBox(height: size.height * .015),
            _image != null
                ? Expanded(
                    child: Image(
                      image: FileImage(_image!),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
