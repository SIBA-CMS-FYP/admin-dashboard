import 'dart:convert';
import 'package:adminpanel/logout.dart';
import 'package:adminpanel/main.dart';
import 'package:adminpanel/model/http_module.dart';
import 'package:adminpanel/model/teacher_get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeacherResponse extends StatefulWidget {
  String teacher_id;
  TeacherResponse(this.teacher_id, {Key? key}) : super(key: key);

  @override
  _TeacherResponseState createState() => _TeacherResponseState();
}

class _TeacherResponseState extends State<TeacherResponse> {
  // Future<SendWR>? _futureRequest;
  Future<TechGetReq>? studentCourseForWithdraw;
  late String teacher_id = widget.teacher_id;
  late String i;
  // var enrollId;
  @override
  initState() {
    super.initState();
    _loadCurrentEnroll();
  }

  Future<void> _loadCurrentEnroll() async {
    setState(() {
      studentCourseForWithdraw = fetch_C_W(teacher_id.toString());
    });
  }

  Future<void> updateisWithdraw(String cms, String Course_Code) async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/getCurrent/withdrawTCResponse'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{
          'cms': cms,
          'Course_Code': Course_Code,
        },
      ),
    );
    var resp = jsonDecode(response.body);
    print(resp);

    if (resp.toString() == "1") {
      _loadCurrentEnroll();
      // return SendWR.fromJson(jsonDecode(response.body));
    } else {
      print("call else");
      throw Exception('Failed to Withdraw.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Teacher Portal"),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Logout', 'Settings'}.map((String choice) {
                return PopupMenuItem<String>(
                    value: choice, child: Text(choice));
              }).toList();
            },
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder<TechGetReq>(
          future: studentCourseForWithdraw,
          builder: (context, Coursesdata) {
            if (Coursesdata.hasData) {
              return ListView.builder(
                itemCount: Coursesdata.data!.row.length,
                itemBuilder: (context, index) {
                  var cData = Coursesdata.data!;
                  return cData.row[index].isTeacherAcp == 1
                      ? Card(
                          child: ListTile(
                              title: Text("Name " +
                                  cData.row[index].Name +
                                  "\nCourse " +
                                  cData.row[index].courseTitle),
                              leading: Icon(Icons.book_online_rounded),
                              trailing: (cData.row[index].isTeacherAcp == 1 &&
                                      cData.row[index].isHODAcept == 0)
                                  ? ElevatedButton(
                                      onPressed: () => {
                                        setState(
                                          () {
                                            updateisWithdraw(
                                                cData.row[index].CMS,
                                                cData.row[index].Course_Code);
                                          },
                                        ),
                                      },
                                      child: Text("Accpet"),
                                    )
                                  : ElevatedButton(
                                      onPressed: null,
                                      child: Text("Accepted"),
                                    )))
                      : index == 0
                          ? Center(
                              child: Text(
                                "No one Apply For Withdraw",
                                textAlign: TextAlign.center,
                              ),
                            )
                          : Text("");
                },
              );
            } else if (Coursesdata.hasError) {
              return Text('${Coursesdata.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

handleClick(String value) {
  switch (value) {
    case 'Logout':
      break;
    case 'Settings':
      break;
  }
}
