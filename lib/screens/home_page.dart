import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildappbar(),
      drawer: _builddrawer(),
      body: _buildbody(),
    );
  }

  //App Bar
  AppBar _buildappbar() {
    return AppBar(
      elevation: 0,
      actions: [
        const Icon(Icons.notifications, color: Colors.white, size: 30),
      ],
    );
  }

  //Drawer
  Widget _builddrawer() {
    return Drawer(
      elevation: 0,
    );
  }

  //main body
  Widget _buildbody() {
    return Column(
      children: [
        Container(
          height: 120,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const Align(
                    alignment: Alignment.topLeft,
                    child:
                        Text("Online Store", style: TextStyle(fontSize: 20))),
              ],
            ),
          ),
        ),
        Text("What's new? "),
      ],
    );
  }
}
