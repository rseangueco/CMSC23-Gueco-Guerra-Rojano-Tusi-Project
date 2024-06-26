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
    apiKey: 'AIzaSyCbN8TvtWxETIp_MNXi5-1tLdXUFZmnkhs',
    appId: '1:730135025359:web:26439c2567f41a058189ba',
    messagingSenderId: '730135025359',
    projectId: 'cmsc23-elbi-donation-system',
    authDomain: 'cmsc23-elbi-donation-system.firebaseapp.com',
    storageBucket: 'cmsc23-elbi-donation-system.appspot.com',
    measurementId: 'G-MKNLHT4TSE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAK5QRyJVnTH7lU6nPc7RxV7-NhPfJOTKU',
    appId: '1:730135025359:android:46812ce2878d68838189ba',
    messagingSenderId: '730135025359',
    projectId: 'cmsc23-elbi-donation-system',
    storageBucket: 'cmsc23-elbi-donation-system.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCdAga53K_t4TOZEhfV_tzaYrQGg37J-kA',
    appId: '1:730135025359:ios:5a87d401990a23288189ba',
    messagingSenderId: '730135025359',
    projectId: 'cmsc23-elbi-donation-system',
    storageBucket: 'cmsc23-elbi-donation-system.appspot.com',
    iosBundleId: 'com.example.cmsc23Project',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCdAga53K_t4TOZEhfV_tzaYrQGg37J-kA',
    appId: '1:730135025359:ios:5a87d401990a23288189ba',
    messagingSenderId: '730135025359',
    projectId: 'cmsc23-elbi-donation-system',
    storageBucket: 'cmsc23-elbi-donation-system.appspot.com',
    iosBundleId: 'com.example.cmsc23Project',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCbN8TvtWxETIp_MNXi5-1tLdXUFZmnkhs',
    appId: '1:730135025359:web:f6c522b5fa1f779c8189ba',
    messagingSenderId: '730135025359',
    projectId: 'cmsc23-elbi-donation-system',
    authDomain: 'cmsc23-elbi-donation-system.firebaseapp.com',
    storageBucket: 'cmsc23-elbi-donation-system.appspot.com',
    measurementId: 'G-EBBPPM5S2B',
  );
}
