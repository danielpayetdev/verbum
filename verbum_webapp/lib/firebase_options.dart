// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCRlbck0QT5tPRuK_Lm7nRIHbYjBMTADP8',
    appId: '1:13907170141:web:3f0948b19f1f36d4da8eb4',
    messagingSenderId: '13907170141',
    projectId: 'verbum-d85c3',
    authDomain: 'verbum-d85c3.firebaseapp.com',
    databaseURL: 'https://verbum-d85c3-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'verbum-d85c3.appspot.com',
    measurementId: 'G-FDBB7M9MQ8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCJ3WGfPBe16vm5WAzeGtErpW_KetBkTKk',
    appId: '1:13907170141:android:64e231a5338aece0da8eb4',
    messagingSenderId: '13907170141',
    projectId: 'verbum-d85c3',
    databaseURL: 'https://verbum-d85c3-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'verbum-d85c3.appspot.com',
  );
}
