import 'dart:convert';

import 'package:adminpanel/admin_dashboard.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
  bool _validate = false;
  bool signin = true;
  TextEditingController teacher_id = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController hodcms = TextEditingController();
  TextEditingController hodPassword = TextEditingController();
  bool processing = false;

  @override
  void initState() {
    super.initState();
  }

  void clearField() {
    teacher_id.clear();
    password.clear();
    hodcms.clear();
    hodPassword.clear();
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

  void hODLoginPanel() async {
    setState(() {
      processing = true;
    });

    var url = "http://localhost:3000/teacher/hodlogin";

    var data = {
      "hodcms": hodcms.text,
      "password": hodPassword.text,
    };
    var res = await http.post(Uri.parse(url), body: data);
    var resData = jsonDecode(res.body);
    if (resData["success"].toString() == "false") {
      print("object");
      _showMyDialog();
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('hodcms', hodcms.text);
      prefs.setString("hodpassword", hodPassword.text);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => HodResponse(hodcms.text)));
      print((res.body.toString()));
    }

    setState(() {
      processing = false;
    });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void teacherLogin() async {

    // setState(() {
    //   processing = true;
    // });
    
     var url = "http://localhost:3000/teacher/techerlogin";

    var data = {
      "teacher_id": teacher_id.text,
      "password": password.text,
    };

    var res = await http.post(Uri.parse(url), body: data);
    var resData = jsonDecode(res.body);
    if (resData["success"].toString() == "false") {
      print("object");
      // Fluttertoast.showToast(
      //     msg: "incorrect password", toastLength: Toast.LENGTH_SHORT);
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('cms', teacher_id.text);
      prefs.setString("password", password.text);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TeacherResponse(teacher_id.text)));
      print((res.body.toString()));
    }


    // if (jsonDecode(res.body) == "false") {
    //   Fluttertoast.showToast(
    //       msg: "incorrect password", toastLength: Toast.LENGTH_SHORT);
    // } else {
    //   print(jsonDecode(res.body));
    // }
    if(res.statusCode == 200){
        if(res.statusCode != 201){
          Scaffold.of(context).showSnackBar(SnackBar(content: Text("wrong input")));
        }
        else {
           Navigator.push(context,
                     MaterialPageRoute(builder: (context) => AdminDashboard()));
        }     
     
             
    }
    else{
    Scaffold.of(context).showSnackBar(SnackBar(content: Text("invalid creadentails")));  
    }
    }
    else {
   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Text field not allowed")));
    }
    // setState(() {
    //   processing = false;
    // });
  }
                        //card  withdraw form
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
                                  //teacher login textbox and button
  Widget teacherLoginUI() {
    return Column(
      children: <Widget>[
        TextField(
          controller: teacher_id,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
            ),
            labelText: "Enter your Teacher CMS",
            errorText: _validate ? 'CMS Can\'t Be Empty' : null,
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        TextField(
          controller: password,
          obscureText: true,
          decoration: InputDecoration(
            labelText: "Enter Password",
            errorText: _validate ? 'Password Can\'t Be Empty' : null,
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
            setState(() {
              teacher_id.text.isEmpty ? _validate = true : _validate = false;
              password.text.isEmpty ? _validate = true : _validate = false;
              teacherLogin();
            }),
          },
          child: processing == false
              ? Text(
                  'Login',
                  style: GoogleFonts.varelaRound(
                      fontSize: 18.0,
                      color: Color.fromARGB(255, 254, 255, 255)),
                )
              : CircularProgressIndicator(),
        ),

      ],
    );
  } 
                               //hod login textbox and button
  Widget HODLoginUI() {
    return Column(
      children: <Widget>[
        TextField(
          controller: hodcms,
          decoration: const InputDecoration(
            labelText: "Enter your CMS",
            errorText: 'CMS Can\'t Be Empty',
            prefixIcon: Icon(
              Icons.account_box,
            ),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        TextField(
          controller: hodPassword,
          obscureText: true,
          decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.lock,
            ),
            labelText: "Enter Password",
            errorText: 'Password Can\'t Be Empty',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        ElevatedButton(
            onPressed: () => {

                  // Navigator.push(context,
                  
                  //     MaterialPageRoute(builder: (context) => AdminDashboard()))
                      

                },
            child: processing == false
                ? Text(
                    'Login',
                    style: GoogleFonts.varelaRound(
                        fontSize: 18.0,
                        color: Color.fromARGB(255, 251, 252, 252)),
                  )
                : const CircularProgressIndicator()),
      ],
    );
  }

//create function to call login post api
// Future<void> login() async {
//   if(password.text.isNotEmpty && teacherCMS.text.isNotEmpty){
// var response = await http.post(Uri.parse("http://localhost:3000/teacher/techerlogin?teacher_id=INS-0020&password=teacher1"), body({
//   'teacher_id' : teacherCMS.text;
//     'password' : password.
// }));
//   }
//   else {
//     ScaffoldMessenger.of(context).showSnackBar(context: Text("black field not allowed"));
//   }
      
// }

}
