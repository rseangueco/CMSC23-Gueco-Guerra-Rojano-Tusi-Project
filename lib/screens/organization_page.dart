import 'package:cmsc23_project/providers/donation_provider.dart';
import 'package:cmsc23_project/screens/components/donor_drawer.dart';
import 'package:cmsc23_project/screens/components/organization_drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23_project/models/donation_model.dart';

class OrganizationPage extends StatefulWidget {
  const OrganizationPage({super.key});

  @override
  State<OrganizationPage> createState() => _OrganizationPageState();
}

class _OrganizationPageState extends State<OrganizationPage> {
  late String userId;

  @override
  Widget build(BuildContext context) {
    userId = ModalRoute.of(context)!.settings.arguments as String;
    // Access the donor's donations in the provider
    Stream<QuerySnapshot> organizationDonationStream =
        context.watch<DonationProvider>().fetchOrganizationDonations(userId);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Donations'),
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        drawer: OrganizationDrawer(userId: userId),
        body: StreamBuilder(
          stream: organizationDonationStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Error encountered! ${snapshot.error}"),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text("No Donations Found"),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (BuildContext context, int index) {
                Donation donation = Donation.fromJson(
                    snapshot.data?.docs[index].data() as Map<String, dynamic>);
                print(donation.id);
                donation.id = snapshot.data?.docs[index].id;
                return Card(
                    child: ListTile(
                  title: donation.category.length == 1
                      ? Text('${donation.category[0]} donation')
                      : const Text('Assorted Donation'),
                  subtitle: Text('Donated by: ${donation.username}'),
                  trailing: Text('(${donation.status})'),
                  leading: chooseIcon(donation.category),
                  onTap: () {
                    // pass data to donation info page
                    Navigator.pushNamed(context, 'donation-info',
                        arguments: donation);
                  },
                ));
              },
            );
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
