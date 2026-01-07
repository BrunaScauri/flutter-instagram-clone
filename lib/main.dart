import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/components/logo_banner.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/screens/sign_up_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyAbXRDSiOAWdS53Z-NIlzGQowyfcElNLPU',
      appId: '1:387342447877:android:c577a37efcdb010a90b36c',
      messagingSenderId: '387342447877',
      projectId: 'instagram-clone-39e3f'
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
        // home: const ResponsiveLayout(
        //     mobileScreenLayout: MobileScreenLayout(),
        //     webScreenLayout: WebScreenLayout()
        // ),
        home: const LoginScreen()
    );
  }
}