import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../services/firebase_auth_service.dart';
import '../services/firestore_database_service.dart';
import 'home_page.dart';
import 'login_page.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  RegExp eregExp = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
  RegExp numregExp = RegExp(r'(^(?:[+9]1)?[0-9]{10}$)');
  RegExp pregExp = RegExp(r'(^(?=.*\d)(?=.*[A-z]).{8,20}$)');
  FirebaseDatabase database = FirebaseDatabase();
  Auth authservice = Auth();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController password = TextEditingController();
  bool estatus = false;
  bool pstatus = false;
  bool showpass = false;
  bool nstatus = false;
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
                  const Text(
                    "Welcome",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Create your account and explore",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("Enter Username",
                            style: TextStyle(fontSize: 20))),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 28),
                    child: TextField(
                      controller: username,
                      cursorColor: Colors.black,
                      decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                              borderSide: BorderSide(color: Colors.black)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                              borderSide: BorderSide(color: Colors.black)),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Enter Username",
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          )),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("Enter Email ID",
                            style: TextStyle(fontSize: 20))),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 28),
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
                              estatus ? "Please Enter valid Email" : null,
                          hintText: "Email ID",
                          prefixIcon: const Icon(
                            Icons.mail,
                            color: Colors.black,
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          )),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("Enter Password",
                            style: TextStyle(fontSize: 20))),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 28),
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
                                Radius.circular(15),
                              ),
                              borderSide: BorderSide(color: Colors.black)),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
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
                              Radius.circular(15),
                            ),
                          )),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("Enter Mobile Number",
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
                      controller: mobile,
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
                  const SizedBox(height: 50),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(250, 60),
                          backgroundColor: Colors.black87,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          elevation: 20.0),
                      onPressed: () {
                        String email1 = email.text;
                        String password1 = password.text;
                        String number1 = mobile.text;
                        if (email1 == "" || !eregExp.hasMatch(email1)) {
                          setState(() {
                            estatus = true;
                          });
                        } else if (password1 == "" ||
                            !pregExp.hasMatch(password1)) {
                          setState(() {
                            pstatus = true;
                          });
                        } else if (number1 == "" ||
                            !numregExp.hasMatch(number1)) {
                          setState(() {
                            nstatus = true;
                          });
                        } else {
                          authservice
                              .handleSignUp(context, email.text, password.text)
                              .then((value) {
                            if (value != null) {
                              database.set(context, username.text, email.text,
                                  mobile.text, password.text);
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomePage(),
                                  ),
                                  (route) => false);
                            }
                          });
                        }
                      },
                      child: const Text("Sign Up",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25))),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ));
                    },
                    child: RichText(
                        text: const TextSpan(
                            text: "Already have an account?",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                            children: [
                          TextSpan(
                            text: " Login",
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
