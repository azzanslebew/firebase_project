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
    apiKey: 'AIzaSyAq6lx2TS7_QGNimCsV8fbRgrZmcpn4L1A',
    appId: '1:142973999518:web:f04aca16d939620e521e8f',
    messagingSenderId: '142973999518',
    projectId: 'fir-project-195c6',
    authDomain: 'fir-project-195c6.firebaseapp.com',
    storageBucket: 'fir-project-195c6.firebasestorage.app',
    measurementId: 'G-BZS7YL0DEY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBzk_WKv7BzhOj40hJPmfUX5GnbCQ9BZxI',
    appId: '1:142973999518:android:9e4cf1966d1a114d521e8f',
    messagingSenderId: '142973999518',
    projectId: 'fir-project-195c6',
    storageBucket: 'fir-project-195c6.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDIm23zUTEbfgrVe4-ybT4tEMCgMfizA74',
    appId: '1:142973999518:ios:fc86dc77a5ae66b9521e8f',
    messagingSenderId: '142973999518',
    projectId: 'fir-project-195c6',
    storageBucket: 'fir-project-195c6.firebasestorage.app',
    iosClientId: '142973999518-4ue3v5nliea830ptrj9gtj04vlqs9pv3.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterFirebaseProject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDIm23zUTEbfgrVe4-ybT4tEMCgMfizA74',
    appId: '1:142973999518:ios:fc86dc77a5ae66b9521e8f',
    messagingSenderId: '142973999518',
    projectId: 'fir-project-195c6',
    storageBucket: 'fir-project-195c6.firebasestorage.app',
    iosClientId: '142973999518-4ue3v5nliea830ptrj9gtj04vlqs9pv3.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterFirebaseProject',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAq6lx2TS7_QGNimCsV8fbRgrZmcpn4L1A',
    appId: '1:142973999518:web:b29ecb1e67167151521e8f',
    messagingSenderId: '142973999518',
    projectId: 'fir-project-195c6',
    authDomain: 'fir-project-195c6.firebaseapp.com',
    storageBucket: 'fir-project-195c6.firebasestorage.app',
    measurementId: 'G-FGCQTGSE31',
  );
}
