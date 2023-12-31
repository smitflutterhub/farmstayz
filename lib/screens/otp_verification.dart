import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'home_page.dart';

class OTPVerification extends StatefulWidget {
  final String verificationid;

  const OTPVerification({Key? key, required this.verificationid})
      : super(key: key);

  @override
  State<OTPVerification> createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  TextEditingController otpController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _counter();
  }

  bool connection = true;

  Future<void> _counter() async {
    if (await ConnectivityWrapper.instance.isConnected) {
      setState(() {
        connection = true;
      });
    } else {
      setState(() {
        connection = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _buildbody(),
      ),
    );
  }

  //main body
  Widget _buildbody() {
    return connection
        ? Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 250,
                  width: 250,
                  child: Lottie.asset("assets/animation_llwcpz6n.json",fit: BoxFit.fill)),
                  const SizedBox(height: 30),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child:
                            Text("Enter OTP", style: TextStyle(fontSize: 20))),
                  ),
                  Container(
                    height: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 28),
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.brown,
                          blurRadius: 5,
                          spreadRadius: 2,
                        )
                      ],
                    ),
                    child: PinCodeTextField(
                      controller: otpController,
                      backgroundColor: Colors.white,
                      cursorColor: Colors.black,
                      length: 6,
                      textStyle:
                          const TextStyle(color: Colors.black, fontSize: 17),
                      pinTheme: PinTheme(
                        activeColor: Colors.black,
                        inactiveColor: Colors.blueGrey,
                        selectedColor: Colors.grey,
                        shape: PinCodeFieldShape.box,
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor: Colors.white,
                      ),
                      appContext: context,
                      onChanged: (String value) {},
                    ),
                  ),
                  const SizedBox(height: 100),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.red,
                          fixedSize: const Size(250, 60),
                          backgroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          elevation: 20.0),
                      onPressed: () async {
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: widget.verificationid,
                                smsCode: otpController.text);
                        await auth
                            .signInWithCredential(credential)
                            .then((value) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ),
                              (route) => false);
                        });
                      },
                      child: const Text("Verify",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 25))),
                ],
              ),
            ),
          )
        : SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Lottie.asset("assets/animation_lkgsgtyo.json"),
          );
  }
}
