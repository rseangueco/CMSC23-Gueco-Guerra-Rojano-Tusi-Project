import 'package:flutter/material.dart';

class ContactNumberField extends StatefulWidget {
  final ValueChanged<String> updateContactNo;
  const ContactNumberField({super.key, required this.updateContactNo});

  @override
  State<ContactNumberField> createState() => _ContactNumberFieldState();
}

class _ContactNumberFieldState extends State<ContactNumberField> {
  TextEditingController contactNoController = TextEditingController();
  final String savedContact = "09123456789";
  bool? isChecked = false;

  @override
  void initState() {
    super.initState();
    contactNoController.addListener(() {});
  }

  @override
  void dispose() {
    contactNoController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          TextFormField(
              controller: contactNoController,
              enabled: !(isChecked!),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.contact_phone),
                hintText: "Contact No.",
                suffixIcon: IconButton(
                  onPressed: contactNoController.clear,
                  icon: const Icon(Icons.clear)
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "This field is required";
                } else if (!isValidContactNo(value)) {
                  return "Invalid form. Please enter an 11 digit contact number.";
                } else {
                  return null;
                }
              },
              onSaved: (_){
                widget.updateContactNo(contactNoController.text);
              },),
              CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: const Text("Use saved contact number"),
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value;
                            contactNoController.text = savedContact;
                          });
                        },
                      )
        ]));
  }

  bool isValidContactNo(String contactNo) {
    RegExp validContactNo = RegExp("[0-9]{10}");

    return validContactNo.hasMatch(contactNo);
  }
}
