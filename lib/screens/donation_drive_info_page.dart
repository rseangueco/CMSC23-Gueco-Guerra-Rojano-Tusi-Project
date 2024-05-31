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
          title: const Text("Donation Drive Info"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Donation Drive: ${widget.drive!['title']}"),
                Text("Organization: ${widget.drive!['organization']}"),
                Text("Description: ${widget.drive!['description']}"),
                const Divider(),
                const Text(
                    "Donation Confirmation Photos:"), // TODO: implement this idk
                    const Divider(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                          onPressed: () => {},
                          child: const Text("Link new donation"))),
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                                onPressed: () => {},
                                child: const Text("Edit information")),
                            ElevatedButton(
                                onPressed: () => {},
                                style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 255, 165, 159))),
                                child: const Text("Delete", style: TextStyle(color: Colors.white)))
                          ])),
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                          onPressed: () => {Navigator.pop(context)},
                          child: const Text("Return"))),
                ])
              ],
            )));
  }
}
