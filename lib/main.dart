import 'package:cmsc23_project/screens/donation_drive_info_page.dart';
import 'package:cmsc23_project/screens/donation_info_page.dart';
import 'package:cmsc23_project/screens/organization_page.dart';
import 'package:flutter/material.dart';
import 'screens/login_page.dart';

void main() async {
  runApp(const RootWidget());
}

class RootWidget extends StatelessWidget {
  const RootWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Root',
      initialRoute: '/org-page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => const LoginPage(),
        '/org-page': (context) => const OrganizationPage(),
        '/donation-info': (context) => const DonationInfoPage(),
        '/donation-drive-info': (context) => const DonationDriveInfoPage()
      },
      onGenerateRoute: (settings) {
        if (settings.name == DonationInfoPage.routename) {
          final args = settings.arguments as ScreenArguments;
          return MaterialPageRoute(builder: (context) {
            return DonationInfoPage(donation: args.donation);
          });
        }else if (settings.name == DonationDriveInfoPage.routename) {
          final args = settings.arguments as DonationDriveScreenArguments;
          return MaterialPageRoute(builder: (context) {
            return DonationDriveInfoPage(drive: args.drive);
          });
        }
        return null;
      },
    );
  }
}
