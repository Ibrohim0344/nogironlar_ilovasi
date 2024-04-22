import 'package:flutter/material.dart';
import 'package:nogironlar_ilovasi/service/controller/app_model.dart';
import 'package:provider/provider.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  void changeAppLanguage(String newLocale) {
    context.read<AppModel>().changeAppLanguage(newLocale);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        surfaceTintColor: Colors.blue.shade50,
        backgroundColor: Colors.blue.shade50,
        leadingWidth: 80,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back,
            size: 50,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const Center(
              child: Text(
                "LANGUAGE",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 40),
              ),
            ),
            const SizedBox(height: 20),

            /// us
            IconButton(
              onPressed: () => changeAppLanguage("en"),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              )),
              icon: SizedBox(
                width: 270,
                child: Image.asset(
                  "assets/images/use.JPG",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),

            /// ru
            IconButton(
              onPressed: () => changeAppLanguage("ru"),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              )),
              icon: SizedBox(
                width: 270,
                child: Image.asset(
                  "assets/images/russian.webp",
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// uz
            IconButton(
              onPressed: () => changeAppLanguage("uz"),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              )),
              icon: SizedBox(
                width: 270,
                child: Image.asset(
                  "assets/images/uzb.webp",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
