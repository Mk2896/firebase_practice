import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/widgets/globals/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class GoogleButton extends StatelessWidget {
  const GoogleButton(
      {Key? key,
      required this.text,
      this.bottomMargin,
      this.topMargin,
      this.rightMargin,
      this.leftMargin,
      this.height,
      this.width})
      : super(key: key);
  final double? leftMargin;
  final double? rightMargin;
  final double? topMargin;
  final double? bottomMargin;
  final double? width;
  final double? height;
  final String text;

  Future<void> signInWithGoogle(context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential userCredentials =
          await FirebaseAuth.instance.signInWithCredential(credential);
      inspect(userCredentials);
      snackBar("Logged In Successfully", Colors.green, context);
    } on FirebaseAuthException catch (e) {
      snackBar(e.message, Colors.red, context);
    } catch (e) {
      snackBar(e.toString(), Colors.orange, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: leftMargin ?? 0,
        right: rightMargin ?? 0,
        top: topMargin ?? 0,
        bottom: bottomMargin ?? 0,
      ),
      width: width ?? MediaQuery.of(context).size.width,
      height: height,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
        ),
        onPressed: () => signInWithGoogle(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 30,
              child: Image(image: AssetImage("assets/images/google_logo.png")),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                text,
                style: const TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 20,
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
