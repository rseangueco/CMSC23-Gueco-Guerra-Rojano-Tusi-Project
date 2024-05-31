// import 'package:cmsc23_project/models/donation_model.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class DonationLinkingPage extends StatefulWidget {
//   final String? donationDriveId;
//   const DonationLinkingPage({super.key, required this.donationDriveId});

//   @override
//   State<DonationLinkingPage> createState() => _DonationLinkingPageState();
// }


// class _DonationLinkingPageState extends State<DonationLinkingPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("Donations List"),
//         ),
//         body: ListView.builder(
//           padding: const EdgeInsets.all(8),
//           itemCount: donations.length,
//           itemBuilder: (BuildContext context, int index) {
//             return Card(
//                 child: ListTile(
//               title: donations[index].category.length == 1
//                   ? Text('${donations[index].category[0]} donation')
//                   : const Text('Assorted Donation'),
//               subtitle: Text('Donated by: ${donations[index].userId}'),
//               trailing: donations[index].donationDriveId == ""
//                   ? TextButton(
//                       child: const Text("LINK"),
//                       onPressed: () {
//                          // TODO: image picker functionality + sms after successful linking ?
//                         setState(() {
//                           donations[index].donationDriveId = widget.donationDriveId;
//                         });
//                       },
//                     )
//                   : IconButton(icon: const Icon(Icons.check), onPressed: (){
//                     setState(() {
//                       donations[index].donationDriveId = "";
//                     });
//                   },),
//               leading: chooseIcon(donations[index].category),
//             ));
//           },
//         ));
//   }

//   chooseIcon(List category) {
//     if (category.length != 1) {
//       return const Icon(Icons.handshake);
//     }

//     switch (category[0]) {
//       case "Food":
//         return const Icon(Icons.food_bank);
//       case "Clothes":
//         return const FaIcon(FontAwesomeIcons.shirt);
//       case "Cash":
//         return const Icon(Icons.money);
//       case "Necessities":
//         return const FaIcon(FontAwesomeIcons.heart);
//       default:
//         return const Icon(Icons.handshake);
//     }
//   }
// }
