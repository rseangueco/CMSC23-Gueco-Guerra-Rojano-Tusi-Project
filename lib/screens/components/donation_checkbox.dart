import 'package:flutter/material.dart';

class DonationCheckbox extends StatefulWidget {
  final List<String> categories;
  const DonationCheckbox({super.key, required this.categories});

  @override
  State<DonationCheckbox> createState() => _DonationCheckboxState();
}

class _DonationCheckboxState extends State<DonationCheckbox> {

  final Map<String, bool?> _donationCheckbox = {
    "Food": false,
    "Clothes": false,
    "Cash": false,
    "Necessities": false,
    "Others": false
  };

  late final checkboxKeys = _donationCheckbox.keys.toList();

  @override
  Widget build(BuildContext context) {
     return Column(
      children: [
        const Padding(
            padding: EdgeInsets.all(10),
            child: Text("Choose type of donation:")),
        Padding(
            padding: const EdgeInsets.all(10),
            child: FormField(
              builder: (FormFieldState<bool> state) {
                return Column(
                  children: [
                    ...List<Widget>.generate(
                      checkboxKeys.length,
                      (int i) => CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(checkboxKeys[i]),
                        value: _donationCheckbox[checkboxKeys[i]],
                        onChanged: (bool? value) {
                          setState(() {
                            _donationCheckbox[checkboxKeys[i]] = value;
                          });
                        },
                      ),
                    ),
                    Visibility(
                        visible: (state.errorText == null ? false : true),
                        child: Text("${state.errorText}",
                            style: const TextStyle(color: Colors.red)))
                  ],
                );
              },
              validator: (_) {
                for (var v in _donationCheckbox.values) {
                  if (v == true) return null;
                }
                return 'Please choose one type of donation';
              },
              onSaved: (_) {
                // clears previous
                widget.categories.clear();
                for (var i = 0; i < checkboxKeys.length; i++) {
                  if (_donationCheckbox[checkboxKeys[i]] == true) {
                    widget.categories.add(checkboxKeys[i]);
                  }
                }
                print("Checkbox onSaved method triggered");
              },
            ))
      ],
    ); 
  }
}
