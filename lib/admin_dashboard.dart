import 'package:flutter/material.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

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
      body: Container(),
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

