import 'package:cmsc23_project/models/donation_model.dart';
import 'package:cmsc23_project/providers/donation_provider.dart';
import 'package:cmsc23_project/screens/components/image_upload.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '/screens/components/address_form.dart';
import 'package:cmsc23_project/screens/components/contact_number_field.dart';
import 'package:cmsc23_project/screens/components/date_time_picker.dart';
import 'package:cmsc23_project/screens/components/donation_checkbox.dart';
import 'package:flutter/material.dart';

class DonatePage extends StatefulWidget {
  const DonatePage({super.key});

  @override
  State<DonatePage> createState() => _DonatePageState();
}

class _DonatePageState extends State<DonatePage> {
  // form data
  final List<String> formItemCategories = [];
  double formWeight = 0;
  // final String formPhoto = "";
  final Map<dynamic, dynamic> formDateTime = {
    'date': null,
    'time': null,
  };

  bool formIsForPickup = true;
  int isForPickup = 1;
  final List<String> formAddress = [];
  String formContactNumber = "";

  final _formKey = GlobalKey<FormState>();

  late String organizationId;

  @override
  Widget build(BuildContext context) {
    // organizationId = ModalRoute.of(context)!.settings.arguments as String;
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
                    ContactNumberField(updateContactNo: _updateContactNo)
                  ])),
              const Divider(),
              const ImageUpload(uploadLabelText: "Add Donation Photo"),
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
            labelText: "Weight",
            counterText: ""),
        onChanged: (String value) {
          formWeight = double.parse(value);
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please add the weight of the donation";
          } else {
            try {
              int.parse(value);
            } on FormatException {
              return "Please enter weight in number";
            }
          }
          return null;
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

  void _updateContactNo(String contact) {
    setState(() {
      formContactNumber = contact;
    });
  }

  Widget get confirmButton => ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState?.save();

            // checkers
            // save donor username
            print(formItemCategories);
            print(formWeight);
            print(formDateTime['date']);
            print(formDateTime['time']);
            print(formAddress);
            print(formContactNumber);
            // org donated to
            // donationDriveId = null
            // donationstatus initial
            Donation donation = Donation(
                userId: "userId",
                category: formItemCategories,
                weight: formWeight,
                collectionMethod: formIsForPickup ? 1 : 2,
                collectionDate: DateFormat.yMMMMd('en_US').format(formDateTime['date']).toString(),
                collectionTime: formDateTime['time'].format(context).toString(),
                organizationId: organizationId,
                status: "pending");
            final result =
                context.read<DonationProvider>().addDonation(donation) as Map<String, dynamic>;
            // if (result['success'] == true) {
            //   context.read<DonationProvider>().addDonation(donation);
            // }
          }
        },
        child: const Text('Confirm Donation'),
      );
}
