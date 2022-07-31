import 'package:flutter/material.dart';
import 'package:white_rabit/detail_page.dart';
import 'package:white_rabit/models/employee_model.dart';
import 'package:white_rabit/services/database_services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Employee Data Base '),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Employee> employeeList = [];
  @override
  void initState() {
    super.initState();
    getEmployee();
  }

  getEmployee() async {
    var data = await DataBaseServices().getEmployeeData();
    setState(() {
      employeeList = data;
    });
  }

  search(text) {
    if (text == '') {
      getEmployee();
    } else {
      Iterable<Employee> searchItemByName = employeeList.where((element) {
        return element.name!.contains(text);
      });

      List<Employee> searchEmployeeList = [];
      for (var i in searchItemByName) {
        searchEmployeeList.add(i);
      }

      setState(() {
        employeeList = searchEmployeeList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: TextField(
            decoration: const InputDecoration(
              fillColor: Colors.white,
              hintText: 'Search',
              focusColor: Colors.white,
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
            onChanged: (text) {
              search(text);
            },
          ),
        ),
      ),
      body: Center(
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            for (var i in employeeList)
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailPage(
                              employee: i,
                            )),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(i.name ?? ''),
                    Text(i.email ?? ''),
                    Image.network(i.profileImage ?? ''),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
