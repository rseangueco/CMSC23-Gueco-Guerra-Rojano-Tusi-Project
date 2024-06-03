import 'package:cmsc23_project/models/organization_model.dart';
import 'package:cmsc23_project/models/userdetails_model.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // final user = UserDetails(
  //   username: 'trguerra',
  //   name: 'Tom Guerra',
  //   contactNo: '09123456789',
  //   address: ['addresss1', 'address2', 'address3'],
  //   type: "Donor",
  // );

  UserDetails user = UserDetails(
      username: 'org_username',
      name: 'test_org',
      contactNo: '09123456789',
      address: ['address1', 'address2', 'address3'],
      type: "Organization",
      organizationId: "org_id");

  Organization org = Organization(
      userId: 'org_id',
      name: 'test_org',
      // about: "about..",
      proofs: [],
      donationStatus: 'Open',
      approvalStatus: 'Approved');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Container(
        margin: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                "Username: ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(user.username, style: const TextStyle(fontSize: 20)),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                "Name: ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(user.name, style: const TextStyle(fontSize: 20)),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                "Contact No.: ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(user.contactNo, style: const TextStyle(fontSize: 20)),
            ]),
            const Text(
              "Address/es: ",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ...user.address
                .map((e) => Text(e, style: const TextStyle(fontSize: 15))),
            Builder(builder: (context) {
              if (user.type == "Organization") {
                return Column(children: [
                  const Divider(),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Text(
                      "Organization Name: ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(org.name, style: const TextStyle(fontSize: 20)),
                  ]),
                  const Text(
                    "About the organization: ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(org.about ?? "No about for this organization.",
                      style: const TextStyle(fontSize: 15)),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Text(
                      "Status for Donations: ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(org.donationStatus,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: org.donationStatus == "Open"
                                ? Colors.green
                                : Colors.red)),
                  ]),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            // TODO: update donation status
                            setState(() {
                              if (org.donationStatus == "Closed"){
                                org.donationStatus = "Open";
                              }else{
                                org.donationStatus = "Closed";
                              }
                            });
                          });
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                org.donationStatus == "Closed"
                                    ? const Color.fromARGB(255, 47, 199, 88)
                                    : const Color.fromARGB(255, 199, 47, 47))),
                        child: Text(
                            org.donationStatus == "Open"
                                ? "Close Donations"
                                : "Open Donations",
                            style: const TextStyle(color: Colors.white))),
                  ),
                  const Divider(),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Text(
                      "Approval Status: ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(org.approvalStatus,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: org.approvalStatus == "Approved"
                                ? Colors.green
                                : Colors.red)),
                  ]),
                ]);
              }
              return const SizedBox(width: 0, height: 0);
            })
          ],
        ),
      ),
    );
  }
}
