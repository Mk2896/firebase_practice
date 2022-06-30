import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/widgets/globals/custom_text_field.dart';
import 'package:firebase_practice/widgets/globals/extension.dart';
import 'package:firebase_practice/widgets/globals/google_btn.dart';
import 'package:firebase_practice/widgets/globals/snackbar.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _registerUser(context) async {
    if (_formKey.currentState!.validate()) {
      try {
        final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        final credentials = FirebaseAuth.instance.currentUser;
        credentials?.updateDisplayName(_nameController.text);
        snackBar("Registered Successfully", Colors.green, context);
      } on FirebaseAuthException catch (e) {
        snackBar(e.message, Colors.red, context);
      } catch (e) {
        snackBar(e.toString(), Colors.red, context);
      }
    }
  }

  String? _nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Name is required";
    }
    return null;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up Page"),
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
                    text: "Signup With Google",
                    width: MediaQuery.of(context).size.width * 0.8,
                    bottomMargin: 20,
                    height: 55,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: CustomTextField(
                    textController: _nameController,
                    width: MediaQuery.of(context).size.width * 0.8,
                    hintText: "Enter Name",
                    prefix: const Icon(Icons.person),
                    bottomMargin: 20,
                    validationMethod: _nameValidator,
                  ),
                ),
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
                    onPressed: () => _registerUser(context),
                    child: Text("Register")),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Go To Login")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
