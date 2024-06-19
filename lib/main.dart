import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:runner_g/navigation/routes.dart';
import 'package:runner_g/screens/home_screen.dart';
import 'package:runner_g/screens/login_screen.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {  
    const login = false; 
    FlutterNativeSplash.remove();

    return MaterialApp(
      title: 'Runnger G',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: login ? Routes.homePath : Routes.loginPath,
      routes: {
        Routes.homePath: (context) => HomeScreen(),
        Routes.loginPath: (context) => LoginScreen(),
      }
    );
  }
}
