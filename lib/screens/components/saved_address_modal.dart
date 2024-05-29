import 'package:flutter/material.dart';

class SavedAddressModal extends StatefulWidget {
  const SavedAddressModal({super.key});

  @override
  State<SavedAddressModal> createState() => _SavedAddressModalState();
}

class _SavedAddressModalState extends State<SavedAddressModal> {
  static final List<String> addressList = [
    "modal_address1",
    "modal_address2",
    "modal_address3"
  ];

  final Map<String, bool?> addressCheckbox = {
    for (var a in addressList) a: false
  };

  // modal with checkboxes that has addresses
  // add / cancel button bottom left
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Saved Addresses"),
      content: Column(
          mainAxisSize: MainAxisSize.min,
          children: List<Widget>.generate(
            addressList.length,
            (int i) => CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(addressList[i]),
              value: addressCheckbox[addressList[i]],
              onChanged: (bool? value) {
                setState(() {
                  addressCheckbox[addressList[i]] = value;
                });
              },
            ),
          )),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            // add address in text fields
            List<String> savedAddresses = [];

            for (var i = 0; i < addressList.length; i++) {
              if (addressCheckbox[addressList[i]] == true) {
                savedAddresses.add(addressList[i]);
              }
            }
            Navigator.pop(context, savedAddresses);
          },
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text("Add"),
        ),
      ],
    );
  }
}
