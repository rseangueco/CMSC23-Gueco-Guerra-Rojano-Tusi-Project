import 'package:cmsc23_project/screens/donor_homepage_components/organization_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23_project/models/organization_model.dart';
import 'package:cmsc23_project/providers/organization_provider.dart';

class DonorHomePage extends StatefulWidget {
  const DonorHomePage({super.key});

  @override
  State<DonorHomePage> createState() => _DonorHomePageState();
}

class _DonorHomePageState extends State<DonorHomePage> {
  @override
  Widget build(BuildContext context) {
    // Access the list of organizations in the provider
    Stream<QuerySnapshot> organizationStream =
        context.watch<OrganizationListProvider>().organization;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Donor'),
        ),
        body: StreamBuilder(
          stream: organizationStream,
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
                child: Text("No Organizations Found"),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: ((context, index) {
                Organization organization = Organization.fromJson(
                    snapshot.data?.docs[index].data() as Map<String, dynamic>);
                organization.id = snapshot.data?.docs[index].id;
                return OrganizationCard(
                    organizationName: organization.name,
                    aboutOrganization: 'About Organization');
              }),
            );
          },
        ));
  }
}
