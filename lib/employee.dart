import 'dart:collection';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'employee_info.dart';
import 'models/employee_detail.dart';
import 'styles.dart';

class EmployeeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EmployeeScreenState();
  }
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  final List<EmployeeDetail> items = [];

  @override
  void initState() {
    super.initState();
    getEmployees();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(title: Text("Mobile Technical Test", style: Styles.navBarTitle,)),
        body: ListView.builder(
            itemCount: this.items.length,
            itemBuilder: _listViewItemBuilder
        )
    );
  }

  Widget _listViewItemBuilder(BuildContext context, int index){
    var employeeDetail = this.items[index];
    return ListTile(
        contentPadding: EdgeInsets.all(10.0),
        leading: _itemThumbnail(employeeDetail),
        title: _itemTitle(employeeDetail),
        onTap: (){
          _navigationToEmployeeDetail(context, employeeDetail);
        });
  }

  void _navigationToEmployeeDetail(BuildContext context, EmployeeDetail employeeDetail){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context){return EmployeeInfo(employeeDetail);}
        ));
  }

  Widget _itemThumbnail(EmployeeDetail employeeDetail){
    return Container(
      constraints: BoxConstraints.tightFor(width: 100.0, height: 120.0),
      child: employeeDetail.picture == null ? null : Image.network(employeeDetail.picture, fit: BoxFit.fitWidth),

    );
  }

  Widget _itemTitle(EmployeeDetail employeeDetail){
    return Text(employeeDetail.title + ' ' + employeeDetail.firstName + ' ' + employeeDetail.lastName, style: Styles.textDefault);
  }

  void getEmployees() async{
    String url = "https://dummyapi.io/data/api/user?limit=10";
    Map<String, String> headers= new HashMap();
    headers.putIfAbsent('app-id', () => '6104425d8470c0830271a894');
    final http.Response response = await http.get(url,headers:headers);
    final Map<String, dynamic> responseData = json.decode(response.body);
    responseData['data'].forEach((employeeDetail) {
      final EmployeeDetail employees = EmployeeDetail(
          id: employeeDetail['id'],
          title: employeeDetail['title'],
          firstName: employeeDetail['firstName'],
          lastName: employeeDetail['lastName'],
          email: employeeDetail['email'],
          picture: employeeDetail['picture']
      );
      setState(() {
        items.add(employees);
      });
    });
  }
}

