import 'package:firebase_authentication/controllers/auth_controller.dart';
import 'package:firebase_authentication/views/forgot_password.dart';
import 'package:firebase_authentication/views/home_page.dart';
import 'package:firebase_authentication/views/login_page.dart';
import 'package:firebase_authentication/views/phone_login.dart';
import 'package:firebase_authentication/views/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) => AuthController()
          )
        ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.blue
      ),
      initialRoute: '/loginPage',
      routes: {
        '/loginPage': (context) => const LoginPage(),
        '/signupPage': (context) => const SignupPage(),
        '/forgotPassword': (context) => const ForgotPassword(),
        '/phoneLogin': (context) => const PhoneLogin(),
        '/homePage': (context) => const HomePage(),
      },
    );
  }
}
