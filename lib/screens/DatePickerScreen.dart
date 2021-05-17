import 'dart:async';
import 'package:flutter/material.dart';
import '../components/components.dart';

class DatePickerScreen extends StatefulWidget {
  DatePickerScreen({Key key}) : super(key: key);


  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePickerScreen> {
  DateTime currentDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kalendář"),
      ),
      drawer: Components().getDrawer(context),
      drawerScrimColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(currentDate.toString()),
            RaisedButton(
              onPressed: () => _selectDate(context),
              child: Text('Vybrat datum'),
            ),
            ElevatedButton(child: Text("Ok"), onPressed: () => Navigator.pushNamed(context, "/"),),
          ],
        ),
      ),
    );
  }
}



