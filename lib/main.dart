import 'package:bridgepath/blocs/access_bloc.dart';
import 'package:bridgepath/blocs/home_page_bloc.dart';
import 'package:bridgepath/pages/access_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const firebaseConfig = FirebaseOptions(
    apiKey: "AIzaSyAVyFKj4pFlvfZ3Lrdh5mI5mZo2AzeDrtE",
    authDomain: "bridgepathapp.firebaseapp.com",
    projectId: "bridgepathapp",
    storageBucket: "bridgepathapp.appspot.com",
    messagingSenderId: "416848631100",
    appId: "1:416848631100:web:9f123c4179041709e57a39",
  );
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: firebaseConfig,
    );
  } else {
    await Firebase.initializeApp();
  }

  // setupGetIt();
  runApp(const BridgePathApp());
}

class BridgePathApp extends StatelessWidget {
  const BridgePathApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AccessBloc()..add(Authenticate()),
          // s..add(Authenticate()),
        ),
        BlocProvider(
          create: (context) => HomePageBloc()..add(InitialiazeHomePageData()),
          // s..add(Authenticate()),
        ),
      ],
      child: MaterialApp(
        title: 'BridgePath',
        theme: ThemeData(
            primarySwatch: Colors.green,
            appBarTheme: AppBarTheme(
                backgroundColor: Colors.white, foregroundColor: Colors.black)),
        home: const AccessPage(),
      ),
    );
  }
}
