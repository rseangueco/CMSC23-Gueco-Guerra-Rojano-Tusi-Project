import 'package:cmsc23_project/models/donation_model.dart';
import 'package:cmsc23_project/providers/donation_provider.dart';
import 'package:cmsc23_project/providers/organization_provider.dart';
import 'package:cmsc23_project/screens/components/image_upload.dart';
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
  String donationPhoto = "";

  final _formKey = GlobalKey<FormState>();

  late Map<String, String> donor;

  @override
  Widget build(BuildContext context) {
    donor = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
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
              ImageUpload(
                  uploadLabelText: "Add Donation Photo",
                  callback: (String photo) => donationPhoto = photo),
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
        onPressed: () async {
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
                userId: donor['userId']!,
                category: formItemCategories,
                weight: formWeight,
                collectionMethod: formIsForPickup ? 1 : 2,
                photo: donationPhoto,
                collectionDate: formDateTime['date'],
                collectionTime: formDateTime['time'],
                organizationId: donor['organizationId']!,
                status: "Pending");
            final result =
                await context.read<DonationProvider>().addDonation(donation);

            if (mounted) {
              if (result['success'] = true) {
                String donationId = result['message'];
                final result2 = await context
                    .read<OrganizationProvider>()
                    .addDonation(donor['organizationId']!, donationId);
                if (mounted) {
                  if (result2['success'] == true) {
                    final message = SnackBar(
                      content: Text(result2['message']),
                      backgroundColor: Colors.green,
                      elevation: 10,
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.all(5),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(message);
                  }
                }
              }
            }
          }

          // TODO: clear fields after? pero idk since mag navigator.pop naman ata after confirm
        },
        child: const Text('Confirm Donation'),
      );
}
