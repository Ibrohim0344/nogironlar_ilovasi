import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app/app.dart';
import 'config/key/api_key.dart';

String EL_API_KEY = dotenv.env['EL_API_KEY'] as String;

String elApiKey = ApiKey().key;

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  runApp(const App());
}
