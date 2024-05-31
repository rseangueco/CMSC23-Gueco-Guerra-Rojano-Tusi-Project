import 'package:flutter/material.dart';

class ScreenArguments {
  final Map<String, dynamic> donation;
  const ScreenArguments({required this.donation});
}

class DonationInfoPage extends StatefulWidget {
  static const routename = '/donation-info2';
  final Map<String, dynamic>? donation;

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
    "Cancelled"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: widget.donation!['category'].length == 1
              ? Text("${widget.donation!['category'][0]} donation")
              : const Text("Assorted donation"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "Donation Type: ${categoryString(widget.donation!['category'])}"),
                Text("Donor: ${widget.donation!['userId']}"),
                Text("Weight: ${widget.donation!['weight']} kg"),
                Text("Collection Method: ${widget.donation!['collectionMethod'] == 1 ? "For pickup" : "For drop-off"}"),
                Text("Photo: ${widget.donation!['photo']}"),
                Text(
                    "Collection Date: ${widget.donation!['collectionDate']}"),
                Text(
                    "Collection Time: ${widget.donation!['collectionTime']}"),
                const Divider(),
                Text(
                    "Contact Number for Pickup: ${widget.donation!['pickupContactNo']}"),
                const Text("Address for Pickup:"),
                ...widget.donation!['pickupAddress'].map((e) => Text(e)).toList(),
                const Divider(),
                Text("Organization: ${widget.donation!['organizationId']}"), // TODO: get org name, donation drive name
                Text("Donation Drive: ${widget.donation!['donationDriveId']}"),
                const Text("Status:"),
                DropdownButton<String>(
                  value: widget.donation!['status'],
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      widget.donation!['status'] = value;
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
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                        onPressed: () => {
                              // TODO: change status here

                              Navigator.pop(context)
                            },
                        child: const Text("Confirm Changes")))
              ],
            )));
  }

  String categoryString(List category) {
    String str = category.join(', ');
    return str;
  }
}
