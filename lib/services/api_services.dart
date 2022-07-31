import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/employee_model.dart';

class ApiServices {
  Future<dynamic> getEmployeeData() async {
    String route = 'http://www.mocky.io/v2/5d565297300000680030a986';
    Uri url = Uri.parse(route);
    try {
      http.Response response = await http.get(url);
      final decodedData = jsonDecode(response.body);
      debugPrint("⏳============= Fetching employee from API ============⏳");
      return decodedData;
    } catch (e) {
      debugPrint("❗============= ${e.toString()} error  ============❗");
      throw Exception(e.toString());
    }
  }
}
