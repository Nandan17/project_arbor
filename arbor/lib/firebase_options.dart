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
        return ios;
      case TargetPlatform.macOS:
        return macos;
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAi-yufrHJfzq-NS_t80Z2u_mmilfRmIgM',
    appId: '1:374331403096:web:c1e945daf0c04b5c53932d',
    messagingSenderId: '374331403096',
    projectId: 'flutter-arbor-project',
    authDomain: 'flutter-arbor-project.firebaseapp.com',
    storageBucket: 'flutter-arbor-project.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC0hIsvco0SHwD6r9g1OqGhtgz6WRcDDW8',
    appId: '1:374331403096:android:65eacbc2bb08d1a953932d',
    messagingSenderId: '374331403096',
    projectId: 'flutter-arbor-project',
    storageBucket: 'flutter-arbor-project.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCLqjDmbnfWGj3QkMDERNh7rzM9fOcD-EQ',
    appId: '1:374331403096:ios:04e7dbae1bef41c553932d',
    messagingSenderId: '374331403096',
    projectId: 'flutter-arbor-project',
    storageBucket: 'flutter-arbor-project.appspot.com',
    iosClientId: '374331403096-lt8vt0ft1uaenct9npntdhrqlv87drfi.apps.googleusercontent.com',
    iosBundleId: 'com.kurama',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCLqjDmbnfWGj3QkMDERNh7rzM9fOcD-EQ',
    appId: '1:374331403096:ios:04e7dbae1bef41c553932d',
    messagingSenderId: '374331403096',
    projectId: 'flutter-arbor-project',
    storageBucket: 'flutter-arbor-project.appspot.com',
    iosClientId: '374331403096-lt8vt0ft1uaenct9npntdhrqlv87drfi.apps.googleusercontent.com',
    iosBundleId: 'com.kurama',
  );
}
