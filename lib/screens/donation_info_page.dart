import 'package:flutter/material.dart';

class ScreenArguments {
  final Map<String, String> donation;
  const ScreenArguments({required this.donation});
}

class DonationInfoPage extends StatefulWidget {
  static const routename = '/donation-info2';
  final Map<String, String>? donation;

  const DonationInfoPage({super.key, this.donation});

  @override
  State<DonationInfoPage> createState() => _DonationInfoPageState();
}

class _DonationInfoPageState extends State<DonationInfoPage> {
  static final List<String> _dropdownOptions = [
    "Pending",
    "Confirmed",
    "Scheduled for Pick-up",
    "Complete",
    "Canceled"
  ];

  String dropdownValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${widget.donation!['category']} donation"),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Donation Type: ${widget.donation!['category']}"),
                Text("Donor: ${widget.donation!['donor']}"),
                Text("Status:"),
                DropdownButton<String>(
                  value: widget.donation!['status'],
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                  items: _dropdownOptions.map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                ),
                ElevatedButton(
                    onPressed: () => {Navigator.pop(context)},
                    child: Text("Return"))
              ],
            )));
  }
}
