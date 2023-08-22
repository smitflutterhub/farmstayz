import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../services/firebase_auth_service.dart';
import 'aotp_verification.dart';

class AdForgotPassword extends StatefulWidget {
  const AdForgotPassword({Key? key}) : super(key: key);

  @override
  State<AdForgotPassword> createState() => _AdForgotPasswordState();
}

class _AdForgotPasswordState extends State<AdForgotPassword> {
  RegExp numregExp = RegExp(r'(^(?:[+9]1)?[0-9]{10}$)');
  TextEditingController mobileno = TextEditingController();
  Auth auth = Auth();
  bool nstatus = false;

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
                  const Text(
                    "Forgot Password?",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Don't Worry",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Login with Mobile Number",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 60),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("Enter Mobile number",
                            style: TextStyle(fontSize: 20))),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 28),
                    child: TextField(
                      onChanged: (value) {
                        if (value != "") {
                          setState(() {
                            nstatus = false;
                          });
                        }
                      },
                      controller: mobileno,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                              borderSide: BorderSide(color: Colors.black)),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                              borderSide: BorderSide(color: Colors.black)),
                          errorText:
                              nstatus ? "Please Enter valid mobile no" : null,
                          hintText: "Enter Number",
                          prefixIcon: const Icon(
                            Icons.phone,
                            color: Colors.black,
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          )),
                    ),
                  ),
                  const SizedBox(height: 100),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(250, 60),
                          backgroundColor: Colors.black87,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          elevation: 20.0),
                      onPressed: () {
                        String number1 = mobileno.text;
                        if (number1 == "" || !numregExp.hasMatch(number1)) {
                          setState(() {
                            nstatus = true;
                          });
                        } else {
                          auth
                              .registerUserWithOTP(mobileno.text, context)
                              .then((value) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AdOTPVerification(
                                      verificationid: mobileno.text),
                                ));
                          });
                        }
                      },
                      child: const Text("Get OTP",
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
