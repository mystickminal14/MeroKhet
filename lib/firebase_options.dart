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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyD7wcVFZyAsjY9zORT3UXABN9tRuNTb3c4',
    appId: '1:526358611163:web:2e322c8d50497ed5cbb8fe',
    messagingSenderId: '526358611163',
    projectId: 'mero-khet-c531d',
    authDomain: 'mero-khet-c531d.firebaseapp.com',
    storageBucket: 'mero-khet-c531d.firebasestorage.app',
    measurementId: 'G-S7YPRZ7X19',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCJx8lkLraWKJzbYv-cTlJCanktdXBC6K8',
    appId: '1:526358611163:android:4dbd67804a82b1f0cbb8fe',
    messagingSenderId: '526358611163',
    projectId: 'mero-khet-c531d',
    storageBucket: 'mero-khet-c531d.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBJOYh-SIYTid3-0ckOM85nPfTIiIQsuy0',
    appId: '1:526358611163:ios:b23a595733a45062cbb8fe',
    messagingSenderId: '526358611163',
    projectId: 'mero-khet-c531d',
    storageBucket: 'mero-khet-c531d.firebasestorage.app',
    iosBundleId: 'com.example.merokhetapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD7wcVFZyAsjY9zORT3UXABN9tRuNTb3c4',
    appId: '1:526358611163:web:05b1e65cb4c1c882cbb8fe',
    messagingSenderId: '526358611163',
    projectId: 'mero-khet-c531d',
    authDomain: 'mero-khet-c531d.firebaseapp.com',
    storageBucket: 'mero-khet-c531d.firebasestorage.app',
    measurementId: 'G-RN18RY0KMS',
  );

}