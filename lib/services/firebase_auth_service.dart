import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../screens/otp_verification.dart';

class Auth {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> handleSignInEmail(
      context, String email, String password) async {
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      final User user = result.user!;
      return user;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  Future<User?> handleSignUp(context, email, password) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final User user = result.user!;
      return user;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  Future registerUserWithOTP(String mobile, BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    auth.verifyPhoneNumber(
      phoneNumber: "+91$mobile",
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) {
        if (kDebugMode) {
          print("phone authentication success");
        }
      },
      verificationFailed: (error) {
        if (kDebugMode) {
          print("error occur");
        }
      },
      codeSent: (String verificationId, forceResendingToken) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("code send successfully")));
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OTPVerification(
                verificationid: verificationId,
              ),
            ));
      },
      codeAutoRetrievalTimeout: (verificationId) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("$verificationId resend otp successfully")));
      },
    );
  }
}
