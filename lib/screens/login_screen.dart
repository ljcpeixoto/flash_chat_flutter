import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_flutter/components/round_button.dart';
import 'package:flash_chat_flutter/constants.dart';
import 'package:flash_chat_flutter/screens/chat_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login';

  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Container(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            const SizedBox(
              height: 48.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                email = value;
              },
              decoration: kTextInputFieldDecoration.copyWith(
                  hintText: 'Enter your email'),
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextField(
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                password = value;
              },
              decoration: kTextInputFieldDecoration.copyWith(
                  hintText: 'Enter your password.'),
            ),
            const SizedBox(
              height: 24.0,
            ),
            RoundButton(
              text: 'Log In',
              color: Colors.lightBlueAccent,
              onPressed: () async {
                if (email != null && password != null) {
                  try {
                    final UserCredential credential =
                        await _auth.signInWithEmailAndPassword(
                            email: email!, password: password!);
                    if (credential.user != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                  } on Exception catch (e) {
                    print(e);
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
