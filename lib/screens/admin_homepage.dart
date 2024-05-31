import 'package:cmsc23_project/models/organization_model.dart';
import 'package:cmsc23_project/screens/admin_org_info_page.dart';
import 'package:cmsc23_project/screens/components/admin_drawer.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  List<Organization> organizations = [
    Organization(
        userId: 'org1',
        name: 'org1_name',
        proofs: [],
        donationStatus: 'Open',
        approvalStatus: 'Pending'),
    Organization(
        userId: 'org2',
        about: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna',
        name: 'org2_name',
        proofs: [],
        donationStatus: 'Closed',
        approvalStatus: 'Approved'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Organizations"),
        ),
        drawer: const AdminDrawer(),
        body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: organizations.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text(organizations[index].name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(organizations[index].about ?? ""),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        child: const Text('VIEW'),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => OrganizationInfoPage(org: organizations[index])));
                        },
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            );
          },
        ),);
  }
}
