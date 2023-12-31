import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../services/firebase_auth_service.dart';
import '../services/firestore_database_service.dart';
import 'aforgot_password.dart';
import 'ahome_page.dart';
import 'asignup_screen.dart';

class AdLoginScreen extends StatefulWidget {
  const AdLoginScreen({Key? key}) : super(key: key);

  @override
  State<AdLoginScreen> createState() => _AdLoginScreenState();
}

class _AdLoginScreenState extends State<AdLoginScreen> {
  RegExp eregExp = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
  RegExp pregExp = RegExp(r'(^(?=.*\d)(?=.*[A-z]).{8,20}$)');
  FirebaseDatabase database = FirebaseDatabase();
  Auth authservice = Auth();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool estatus = false;
  bool pstatus = false;
  bool showpass = false;
  int cnt = 0;

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
                      height: 150,
                      width: 150,
                      child: Lottie.asset("assets/animation_lluyjw5g.json")),
                  const SizedBox(height: 50),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 28),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(33)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.brown,
                          blurRadius: 5,
                          spreadRadius: 2,
                        )
                      ],
                    ),
                    child: TextField(
                      onChanged: (value) {
                        if (value != "") {
                          setState(() {
                            estatus = false;
                          });
                        }
                      },
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
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
                              estatus ? "Please Enter valid Email" : null,
                          hintText: "Enter Email",
                          prefixIcon: const Icon(
                            Icons.mail,
                            color: Colors.black,
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          )),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 28),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(33)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.brown,
                          blurRadius: 5,
                          spreadRadius: 2,
                        )
                      ],
                    ),
                    child: TextField(
                      obscureText: showpass ? false : true,
                      onChanged: (value) {
                        if (value != "") {
                          setState(() {
                            pstatus = false;
                          });
                        }
                      },
                      controller: password,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
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
                              pstatus ? "Please Enter valid Password" : null,
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Enter Password",
                          prefixIcon: const Icon(
                            Icons.key,
                            color: Colors.black,
                          ),
                          suffixIcon: InkWell(
                              onTap: () {
                                if (cnt % 2 == 0) {
                                  setState(() {
                                    showpass = true;
                                  });
                                } else {
                                  setState(() {
                                    showpass = false;
                                  });
                                }
                                cnt++;
                              },
                              child: const Icon(
                                Icons.lock,
                                color: Colors.black,
                              )),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const AdForgotPassword(),
                                  ));
                            },
                            child: const Text(
                              "Forgot password?",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ))),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shadowColor: Colors.red,
                          fixedSize: const Size(250, 60),
                          backgroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          elevation: 20.0),
                      onPressed: () {
                        String email1 = email.text;
                        String password1 = password.text;
                        if (estatus == false || pstatus == false) {
                          if (email1 == "" || !eregExp.hasMatch(email1)) {
                            setState(() {
                              estatus = true;
                            });
                          }
                          if (password1 == "" || !pregExp.hasMatch(password1)) {
                            setState(() {
                              pstatus = true;
                            });
                          } else {
                            authservice
                                .handleSignInEmail(
                                context, email.text, password.text)
                                .then((value) {
                              if (value != null) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const AdHomePage(),
                                    ),
                                        (route) => false);
                              }
                            });
                          }
                        }
                      },
                      child: const Text("Login",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25))),
                  const SizedBox(height: 30),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AdSignUp(),
                          ));
                    },
                    child: RichText(
                        text: const TextSpan(
                            text: "Don't have an account?",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                            children: [
                          TextSpan(
                            text: " Sign Up",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 20),
                          )
                        ])),
                  )
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
