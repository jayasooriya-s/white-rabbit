import 'package:flutter/foundation.dart';
import 'package:localstorage/localstorage.dart';
import 'package:white_rabit/models/employee_model.dart';
import 'package:white_rabit/services/api_services.dart';

class DataBaseServices {
  final LocalStorage localStorage = LocalStorage('local_storage');
  Future<List<Employee>> getEmployeeData() async {
    try {
      final ready = await localStorage.ready;
      List<Employee> employeeList = [];
      if (ready) {
        final json = await localStorage.getItem('employee');
        if (json != null) {
          for (var data in json) {
            employeeList.add(Employee.fromJson(data));
            print(Employee.fromJson(data).name);
          }

          debugPrint(
              '========== getting employee data from local storage ===========');
          return employeeList;
        } else {
          var data = await ApiServices().getEmployeeData();
          await localStorage.setItem('employee', data);
          for (var i in data) {
            employeeList.add(Employee.fromJson(i));
            print(Employee.fromJson(i).id);
          }
          return employeeList;
        }
      }
      return employeeList;
    } catch (e) {
      debugPrint("❗============= ${e.toString()} error  ============❗");
      throw Exception(e.toString());
    }
  }
}
