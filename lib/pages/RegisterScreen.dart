import 'package:chat_app/custom/CustomSubmitcontainer.dart';
import 'package:chat_app/custom/CustomTextFiled.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? email, password;

  bool isloading = false;

  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
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
                      'Register',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextFiled(
                  hintTextFiled: 'Email',
                  onChange: (data) {
                    email = data;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                CustomTextFiled(
                  hintTextFiled: 'Password',
                  onChange: (data) {
                    password = data;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 40,
                ),
                GestureDetector(
                    onTap: () async {
                      if (formkey.currentState!.validate()) {
                        isloading = true;
                        setState(() {});
                        try {
                          await registeruser();
                          showSnackBar(context, 'sucsses');
                          Navigator.pop(context);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'week-password') {
                            showSnackBar(context, 'week password');
                          } else if (e.code == 'email-already-in-use') {
                            showSnackBar(context,
                                'the account is already exists this email');
                          }
                        } catch (e) {
                          showSnackBar(context, 'there was an erorr');
                        }
                        isloading = false;
                        setState(() {});
                      } else {}
                      //Navigator.pop(context);
                    },
                    child: CustomSubmitcontainer(sumbitText: 'Register')),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showSnackBar(BuildContext context, String massage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(massage),
      ),
    );
  }

  Future<void> registeruser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
