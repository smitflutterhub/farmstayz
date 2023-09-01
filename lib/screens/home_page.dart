import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getdata();
  }

  TextEditingController search = TextEditingController();
  String name = "";
  String mail = "";

  Future<void> getdata() async {
    final prefs = await SharedPreferences.getInstance();
    name = prefs.getString('Username') ?? "";
    mail = prefs.getString("mail") ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildappbar(),
        drawer: _builddrawer(),
        body: _buildbody(),
      ),
    );
  }

  //App Bar
  AppBar _buildappbar() {
    return AppBar(
      backgroundColor: Colors.redAccent,
      elevation: 0,
      title: const Text("Welcome"),
      centerTitle: true,
      actions: [
        IconButton(icon: const Icon(Icons.person, color: Colors.white, size: 30), onPressed: () {},),
        const SizedBox(width: 13),
      ],
    );
  }

  //Drawer
  Widget _builddrawer() {
    return Drawer(
      elevation: 0,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.redAccent
            ),
              accountName: Text(name.toString(),style: const TextStyle(fontSize: 25)),
              accountEmail: Text(mail.toString(),style: const TextStyle(fontSize: 17))),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(Icons.account_circle,size: 40),
                ),
                Text(name.toString(),style: const TextStyle(fontSize: 20)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(Icons.mail,size: 40),
                ),
                Text(mail.toString(),style: const TextStyle(fontSize: 20)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: const [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(Icons.wallet,size: 40),
                ),
                Text("1000.00 Rs.",style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //main body
  Widget _buildbody() {
    return Column();
  }
}
