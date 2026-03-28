import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'auth/splash_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyC8J3UJQaXEHY4NWAYUWvBfVhzJeJmuIko",
        authDomain: "fir-setup-3b87c.firebaseapp.com",
        databaseURL: "https://fir-setup-3b87c-default-rtdb.firebaseio.com",
        projectId: "fir-setup-3b87c",
        storageBucket: "fir-setup-3b87c.firebasestorage.app",
        messagingSenderId: "760227373571",
        appId: "1:760227373571:web:5d783713e3e712a221e436",
      ),
    );
  } else {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyC4FKaUSbtz6OrS_jMUAV8TZ3AQ7mMeieg",
        appId: "1:760227373571:android:acace7bb8af9a04c21e436",
        messagingSenderId: "",
        projectId: "fir-setup-3b87c",
      ),
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: SplashPage(),
    );
  }
}
