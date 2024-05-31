import "package:cmsc23_project/screens/donation_drives_page.dart";
import "package:cmsc23_project/screens/organization_page.dart";
import "package:cmsc23_project/screens/profile_page.dart";
import "package:flutter/material.dart";

class OrganizationDrawer extends StatelessWidget {
  const OrganizationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('KalingApp'),
          ),
          ListTile(
            title: const Text('Donations List'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const OrganizationPage(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Donation Drives'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const DonationDrivesPage(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Profile'),
            onTap: () {
              MaterialPageRoute(
                builder: (context) => const ProfilePage(),
              );
            },
          ),
          ListTile(
            title: const Text('Logout'),
            onTap: () {
              // TODO: logout
            },
          ),
        ],
      ),
    );
  }
}
