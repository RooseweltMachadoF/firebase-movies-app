import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_movies_app/firebase_options.dart';

class FirebaseService {
  static final FirebaseService _singleton = FirebaseService._internal();

  factory FirebaseService() {
    return _singleton;
  }
  
  FirebaseService._internal();

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    final firebaseApp = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseFirestore.instanceFor(app: firebaseApp);
  }
}
