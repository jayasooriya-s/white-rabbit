import 'package:flutter/material.dart';
import 'package:white_rabit/models/employee_model.dart';

class DetailPage extends StatelessWidget {
  final Employee employee;
  const DetailPage({Key? key, required this.employee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Name : ${employee.name}"),
            Image.network(employee.profileImage ?? ''),
            Text("Email : ${employee.email}"),
            Text("phone : ${employee.phone}"),
            Text("UserName : ${employee.username}"),
            Text("Company : ${employee.company!.name}"),
            Text("Website : ${employee.website}"),
          ],
        ),
      ),
    );
  }
}
