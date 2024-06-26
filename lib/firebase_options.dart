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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBq6CWLNiAnX2nna7kAVh0m4FXNkdQtfPk',
    appId: '1:558644503541:android:89da416710baa604ef76bc',
    messagingSenderId: '558644503541',
    projectId: 'maarvel-enterprises',
    databaseURL: 'https://maarvel-enterprises-default-rtdb.firebaseio.com',
    storageBucket: 'maarvel-enterprises.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAY8n_yxGYOtX-nhH0cm_PAQC9qOGfDUgc',
    appId: '1:558644503541:ios:c2a6e62e7642cc3bef76bc',
    messagingSenderId: '558644503541',
    projectId: 'maarvel-enterprises',
    databaseURL: 'https://maarvel-enterprises-default-rtdb.firebaseio.com',
    storageBucket: 'maarvel-enterprises.appspot.com',
    androidClientId: '558644503541-8enufdq0p7thc3g096q1j9i95md9gm92.apps.googleusercontent.com',
    iosClientId: '558644503541-4g8qeq1jai302ngu7i079dnp4tfnfp1v.apps.googleusercontent.com',
    iosBundleId: 'com.example.maarvele',
  );
}
