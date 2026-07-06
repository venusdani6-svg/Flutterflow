import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDz9yCrJvqa-oCXGaje_2bh11_R8vm6IC8",
            authDomain: "icoccha-admin-dashboard.firebaseapp.com",
            projectId: "icoccha-admin-dashboard",
            storageBucket: "icoccha-admin-dashboard.firebasestorage.app",
            messagingSenderId: "238378389288",
            appId: "1:238378389288:web:b3b00d1ac8dafb65cc8a1d"));
  } else {
    await Firebase.initializeApp();
  }
}
