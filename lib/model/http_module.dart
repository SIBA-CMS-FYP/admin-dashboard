import 'dart:convert';
import 'package:adminpanel/model/teacher_get.dart';
import "package:http/http.dart" as http;

class RequestResult {
  bool ok;
  dynamic data;
  RequestResult(this.ok, this.data);
}

const PROTOCOL = "http";
const DOMAIN = "192.168.227.60:8080";

Future<TechGetReq> fetch_C_W(String cms) async {
  var url = "$PROTOCOL://$DOMAIN/getWithdraw/Request?teacher_id=$cms";
  var response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return TechGetReq.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to load data");
  }
}

Future<TechGetReq> fetch_C_H(String cms) async {
  var url = "$PROTOCOL://$DOMAIN/getWithdraw/HRequest?hodcms=$cms";
  var response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return TechGetReq.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to load data");
  }
}
