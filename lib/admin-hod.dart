import 'package:flutter/material.dart';

class Adminhod extends StatefulWidget {
  var hodcms;
  Adminhod(this.hodcms);

  @override
  State<Adminhod> createState() => _AdminhodState();
}

class _AdminhodState extends State<Adminhod> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Panel"),
      
      ),
      body: Container(
        child: Text("Teacher CMS ID "+widget.hodcms),
      ),
    );
  }
}



