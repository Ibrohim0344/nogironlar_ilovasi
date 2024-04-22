import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nogironlar_ilovasi/features/widgets/main_button.dart';

import '../../service/l10n/app_localizations.dart';

class PictureToText extends StatefulWidget {
  const PictureToText({super.key});

  @override
  State<PictureToText> createState() => _PictureToTextState();
}

class _PictureToTextState extends State<PictureToText> {
  File? _image;

  Future getPicture() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
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
              child: const ColoredBox(color: Colors.cyanAccent),
            ),
            SizedBox(height: size.height * .01),
            MainButton(
              lang.scanImage,
              onPressed: getPicture,
            ),
            SizedBox(height: size.height * .015),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MainButton(
                  lang.voice,
                  width: size.width / 3,
                  onPressed: () {},
                ),
                MainButton(
                  lang.share,
                  width: size.width / 3,
                  onPressed: () {},
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
