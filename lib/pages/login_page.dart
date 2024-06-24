import 'package:chat_app/constants.dart';
import 'package:chat_app/cubit/loginCubit/log_in_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/pages/resgister_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'chat_page.dart';

class LogInScreen extends StatelessWidget {
  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();
  static String id = 'login page';

  String? email, password;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: BlocConsumer<LogInCubit, LogInState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: kPrimaryColor,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 75,
                    ),
                    Image.asset(
                      'assets/images/scholar.png',
                      height: 100,
                    ),
                    const Center(
                      child: Text(
                        'Scholar Chat',
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontFamily: 'pacifico',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 75,
                    ),
                    const Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomFormTextField(
                      onChanged: (data) {
                        email = data;
                      },
                      hintText: 'Email',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomFormTextField(
                      obscureText: true,
                      onChanged: (data) {
                        password = data;
                      },
                      hintText: 'Password',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButon(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          isLoading = true;
                          try {
                            await context
                                .read<LogInCubit>()
                                .loginUser(email: email!, password: password!);
                            // ignore: use_build_context_synchronously
                            Navigator.pushNamed(context, ChatPage.id,
                                arguments: email);
                          } on FirebaseAuthException catch (ex) {
                            if (ex.code == 'user-not-found') {
                              // ignore: use_build_context_synchronously
                              showSnackBar(context, 'user not found');
                            } else if (ex.code == 'wrong-password') {
                              // ignore: use_build_context_synchronously
                              showSnackBar(context, 'wrong password');
                            }
                          } catch (ex) {
                            if (kDebugMode) {
                              print(ex);
                            }
                            // ignore: use_build_context_synchronously
                            showSnackBar(context, 'there was an error');
                          }

                          isLoading = false;
                        } else {}
                      },
                      text: 'LOGIN',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'dont\'t have an account?',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, RegisterPage.id);
                          },
                          child: const Text(
                            '  Register',
                            style: TextStyle(
                              color: Color(0xffC7EDE6),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
