import "package:cmsc23_project/providers/auth_provider.dart";
import "package:cmsc23_project/screens/donation_drives_page.dart";
import "package:cmsc23_project/screens/organization_page.dart";
import "package:cmsc23_project/screens/profile_page.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class OrganizationDrawer extends StatelessWidget {
  final String userId;
  const OrganizationDrawer({required this.userId, super.key});

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
            title: const Text('Donations'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/org-home', arguments: userId);
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
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Logout'),
            onTap: () {
              context.read<AuthProvider>().signOut();
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],
      ),
    );
  }
}
