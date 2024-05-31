import 'package:cmsc23_project/models/organization_model.dart';
import 'package:flutter/material.dart';

class OrganizationInfoPage extends StatefulWidget {
  final Organization org;
  const OrganizationInfoPage({super.key, required this.org});

  @override
  State<OrganizationInfoPage> createState() => _OrganizationInfoPageState();
}

class _OrganizationInfoPageState extends State<OrganizationInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Organization Info"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Organization Name: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Expanded(child: Text(widget.org.name)),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "About: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Expanded(child: Text(widget.org.about ?? "")),
                  ]),
              const Divider(),
              const Text(
                "Proof/s: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Divider(),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Donation Status: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Text(widget.org.donationStatus,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: widget.org.donationStatus == "Open"
                                  ? Colors.green
                                  : Colors.red)),
                    ),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Approval Status: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Text(widget.org.approvalStatus,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: widget.org.approvalStatus == "Approved"
                                  ? Colors.green
                                  : Colors.red)),
                    ),
                  ]),
              const Divider(),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      onPressed: () => {},
                      child: const Text("See Donations List"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                        onPressed: () => {},
                        style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Color.fromARGB(255, 47, 199, 88))),
                        child: const Text("Approve Organization",
                            style: TextStyle(color: Colors.white))),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                          onPressed: () => {Navigator.pop(context)},
                          child: const Text("Return")))
                ],
              ),
            ])));
  }
}
