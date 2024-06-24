import 'package:chat_app/cubit/loginCubit/log_in_cubit.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/resgister_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ChatApp(),
  );
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogInCubit(),
      child: MaterialApp(
        routes: {
          'LoginPage': (context) => LogInScreen(),
          'RegisterPage': (context) => RegisterPage(),
          'ChatPage': (context) => ChatPage(),
        },
        initialRoute: 'LoginBage',
        home: LogInScreen(),
      ),
    );
  }
}
