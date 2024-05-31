import 'package:cmsc23_project/models/donation_drive_model.dart';
import 'package:cmsc23_project/screens/donation_drive_form.dart';
import 'package:cmsc23_project/screens/donation_linking_page.dart';
import 'package:flutter/material.dart';

class DonationDriveScreenArguments {
  final DonationDrive drive;
  const DonationDriveScreenArguments({required this.drive});
}

class DonationDriveInfoPage extends StatefulWidget {
  static const routename = '/donation-drive-info2';
  final DonationDrive? drive;

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
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Donation Drive: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Expanded(child: Text(widget.drive!.title)),
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Organization: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                          child: Text(
                              "${widget.drive!.organizationId} (should get actual org name) testestestestest")), // TODO: should get actual org name
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Description: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Expanded(child: Text(widget.drive!.description)),
                    ]),
                const Divider(),
                const Text("Donation Confirmation Photos:",
                    style: TextStyle(
                        fontWeight: FontWeight.bold)), // TODO: image display
                const Divider(),
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                          onPressed: () => {
                            Navigator.push(context, 
                            MaterialPageRoute(builder: (context) => DonationLinkingPage(donationDriveId: widget.drive!.id)))
                          },
                          child: const Text("Link new donation"))),
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Color.fromARGB(255, 228, 217, 66))),
                                onPressed: () => {
                                  Navigator.push(context, 
                            MaterialPageRoute(builder: (context) => DonationDriveForm(type: "edit", title: widget.drive!.title, description: widget.drive!.description,)))
                                },
                                child: const Text("Edit information", style: TextStyle(color: Colors.white)),
                                ),
                            ElevatedButton(
                                onPressed: () => {},
                                style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Color.fromARGB(255, 255, 165, 159))),
                                child: const Text("Delete",
                                    style: TextStyle(color: Colors.white)))
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
