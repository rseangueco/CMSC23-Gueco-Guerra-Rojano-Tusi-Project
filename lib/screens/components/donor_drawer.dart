import 'package:cmsc23_project/providers/auth_provider.dart';
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class DonorDrawer extends StatelessWidget {
  final String userId;
  const DonorDrawer({required this.userId, super.key});

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
            child: Text('Elbi Donation System'),
          ),
          ListTile(
            title: const Text('Donations'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/donor-donations',
                  arguments: userId);
            },
          ),
          ListTile(
            title: const Text('Profile'),
            onTap: () {
              // Update the state of the app.
              // ...
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
