import 'package:chat_app/custom/CustomSubmitcontainer.dart';
import 'package:chat_app/custom/CustomTextFiled.dart';
import 'package:chat_app/pages/ChatScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LogInScreen extends StatefulWidget {
  LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool isLoading = false;
  String? email, password;

  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: Color(0xff2B475E),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formkey,
            child: ListView(
              children: [
                SizedBox(
                  height: 10,
                ),
                Image.asset(
                  'assets/images/scholar.png',
                  height: 200,
                ),
                Center(
                  child: Text(
                    'Scolar Chat',
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Text(
                      'Log_In',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextFiled(
                  hintTextFiled: 'Email',
                  onChange: (data) {
                    email = data;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextFiled(
                  hintTextFiled: 'PassWord',
                  onChange: (data) {
                    password = data;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () async {
                    if (formkey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await LogInAuth();
                        Navigator.pushNamed(context, ChatAppScreen().id);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          showSnackBar(context, 'user not found');
                        } else if (e.code == 'wrong-password') {
                          showSnackBar(context, 'wrong password');
                        }
                      } catch (e) {
                        showSnackBar(context, 'there was an erorr');
                      }
                      isLoading = false;
                      setState(() {});
                    } else {}
                    //Navigator.pop(context);
                  },
                  child: CustomSubmitcontainer(sumbitText: 'LogIn'),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "don't have an acount?! ",
                      style: TextStyle(fontSize: 19),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'RegisterPage');
                      },
                      child: Text(
                        "    Register",
                        style: TextStyle(color: Colors.blueGrey, fontSize: 19),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> LogInAuth() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }

  void showSnackBar(BuildContext context, String massage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(massage),
      ),
    );
  }
}
