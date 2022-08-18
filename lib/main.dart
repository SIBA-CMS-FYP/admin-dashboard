import 'dart:convert';
import 'package:adminpanel/admin-hod.dart';
import 'package:adminpanel/admin_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  runApp(MaterialApp(
    builder: (context, child) => ResponsiveWrapper.builder(child, maxWidth: 1200, 
      minWidth: 480, defaultScale: true,
      breakpoints: [ResponsiveBreakpoint.resize(480, name: MOBILE),
      ResponsiveBreakpoint.autoScale(800, name: TABLET),
      ResponsiveBreakpoint.resize(1000, name: DESKTOP),
      ],
      background: Container(color: Color(0xFFF5F5F5))),
      initialRoute: "/",
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
  TextEditingController teacher_id = TextEditingController();
  TextEditingController password = TextEditingController();
TextEditingController hodcms = TextEditingController();
  bool processing = false;

  @override
  void initState() {
    super.initState();
  }

  void clearField() {
    teacher_id.clear();
    password.clear();
    hodcms.clear();
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
    var url = "http://localhost:3000/teacher/hodlogin";
    var data = {
      "hodcms": hodcms.text,
      "password": password.text,
    };
var res = await http.post(Uri.parse(url), body: data);
    var resData = jsonDecode(res.body);
    if (resData["success"].toString() == "false") {
      Fluttertoast.showToast(
          msg: "incorrect password", toastLength: Toast.LENGTH_SHORT);
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Adminhod(hodcms.text)));
      print((res.body.toString()));
    }
    
    setState(() {
      processing = false;
    });
  }

  void teacherLogin() async {
    
     setState(() {
      processing = true;
    });
    var url = "http://localhost:3000/teacher/techerlogin";
    var data = {
      "teacher_id": teacher_id.text,
      "password": password.text,
    };
    var res = await http.post(Uri.parse(url), body: data);
    var resData = jsonDecode(res.body);
    if (resData["success"].toString() == "false") {
      Fluttertoast.showToast(
          msg: "incorrect password", toastLength: Toast.LENGTH_SHORT);
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AdminDashboard(teacher_id.text)));
      print((res.body.toString()));
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
          controller: teacher_id,
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
                 teacherLogin()
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
          controller: hodcms,
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
                  HODLoginPanel()
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
