// import 'package:cmsc23_project/models/donation_drive_model.dart';
// import 'package:cmsc23_project/screens/components/organization_drawer.dart';
// import 'package:cmsc23_project/screens/donation_drive_form.dart';
// import 'package:cmsc23_project/screens/donation_drive_info_page.dart';
// import 'package:flutter/material.dart';

// class DonationDrivesPage extends StatefulWidget {
//   const DonationDrivesPage({super.key});

//   @override
//   State<DonationDrivesPage> createState() => _DonationDrivesPageState();
// }

// class _DonationDrivesPageState extends State<DonationDrivesPage> {
//   // List<Map<String, String>> donationDrives = [
//   //   {
//   //     'organization': 'org1',
//   //     'title': 'Food donation drive',
//   //     'description': 'for food donations'
//   //   },
//   //   {
//   //     'organization': 'org2',
//   //     'title': 'Clothes donation drive',
//   //     'description': 'for clothes donations'
//   //   },
//   //   {
//   //     'organization': 'org3',
//   //     'title': 'Healthcare donation drive',
//   //     'description':
//   //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna'
//   //   },
//   // ];

//   List<DonationDrive> donationDrives = [
//     DonationDrive(
//         id: 'drive1',
//         title: 'Food Donation Drive',
//         description: 'For food donations',
//         organizationId: 'org1',
//         photos: {},
//         donations: []),
//     DonationDrive(
//         id: 'drive2',
//         title: 'Clothes Donation Drive',
//         description: 'For clothes donations',
//         organizationId: 'org1',
//         photos: {},
//         donations: []),
//     DonationDrive(
//         id: 'drive3',
//         title: 'Healthcare donation drive',
//         description:
//             'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna',
//         organizationId: 'org1',
//         photos: {},
//         donations: []),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("Donation Drives"),
//         ),
//         drawer: const OrganizationDrawer(userId: ""),
//         body: ListView.builder(
//           padding: const EdgeInsets.all(8),
//           itemCount: donationDrives.length,
//           itemBuilder: (BuildContext context, int index) {
//             return Card(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   ListTile(
//                     title: Text(donationDrives[index].title),
//                     subtitle: Text(donationDrives[index].description),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: <Widget>[
//                       TextButton(
//                         child: const Text('VIEW'),
//                         onPressed: () {
//                           // pass data to donation info page
//                           Navigator.pushNamed(
//                               context, DonationDriveInfoPage.routename,
//                               arguments: DonationDriveScreenArguments(
//                                   drive: donationDrives[index]));
//                         },
//                       ),
//                       const SizedBox(width: 8),
//                     ],
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//         floatingActionButton: FloatingActionButton.extended(
//           onPressed: () {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) =>
//                         const DonationDriveForm(type: "create")));
//           },
//           label: const Text('Create Donation Drive'),
//           icon: const Icon(Icons.add),
//         ));
//   }
// }
