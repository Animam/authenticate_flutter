import 'package:authenticate_flutter/reuasable_widget/reuseable_widget.dart';
import 'package:authenticate_flutter/screens/home.dart';
import 'package:authenticate_flutter/screens/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignInPage()),
                      );
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                ],
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 100),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Sign Up',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          reuseable_widget("Enter Username", Icons.person,
                              false, usernameController),
                          const SizedBox(
                            height: 30,
                          ),
                          reuseable_widget("Enter phone num", Icons.call, false,
                              phoneController),
                          const SizedBox(
                            height: 30,
                          ),
                          reuseable_widget("Enter Password", Icons.lock, true,
                              passwordController),
                          const SizedBox(
                            height: 30,
                          ),
                          signInSignUpButton(context, false, () async {
                            await FirebaseAuth.instance
                                .verifyPhoneNumber(
                                    phoneNumber: phoneController.text,
                                    verificationCompleted:
                                        (phoneAuthCredential) {},
                                    verificationFailed:
                                        (firebaseAuthException) {},
                                    codeSent: (String verificationId,
                                        int? resendToken) {},
                                    codeAutoRetrievalTimeout:
                                        (String verificationId) {})
                                .then((value) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignInPage()));
                            }).onError((error, stackTrace) {
                              print('Error ${error.toString()}');
                            });
                          })
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
