import 'package:flutter/material.dart';

class AdminDashboard extends StatefulWidget {
  var teacher_id;
  AdminDashboard(this.teacher_id);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Panel"),
        // actions: <Widget>[
        //   PopupMenuButton<String>(
        //     onSelected: handleClick,
        //     itemBuilder: (BuildContext context) {
        //       return {'Logout', 'Settings'}.map((String choice) {
        //         return PopupMenuItem<String>(
        //           value: choice,
        //           child: Text(choice),
        //         );
        //       }).toList();
        //     },
        //   ),
        // ],
        
      ),
      body: Container(
        child: Text("Teacher CMS ID "+widget.teacher_id),
      ),
    );
  }
}

// void handleClick(String value) {
//   switch (value) {
//     case 'Logout':
//       break;
//     case 'Settings':
//       break;
//   }
// }

