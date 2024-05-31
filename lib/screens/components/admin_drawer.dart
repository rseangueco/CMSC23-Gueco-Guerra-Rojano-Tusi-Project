import "package:cmsc23_project/screens/admin_homepage.dart";
import "package:flutter/material.dart";

class AdminDrawer extends StatelessWidget {
  const AdminDrawer({super.key});

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
            title: const Text('View Organizations & Donations'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AdminPage(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('View Donors'),
            onTap: () {
              Navigator.pop(context);
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => const AdminViewDonors(),
              //   ),
              // );
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
