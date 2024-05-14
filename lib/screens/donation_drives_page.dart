import 'package:cmsc23_project/components/organization_drawer.dart';
import 'package:flutter/material.dart';

class DonationDrivesPage extends StatefulWidget {
  const DonationDrivesPage({super.key});

  @override
  State<DonationDrivesPage> createState() => _DonationDrivesPageState();
}

class _DonationDrivesPageState extends State<DonationDrivesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Donation Drives"),
      ),
      drawer: OrganizationDrawer(),
    );
  }
}
