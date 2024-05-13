import 'package:flutter/material.dart';

class OrganizationCard extends StatefulWidget {
  final String organizationName, aboutOrganization;
  const OrganizationCard(
      {required this.organizationName,
      required this.aboutOrganization,
      super.key});

  @override
  State<OrganizationCard> createState() => _OrganizationCardState();
}

class _OrganizationCardState extends State<OrganizationCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        clipBehavior: Clip.antiAlias,
        elevation: 5.0,
        color: Colors.blue,
        child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, "/donate-page");
            },
            splashColor: Colors.white,
            child: Container(
                height: 200,
                width: 200,
                padding: const EdgeInsets.all(20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                          widget.organizationName),
                      Text(
                          style: const TextStyle(
                              color: Colors.black,
                              fontStyle: FontStyle.italic,
                              fontSize: 18),
                          widget.aboutOrganization)
                    ]))));
  }
}
