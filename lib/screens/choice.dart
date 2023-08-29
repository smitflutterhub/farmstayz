import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../admin/alogin_screen.dart';
import 'login_page.dart';

class Choices extends StatefulWidget {
  const Choices({Key? key}) : super(key: key);

  @override
  State<Choices> createState() => _ChoicesState();
}

class _ChoicesState extends State<Choices> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _buildbody(),
      ),
    );
  }

  Widget _buildbody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset("assets/SNfNL6xgrP.json"),
          const SizedBox(height: 10),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(200, 60),
                  backgroundColor: Colors.redAccent,
                  shadowColor: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  elevation: 20.0),
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdLoginScreen(),
                    ));
              },
              child: const Text("Admin",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 25))),
          const SizedBox(height: 35),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(200, 60),
                  shadowColor: Colors.red,
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  elevation: 20.0),
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ));
              },
              child: const Text("User",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 25))),
        ],
      ),
    );
  }
}
