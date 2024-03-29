import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/pages/ChatScreen.dart';
import 'package:chat_app/pages/LogInScreen.dart';
import 'package:chat_app/pages/RegisterScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChatApp(),
  );
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'LoginPage': (context) => LogInScreen(),
        'RegisterPage': (context) => RegisterScreen(),
        ChatAppScreen().id: (context) => ChatAppScreen(),
      },
      initialRoute: 'LoginBage',
      home: ChatAppScreen(),
    );
  }
}
