import 'package:firebase_cli/core/caches/prefs_keys.dart';
import 'package:firebase_cli/core/caches/shared_prefs.dart';
import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:flutter/material.dart';
import 'app.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
  );
  await AppSharedPrefs.init();
  print("user Id ===> ${AppSharedPrefs.getString(key: SharedPrefsKeys.userId)}");
  runApp(MyApp());
}






