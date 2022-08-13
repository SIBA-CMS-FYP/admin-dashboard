import 'dart:convert';
import 'package:adminpanel/admin-hod.dart';
import 'package:adminpanel/admin_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('Admin Withdraw Form'),
      ),
      resizeToAvoidBottomInset: true,
      body: const SafeArea(
        child: MyApp(),
      ),
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool signin = true;
  TextEditingController teacherCMS = TextEditingController();
  TextEditingController password = TextEditingController();

TextEditingController hodcms = TextEditingController();
  bool processing = false;

  @override
  void initState() {
    super.initState();
  }

  void clearField() {
    teacherCMS.clear();
    password.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            const Icon(
              Icons.account_circle,
              size: 200,
              color: Colors.blue,
            ),
            boxUi(),
          ],
        ));
  }

  void changeState() {
    if (signin) {
      setState(() {
        signin = false;
      });
    } else {
      setState(() {
        signin = true;
      });
    }
  }

  void HODLoginPanel() async {
    setState(() {
      processing = true;
    });
    var url = "https://";
    var data = {
      "teacherCMS": teacherCMS.text,
      "password": password.text,
    };

    var res = await http.post(Uri.parse(url), body: data);
    if (jsonDecode(res.body) == "False") {
      Fluttertoast.showToast(
          msg: "incorrect password", toastLength: Toast.LENGTH_SHORT);
    } else {
      print(jsonDecode(res.body));
    }
    setState(() {
      processing = false;
    });
  }

  void teacherLogin() async {
    setState(() {
      processing = true;
    });
    var url = "https://";
    var data = {
      "teacherCMS": teacherCMS.text,
      "password": password.text,
    };

    var res = await http.post(Uri.parse(url), body: data);
    if (jsonDecode(res.body) == "false") {
      Fluttertoast.showToast(
          msg: "incorrect password", toastLength: Toast.LENGTH_SHORT);
    } else {
      print(jsonDecode(res.body));
    }

    setState(() {
      processing = false;
    });
  }

  Widget boxUi() {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(
                  onPressed: () => {clearField(), changeState()},
                  child: Text(
                    'Teacher',
                    style: GoogleFonts.varelaRound(
                      color: signin == true ? Colors.blue : Colors.grey,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () => {clearField(), changeState()},
                  child: Text(
                    'HOD',
                    style: GoogleFonts.varelaRound(
                      color: signin != true ? Colors.blue : Colors.grey,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            signin == true ? teacherLoginUI() : HODLoginUI(),
          ],
        ),
      ),
    );
  }

  Widget teacherLoginUI() {
    return Column(
      children: <Widget>[
        TextField(
          controller: teacherCMS,
          decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
            ),
            labelText: "Enter your CMS",
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        TextField(
          controller: password,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: "Enter Password",
            prefixIcon: Icon(
              Icons.lock,
            ),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        ElevatedButton(
            onPressed: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AdminDashboard(teacherCMS.text)))
                },
            child: processing == false
                ? Text(
                    'Login',
                    style: GoogleFonts.varelaRound(
                        fontSize: 18.0,
                        color: Color.fromARGB(255, 254, 255, 255)),
                  )
                : const CircularProgressIndicator(
                    backgroundColor: Colors.red,
                  )),
      ],
    );
  }

  Widget HODLoginUI() {
    return Column(
      children: <Widget>[
        TextField(
          controller: teacherCMS,
          decoration: const InputDecoration(
            labelText: "Enter your CMS",
            prefixIcon: const Icon(
              Icons.account_box,
            ),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        TextField(
          controller: password,
          obscureText: true,
          decoration: const InputDecoration(
            prefixIcon: const Icon(
              Icons.lock,
            ),
            labelText: "Enter Password",
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        ElevatedButton(
            // onPressed: () => registerUser(),
            onPressed: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Adminhod(hodcms.text)))
                },
            child: processing == false
                ? Text(
                    'Login',
                    style: GoogleFonts.varelaRound(
                        fontSize: 18.0,
                        color: Color.fromARGB(255, 251, 252, 252)),
                  )
                : const CircularProgressIndicator(backgroundColor: Colors.red)),
      ],
    );
  }

  // now we will setup php and database
//thank you
}
