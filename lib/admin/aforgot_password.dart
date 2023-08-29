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
                  SizedBox(
                      height: 250,
                      width: 250,
                      child: Lottie.asset("assets/animation_llwcp1cg.json",
                          fit: BoxFit.fill)),
                  const SizedBox(height: 60),
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
                          labelText: "Enter Number",
                          labelStyle: const TextStyle(color: Colors.black),
                          enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                              borderSide: BorderSide(color: Colors.black)),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                              borderSide: BorderSide(color: Colors.black)),
                          errorText:
                              nstatus ? "Please Enter valid mobile no" : null,
                          hintText: "Number",
                          prefixIcon: const Icon(
                            Icons.phone,
                            color: Colors.black,
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          )),
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
