import 'package:cmsc23_project/screens/components/date_time_picker.dart';
import 'package:cmsc23_project/screens/components/donation_checkbox.dart';
import 'package:flutter/material.dart';

class DonatePage extends StatefulWidget {
  const DonatePage({super.key});

  @override
  State<DonatePage> createState() => _DonatePageState();
}

class _DonatePageState extends State<DonatePage> {
  final List<String> formItemCategories = [];
  int formWeight = 0;
  // final String formPhoto = "";
  // DateTime? formDate;
  // TimeOfDay? formTime;

  final Map<dynamic, dynamic> formDateTime = {
    'date': null,
    'time': null,
  };

  final bool formRadio = false;
  final List<String> formAddress = [];
  final String formContactNumber = "";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Donate'),
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
              child: Column(
            children: [
              DonationCheckbox(categories: formItemCategories),
              weightField,
              DateTimePicker(
                dateTime: formDateTime,
              ),
              confirmButton,
            ],
          )),
        ));
  }

  Widget get weightField => Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Weight (in kg)",
          labelText: "Weight (optional)",
        ),
        onChanged: (String value) {
          formWeight = int.parse(value);
        },
      ));

  Widget get confirmButton => ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState?.save();
          }

          // check values
          print(formItemCategories);
          print(formWeight);
          print(formDateTime['date']);
          print(formDateTime['time']);
        },
        child: const Text('Confirm Donation'),
      );
}
