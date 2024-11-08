// Dart Library
import 'dart:async';

// Design Library
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// User Library
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Screen Library
import 'package:runner_g/main.dart';
import 'package:runner_g/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<void> _googleSignIn() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: dotenv.env['MOBILE_CLIENT_ID'],
      serverClientId: dotenv.env['WEB_CLIENT_ID'],
    );
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      throw 'Google sign-in aborted.';
    }

    final googleAuth = await googleUser.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    final AuthResponse response = await supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );

    if (response.session == null || response.user == null) {
      throw 'Failed to sign in with Supabase.';
    }

    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage('assets/icon/icon.png'),
            height: 200.0,
            width: 200.0,
          ),
          SizedBox(height: screenHeight*0.075),
          Text(
            '처음 오셨나요? 바로 회원가입하고 시작하세요.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            '다양한 사람들과 함께 러닝 기록을 공유해보세요.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(height: screenHeight*0.16),
          Center(child: LayoutBuilder(
            builder: (context, constraints) {
              return FractionallySizedBox(
                widthFactor: 0.9, // 너비를 화면의 90%로 설정
                child: ElevatedButton(
                  onPressed: _googleSignIn,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(48, 50), // 너비는 부모 크기만큼, 높이는 60으로 설정
                    backgroundColor: const Color.fromARGB(255, 64, 64, 64),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)
                    )
                  ),
                  child: const Text(
                    '접속하기',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    ),
                  ),
                ));
            },
          )),
          SizedBox(height: screenHeight*0.075),
        ],
      ),
    );
  }
}
