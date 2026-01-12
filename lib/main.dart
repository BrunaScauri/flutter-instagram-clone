import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:provider/provider.dart';

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
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram Clone',
        theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: mobileBackgroundColor),

        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          //updates if and only if the user is logged in/out.
          //.idTokenChanges() or userChanges() can also be used.
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.active) {
              if(snapshot.hasData) {
                return const ResponsiveLayout(
                    mobileScreenLayout: MobileScreenLayout(),
                    webScreenLayout: WebScreenLayout()
                );
              } else if(snapshot.hasError) {
                return Center(child: Text('$snapshot.error'));
              }
            }
            if(snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: primaryColor));
            }

            return const LoginScreen();
          }
        )
    );
  }
}