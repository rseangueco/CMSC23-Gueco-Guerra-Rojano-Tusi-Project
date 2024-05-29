import 'package:flutter/material.dart';

class OrganizationCard extends StatefulWidget {
  final String organizationId,
      organizationName,
      aboutOrganization,
      donationStatus;
  const OrganizationCard(
      {required this.organizationId,
      required this.organizationName,
      required this.aboutOrganization,
      required this.donationStatus,
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
              Navigator.pushNamed(context, '/donate-page',
                  arguments: widget.organizationId);
            },
            splashColor: Colors.black,
            child: Container(
                height: 300,
                width: 200,
                padding: const EdgeInsets.all(20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                          widget.organizationName),
                      const SizedBox(height: 20),
                      Text(
                          style: const TextStyle(
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                              fontSize: 18),
                          widget.aboutOrganization),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 18),
                              "Donation Status: "),
                          widget.donationStatus == "open"
                              ? const Text(
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 18),
                                  "Open")
                              : const Text(
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 18),
                                  "Open")
                        ],
                      )
                    ]))));
  }
}
