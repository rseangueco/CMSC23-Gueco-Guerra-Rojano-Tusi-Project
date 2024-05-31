import 'package:cmsc23_project/models/donation_model.dart';
import 'package:cmsc23_project/providers/donation_provider.dart';
import 'package:cmsc23_project/utils/image_converter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DonationInfoPage extends StatefulWidget {
  const DonationInfoPage({
    super.key,
  });

  @override
  State<DonationInfoPage> createState() => _DonationInfoPageState();
}

class _DonationInfoPageState extends State<DonationInfoPage> {
  static final List<String> _dropdownOptions = [
    "Pending",
    "Confirmed",
    "Scheduled for Pick-up",
    "Complete",
    "Canceled"
  ];
  late Donation donation;

  @override
  Widget build(BuildContext context) {
    donation = ModalRoute.of(context)!.settings.arguments as Donation;
    // String donationPhoto = ImageConverter().decodeBase64(donation.photo!);
    return Scaffold(
        appBar: AppBar(
          title: donation.category.length == 1
              ? Text("${donation.category[0]} donation")
              : const Text("Assorted donation"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Donation Type: ${categoryString(donation.category)}"),
                Text("Donor: ${donation.username}"),
                Text("Weight: ${donation.weight} kg"),
                Text(
                    "Collection Method: ${donation.collectionMethod == 1 ? "For pickup" : "For drop-off"}"),
                // Expanded(child: Image.network(donationPhoto)),
                Text("Collection Date: ${donation.collectionDate}"),
                Text("Collection Time: ${donation.collectionTime}"),
                const Divider(),
                donation.collectionMethod == 1
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                              "Contact Number for Pickup: ${donation.pickupContactNo}"),
                          const Text("Address for Pickup:"),
                          ...donation.pickupAddress!.map((e) => Text(e)),
                        ],
                      )
                    : Container(),

                const Divider(),
                // Text(
                //     "Organization: ${donation.organizationId}"),  TODO: get org name, donation drive name
                // Text("Donation Drive: ${widget.donation!['donationDriveId']}"),
                const Text("Status:"),
                DropdownButton<String>(
                  value: donation.status,
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      donation.status = value!;
                    });
                  },
                  items: _dropdownOptions.map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                ),
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                        onPressed: () async {
                          final result = await context
                              .read<DonationProvider>()
                              .updateStatus(donation.id!, 'Canceled');
                          if (context.mounted) {
                            if (result['success'] == true) {
                              final message = SnackBar(
                                content: Text(result['message']),
                                backgroundColor: Colors.green,
                                elevation: 10,
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.all(5),
                              );
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(message);
                            }
                          }
                        },
                        child: const Text("Confirm Changes")))
              ],
            )));
  }

  String categoryString(List category) {
    String str = category.join(', ');
    return str;
  }
}
