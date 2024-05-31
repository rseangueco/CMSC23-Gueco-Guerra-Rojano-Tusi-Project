import 'package:cmsc23_project/screens/components/organization_drawer.dart';
import 'package:cmsc23_project/screens/donation_info_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OrganizationPage extends StatefulWidget {
  const OrganizationPage({super.key});

  @override
  State<OrganizationPage> createState() => _OrganizationPageState();
}

class _OrganizationPageState extends State<OrganizationPage> {
  // List<Map<String, dynamic>> donations = [
  //   {'donor': 'trguerra','category': ['Food'], 'status': 'Pending'},
  //   {'donor': 'gueco','category': ['Clothes', 'Necessities'], 'status': 'Confirmed'},
  //   {'donor': 'rojano','category': ['Food', 'Cash', 'Others'], 'status': 'Complete'},
  //   {'donor': 'rojano','category': ['Necessities'], 'status': 'Cancelled'},
  // ];

  List<Map<String, dynamic>> donations = [
    {
      'userId': 'trguerra',
      'category': ['Food'],
      'weight': 5.toDouble(),
      'collectionMethod': 1,
      'photo': '<url>',
      'collectionDate': "May 31, 2024", // this
      'collectionTime': "7:41 PM", // this
      'pickupContactNo': '09123456789',
      'pickupAddress': ['address1', 'address2', 'address3'],
      'organizationId': 'org1',
      'donationDriveId': 'org1_donationdrive',
      'status': 'Pending',
    },
    {
      'userId': 'rojano',
      'category': ['Cash', 'Necessities'],
      'weight': 5.toDouble(),
      'collectionMethod': 1,
      'photo': '<url>',
      'collectionDate': "May 31, 2024", // this
      'collectionTime': "7:41 PM", // this
      'pickupContactNo': '09123456789',
      'pickupAddress': ['address1', 'address2', 'address3'],
      'organizationId': 'org1',
      'donationDriveId': 'org1_donationdrive',
      'status': 'Pending',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Donations List"),
        ),
        drawer: const OrganizationDrawer(),
        body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: donations.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
                child: ListTile(
              title: donations[index]['category'].length == 1
                  ? Text('${donations[index]['category'][0]} donation')
                  : const Text('Assorted Donation'),
              subtitle: Text('Donated by: ${donations[index]['userId']}'),
              trailing: Text('(${donations[index]['status']})'),
              leading: chooseIcon(donations[index]['category']),
              onTap: () {
                // pass data to donation info page
                // Navigator.pushNamed(context, 'donation-info',
                //     arguments: donation);
              },
            ));
          },
        ));
  }

  Text categoryString(List category) {
    String temp = "";

    for (var c in category) {
      temp = "$temp, $c";
    }

    return Text(temp);
  }

  chooseIcon(List category) {
    if (category.length != 1) {
      return const Icon(Icons.handshake);
    }

    switch (category[0]) {
      case "Food":
        return const Icon(Icons.food_bank);
      case "Clothes":
        return const FaIcon(FontAwesomeIcons.shirt);
      case "Cash":
        return const Icon(Icons.money);
      case "Necessities":
        return const FaIcon(FontAwesomeIcons.heart);
      default:
        return const Icon(Icons.handshake);
    }
  }
}
