import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/screens/sign_up.dart';
import 'package:firebase_practice/widgets/globals/custom_text_field.dart';
import 'package:firebase_practice/widgets/globals/google_btn.dart';
import 'package:firebase_practice/widgets/globals/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_practice/widgets/globals/extension.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _loginUser(context) async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        snackBar("Logged In Successfully", Colors.green, context);
        // final credential = EmailAuthProvider.credential(
        //     email: _emailController.text, password: _passwordController.text);
        // final userCredential = await FirebaseAuth.instance.currentUser
        //     ?.linkWithCredential(credential);
        // snackBar("Linked Successfully", Colors.green, context);

      } on FirebaseAuthException catch (e) {
        snackBar(e.message, Colors.red, context);
      } catch (e) {
        snackBar(e.toString(), Colors.red, context);
      }
    }
  }

  Future<void> _loginUserWithPhone(context) async {
    // if (_formKey.currentState!.validate()) {
    try {
      // await FirebaseAuth.instance.verifyPhoneNumber(
      //   phoneNumber: _phoneController.text,
      //   verificationCompleted: (PhoneAuthCredential credential) async {
      //     await FirebaseAuth.instance.signInWithCredential(credential);
      //     snackBar("Sign In Successfully", Colors.green, context);
      //   },
      //   verificationFailed: (FirebaseAuthException e) {
      //     snackBar(e.message, Colors.red, context);
      //   },
      //   codeSent: (String verificationId, int? resendToken) async {
      //     inspect(verificationId);
      //     inspect(resendToken);
      //     PhoneAuthCredential credential = PhoneAuthProvider.credential(
      //         verificationId: verificationId, smsCode: "1234");

      //     // Sign the user in (or link) with the credential
      //     await FirebaseAuth.instance.signInWithCredential(credential);
      //   },
      //   codeAutoRetrievalTimeout: (String verificationId) {
      //     inspect("Auto Retr");
      //     inspect(verificationId);
      //     // snackBar(e.message, Colors.red, context);
      //   },
      // );

      // inspect(FirebaseAuth.instance.currentUser);
      // await FirebaseAuth.instance
      //     .sendPasswordResetEmail(email: "maazkhan580@gmail.com");
      var credential = EmailAuthProvider.credential(
          email: _emailController.text, password: _passwordController.text);
      var user = FirebaseAuth.instance.currentUser;
      user?.reauthenticateWithCredential(credential);
      await user?.sendEmailVerification();
      snackBar("Success", Colors.green, context);
    } on FirebaseAuthException catch (e) {
      snackBar(e.message, Colors.red, context);
    } catch (e) {
      snackBar(e.toString(), Colors.red, context);
    }
    // }
  }

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Email Address is required";
    } else if (!value.isValidEmail()) {
      return "Invalid Email Address";
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    } else if (value.length < 8) {
      return "Password must be atleast 8 characters long";
    }
    return null;
  }

  String? _phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone Number is required";
    } else if (value.length < 11) {
      return "Invalid Phone Number";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: GoogleButton(
                    text: "Login With Google",
                    width: MediaQuery.of(context).size.width * 0.8,
                    bottomMargin: 20,
                    height: 55,
                  ),
                ),
                // Container(
                //   width: MediaQuery.of(context).size.width,
                //   alignment: Alignment.center,
                //   child: FacebookButton(
                //     text: "Login With Facebook",
                //     width: MediaQuery.of(context).size.width * 0.8,
                //     bottomMargin: 20,
                //     height: 55,
                //   ),
                // ),

                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: CustomTextField(
                    textController: _emailController,
                    width: MediaQuery.of(context).size.width * 0.8,
                    hintText: "Enter Email",
                    keyboardType: TextInputType.emailAddress,
                    prefix: const Icon(Icons.email),
                    bottomMargin: 20,
                    validationMethod: _emailValidator,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: CustomTextField(
                    textController: _passwordController,
                    width: MediaQuery.of(context).size.width * 0.8,
                    hintText: "Enter Password",
                    isPassword: true,
                    prefix: const Icon(Icons.lock),
                    bottomMargin: 20,
                    validationMethod: _passwordValidator,
                  ),
                ),

                ElevatedButton(
                    onPressed: () => _loginUser(context), child: Text("Login")),

                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: CustomTextField(
                    textController: _phoneController,
                    width: MediaQuery.of(context).size.width * 0.8,
                    hintText: "Enter Phone Number",
                    keyboardType: TextInputType.phone,
                    prefix: const Icon(Icons.phone),
                    bottomMargin: 20,
                    validationMethod: _phoneValidator,
                  ),
                ),

                ElevatedButton(
                    onPressed: () => _loginUserWithPhone(context),
                    child: Text("Login With Phone")),

                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SignUp(),
                      ));
                    },
                    child: const Text("Go To Sign Up")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
