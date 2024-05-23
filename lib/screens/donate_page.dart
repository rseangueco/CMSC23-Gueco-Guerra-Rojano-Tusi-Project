import 'package:cmsc23_project/screens/components/address_form.dart';
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
  final Map<dynamic, dynamic> formDateTime = {
    'date': null,
    'time': null,
  };

  bool formIsForPickup = true;
  int isForPickup = 1;
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
              const Divider(),
              radioIsForPickUp,
              const Divider(),
              Visibility(
                  visible: (isForPickup == 1 ? true : false),
                  child: Column(children: [
                    AddressForm(addressList: formAddress),
                    // contactNumber
                  ])),
              confirmButton,
            ],
          )),
        ));
  }

  Widget get weightField => Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        maxLength: 10,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Weight (in kg)",
          labelText: "Weight (optional)",
          counterText: ""
        ),
        onChanged: (String value) {
          formWeight = int.parse(value);
        },
      ));

  Widget get radioIsForPickUp => FormField(
        builder: (FormFieldState<bool> state) {
          return Column(
            children: [
              RadioListTile(
                title: const Text("For pickup"),
                value: 1,
                groupValue: isForPickup,
                onChanged: (int? value) {
                  setState(() {
                    isForPickup = value!;
                  });
                },
              ),
              RadioListTile(
                title: const Text("For drop-off"),
                value: 0,
                groupValue: isForPickup,
                onChanged: (int? value) {
                  setState(() {
                    isForPickup = value!;
                    formAddress.clear();
                  });
                },
              )
            ],
          );
        },
        onSaved: (_) {
          if (isForPickup == 1) {
            formIsForPickup = true;
          } else {
            formIsForPickup = false;
          }
        },
      );

  Widget get confirmButton => ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState?.save();
            // check values

            // save donor username
            print(formItemCategories);
            print(formWeight);
            print(formDateTime['date']);
            print(formDateTime['time']);
            print(formAddress);
            // org donated to
            // donationDriveId = null
            // donationstatus initial

          }
        },
        child: const Text('Confirm Donation'),
      );
}
