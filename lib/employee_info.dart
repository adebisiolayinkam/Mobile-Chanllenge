import 'package:flutter/material.dart';
import 'package:news_app/models/employee_detail.dart';
import 'styles.dart';

class EmployeeInfo extends StatelessWidget{
  final EmployeeDetail employeeDetail;
  String id;
  EmployeeInfo(this.employeeDetail);

  @override

  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(title: Text(employeeDetail.id, style: Styles.navBarTitle,)),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _renderBody(context, employeeDetail),
        )
    );
  }

  List<Widget> _renderBody(BuildContext context, EmployeeDetail employeeDetail){
    var result = List<Widget>();
    result.add(_bannerImage(employeeDetail.picture, 270.0));
    result.addAll(_renderInfo(context, employeeDetail));
    return result;
  }

  List<Widget> _renderInfo(BuildContext context, EmployeeDetail employeeDetail){
    var result = List<Widget>();
    result.add(_sectionTitle(employeeDetail.title));
    result.add(_sectionText("First Name: " + employeeDetail.firstName));
    result.add(_sectionText("Last Name: " + employeeDetail.lastName));
    result.add(_sectionText("Email: " + employeeDetail.email));

    return result;
  }

  Widget _sectionTitle(String text){
    return Container(
        padding: EdgeInsets.fromLTRB(25.0,25.0,25.0,10.0),
        child: Text(text,
            textAlign: TextAlign.left,
            style: Styles.headerLarge));
  }
  Widget _sectionText(String text){
    return Container(
        padding: EdgeInsets.fromLTRB(25.0,15.0,25.0,15.0),
        child:Text(text, style: Styles.textDefault,)
    );
  }

  Widget _bannerImage(String url, double height){
    return Container(
        constraints: BoxConstraints.tightFor(height: height),
        child: Image.network(url, fit: BoxFit.fitWidth)
    );
  }
}
