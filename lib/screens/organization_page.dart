import 'package:cmsc23_project/components/organization_drawer.dart';
import 'package:flutter/material.dart';

class OrganizationPage extends StatefulWidget {
  const OrganizationPage({super.key});

  @override
  State<OrganizationPage> createState() => _OrganizationPageState();
}

class _OrganizationPageState extends State<OrganizationPage> {
  List<Map<dynamic, dynamic>> donations = [
    {'type': 'Food', 'status': 'Pending'},
    {'type': 'Clothes', 'status': 'Confirmed'},
    {'type': 'Cash', 'status': 'Complete'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Donations List"),
        ),
        drawer: OrganizationDrawer(),
        body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: donations.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
                child: ListTile(
              title: Text('${donations[index]['type']} donation'),
              trailing: Text('(${donations[index]['status']})'),
              onTap: () {},
            ));
          },
        ));
  }
}
