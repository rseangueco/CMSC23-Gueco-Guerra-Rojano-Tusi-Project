import 'package:cmsc23_project/components/organization_drawer.dart';
import 'package:cmsc23_project/screens/donation_info_page.dart';
import 'package:flutter/material.dart';

class OrganizationPage extends StatefulWidget {
  const OrganizationPage({super.key});

  @override
  State<OrganizationPage> createState() => _OrganizationPageState();
}

class _OrganizationPageState extends State<OrganizationPage> {
  List<Map<String, String>> donations = [
    {'donor': 'trguerra','category': 'Food', 'status': 'Pending'},
    {'donor': 'gueco','category': 'Clothes', 'status': 'Confirmed'},
    {'donor': 'rojano','category': 'Cash', 'status': 'Complete'},
    // {'donor': 'rojano','category': 'Necessities', 'status': 'Cancelled'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Donations List"),
        ),
        drawer: OrganizationDrawer(),
        body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: donations.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
                child: ListTile(
              title: Text('${donations[index]['category']} donation'),
              subtitle: Text('Donated by: ${donations[index]['donor']}'),
              trailing: Text('(${donations[index]['status']})'),
              // leading: Icon(donations[index]['category'] == 'Food' ? Icons.food_bank: (donations[index]['category'] == 'Clothes' ? Icons.person: Icons.money)),
              leading: chooseIcon(donations[index]['category']),
              onTap: () {
                  // pass data to donation info page
                Navigator.pushNamed(context, DonationInfoPage.routename, 
                  arguments: ScreenArguments(
                    donation: donations[index]
                  ));
              },  
            ));
          },
        ));
  }

  Icon chooseIcon(String? category){
    switch(category){
      case "Food":
        return Icon(Icons.food_bank);
      case "Clothes":
        return Icon(Icons.person);
      case "Cash":
        return Icon(Icons.money);
      default:
        return Icon(Icons.alarm);
    }
  }
}
