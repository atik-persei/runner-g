// Dart Library
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Design Library
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

// User Library
import 'package:runner_g/utils/supabase_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Screen Library
import 'package:runner_g/screens/home_screen.dart';
import 'package:runner_g/screens/login_screen.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await dotenv.load(fileName: ".env");
  await SupabaseManager.init();
  runApp(const App());
}

final supabase = Supabase.instance.client;

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    final session = Supabase.instance.client.auth.currentSession;
    FlutterNativeSplash.remove();

    return MaterialApp(
      title: 'Runnger G',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: session != null ? const HomeScreen() : const LoginScreen(),
    );
  }
}
