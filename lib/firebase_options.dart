// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyC8DC-lEJ4X9Fu9-iPQAkySVHSeS6hwotQ',
    appId: '1:969475656006:web:3d87c71706807356267d47',
    messagingSenderId: '969475656006',
    projectId: 'fir-auth-66502',
    authDomain: 'fir-auth-66502.firebaseapp.com',
    storageBucket: 'fir-auth-66502.firebasestorage.app',
    measurementId: 'G-KVRN3XSRG3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA437iye2d1ayReHbjRrPuN2bYVP-s-oTI',
    appId: '1:969475656006:android:cf4af39dea828656267d47',
    messagingSenderId: '969475656006',
    projectId: 'fir-auth-66502',
    storageBucket: 'fir-auth-66502.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCJDmy2e6FVnI82oX0vzmEMJcKp_dhXy-U',
    appId: '1:969475656006:ios:4654d36772d6a455267d47',
    messagingSenderId: '969475656006',
    projectId: 'fir-auth-66502',
    storageBucket: 'fir-auth-66502.firebasestorage.app',
    iosBundleId: 'com.example.toDoListAndroid',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCJDmy2e6FVnI82oX0vzmEMJcKp_dhXy-U',
    appId: '1:969475656006:ios:4654d36772d6a455267d47',
    messagingSenderId: '969475656006',
    projectId: 'fir-auth-66502',
    storageBucket: 'fir-auth-66502.firebasestorage.app',
    iosBundleId: 'com.example.toDoListAndroid',
  );
}