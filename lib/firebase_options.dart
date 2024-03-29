// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBaPrseyvL__09vTF2Wefh8qjEevj6SRiQ',
    appId: '1:13253561335:web:74a0b4b86ebf6884c07cf2',
    messagingSenderId: '13253561335',
    projectId: 'sds-todo',
    authDomain: 'sds-todo.firebaseapp.com',
    storageBucket: 'sds-todo.appspot.com',
    measurementId: 'G-TRGJEMKCD8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDzJX2FaSmtmrV_ihJTMfFwT-vs_DjwWv8',
    appId: '1:13253561335:android:129b8306395718bfc07cf2',
    messagingSenderId: '13253561335',
    projectId: 'sds-todo',
    storageBucket: 'sds-todo.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCPeb2KQN05qEhK7v6kLODkEwz6hko1zLA',
    appId: '1:13253561335:ios:babe386f3f262a47c07cf2',
    messagingSenderId: '13253561335',
    projectId: 'sds-todo',
    storageBucket: 'sds-todo.appspot.com',
    iosBundleId: 'com.sds.sdstodo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCPeb2KQN05qEhK7v6kLODkEwz6hko1zLA',
    appId: '1:13253561335:ios:fa8bd234218dac00c07cf2',
    messagingSenderId: '13253561335',
    projectId: 'sds-todo',
    storageBucket: 'sds-todo.appspot.com',
    iosBundleId: 'com.example.todo.RunnerTests',
  );
}
