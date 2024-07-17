import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class ReminderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reminder Dialog'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showReminderDialog(context);
          },
          child: Text('Set Monthly Reminder'),
        ),
      ),
    );
  }

  Future<void> showReminderDialog(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    await showMonthPicker(
      context: context,
      initialDate: selectedDate,
    ).then((date) {
      if (date != null) {
        selectedDate = date;
        showAlertDialog(context);
      }
    });
  }

  void showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text("Monthly Reminder"),
      content: Text("Don't forget to enter the number of miles for this month."),
      actions: [
        TextButton(
          child: Text("Remind me later"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text("Enter miles"),
          onPressed: () {
            // Handle the action to enter the number of miles here
            Navigator.of(context).pop();
          },
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}