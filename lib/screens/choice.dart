import 'package:flutter/material.dart';
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
          const Text("Login As",
              style: TextStyle(fontSize: 70, fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 150,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(200, 60),
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  elevation: 20.0),
              onPressed: () async {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdLoginScreen(),
                    ),
                        (route) => false);
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
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  elevation: 20.0),
              onPressed: () async {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                          (route) => false);
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
