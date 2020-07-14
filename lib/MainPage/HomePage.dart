import 'package:bicycle/SQflite/Employee.dart';
import 'package:bicycle/SQflite/db_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String title;
  HomePage({Key key, this.title}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Employee>> employee=DbHelper().getEmployee();
  DbHelper dbHelper;
  bool isUpdating;
  int currentId;
  String name;
  TextEditingController controller;
  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
    controller = TextEditingController();
    isUpdating = false;
    refreshList();
  }

  refreshList() {
    setState(() {
      employee = dbHelper.getEmployee();
    });
  }

  validator() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      if (isUpdating) {
        Employee e = Employee(currentId,name);
        DbHelper().update(e);
        setState(() {
          isUpdating = false;
        });
      } else {
        Employee e = Employee(null,name);
        dbHelper.save(e);
      }
    controller.text = '';
    refreshList();
    }
  }

  final formKey = GlobalKey<FormState>();
  Widget form() {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: controller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Enter Your Name",
              ),
              validator: (val) => val.length == null ? "Enter Your Name" : null,
              onSaved: (val) => name = val,
            ),
            SizedBox(
              height:20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                OutlineButton(
                    onPressed: validator,
                    child: Text(isUpdating ? 'Update' : 'ADD')),
                OutlineButton(
                    onPressed: () {
                      setState(() {
                        isUpdating=false;
                      });
                    },
                    child: Text('Cancel')),
              ],
            )
          ],
        ),
      ),
    );
  }

  SingleChildScrollView dataTable(List<Employee> employee) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: [
          DataColumn(
            label: Text("Name"),
            tooltip: "First Name",
          ),
          DataColumn(
            label: Icon(Icons.delete_outline),
            tooltip: "Delete",
          ),
        ],
        rows: employee.map((employees)=>
         DataRow(cells: [
            DataCell(Text('${employees.name}'), onTap: () {
              setState(() {
                isUpdating = true;
                currentId = employees.id;
              });
              controller.text = employees.name;
            }),
            DataCell(
              IconButton(
                icon: Icon(Icons.delete_outline),
                onPressed: () {
                  setState(() {
                    dbHelper.delete(employees.id);
                    refreshList();
                  });
                },
              ),
            )
          ]),
        ).toList(),
      ),
    );
  }

  Widget list() {
    return Expanded(
      child: FutureBuilder(
          future: employee,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return dataTable(snapshot.data);
              
            }
            else if (null == snapshot.data || snapshot.data.length == 0) {
              return Text("No Data Found");
            }
            return CircularProgressIndicator();
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            form(),
            list(),
          ],
        ),
      ),
    );
  }
}
