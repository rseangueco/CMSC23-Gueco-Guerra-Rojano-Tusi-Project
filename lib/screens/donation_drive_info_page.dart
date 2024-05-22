import 'package:flutter/material.dart';

class DonationDriveScreenArguments {
  final Map<String, String> drive;
  const DonationDriveScreenArguments({required this.drive});
}

class DonationDriveInfoPage extends StatefulWidget {
  static const routename = '/donation-drive-info2';
  final Map<String, String>? drive;

  const DonationDriveInfoPage({super.key, this.drive});

  @override
  State<DonationDriveInfoPage> createState() => _DonationDriveInfoPageState();
}

class _DonationDriveInfoPageState extends State<DonationDriveInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Donation Drive Info"),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Donation Drive: ${widget.drive!['title']}"),
                Text("Organization: ${widget.drive!['organization']}"),
                Text("Description: ${widget.drive!['description']}"),
                Text("Donation Confirmation Photos:"),
                ElevatedButton(
                    onPressed: () => {
                          // modal for viewing?
                          // ask ma'am if linking is permanent
                        },
                    child: Text("Donations linked")),
                ElevatedButton(
                    onPressed: () => {}, child: Text("Link new donation")),
                ElevatedButton(
                    onPressed: () => {}, child: Text("Edit information")),
                ElevatedButton(
                    onPressed: () => {}, child: Text("Delete")),
                ElevatedButton(
                    onPressed: () => {Navigator.pop(context)},
                    child: Text("Return")),
              ],
            )));
  }
}
