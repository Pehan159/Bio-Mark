import 'package:biomark/src/providers/auth_provider.dart';
import 'package:biomark/src/screens/profile_screen.dart';
import 'package:biomark/src/screens/profile_setup_screen.dart';
import 'package:biomark/src/screens/account_recovery_screen.dart';
import 'package:biomark/src/screens/login_screen.dart';
import 'package:biomark/src/screens/register_screen.dart';
import 'package:biomark/src/screens/reset_password_screen.dart';
import 'package:biomark/src/screens/unsubscribe_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => AuthsProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Biomark',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/',
        routes: {
          '/': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/login': (context) => LoginScreen(),
          '/profile_setup': (context) => ProfileSetupScreen(),
          '/acc_recovery': (context) => AccountRecoveryScreen(),
          '/reset_password': (context) => ResetPasswordScreen(),
          '/unsubscribe': (context) => UnsubscribeScreen(),
          '/profile': (context) => ProfileScreen(),
        },
        //home: RegisterScreen(),
      ),
    );
  }
}
