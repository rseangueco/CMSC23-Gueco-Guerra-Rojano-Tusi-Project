import 'package:cmsc23_project/auth_route_guard.dart';
import 'package:cmsc23_project/providers/organization_provider.dart';
import 'package:cmsc23_project/screens/donation_drive_info_page.dart';
import 'package:cmsc23_project/screens/donation_drives_page.dart';
import 'package:cmsc23_project/screens/donation_info_page.dart';
import 'package:cmsc23_project/screens/organization_page.dart';
import 'package:cmsc23_project/providers/user_details_provider.dart';
import 'package:cmsc23_project/screens/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cmsc23_project/providers/auth_provider.dart';
import 'package:cmsc23_project/screens/login_page.dart';
import 'package:cmsc23_project/screens/donate_page.dart';
import 'package:cmsc23_project/screens/donor_homepage.dart';
import 'package:cmsc23_project/providers/donation_provider.dart';
import 'package:cmsc23_project/providers/donation_drive_provider.dart';
import 'package:cmsc23_project/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: ((context) => AuthProvider())),
    ChangeNotifierProvider(create: ((context) => UserDetailsProvider())),
    ChangeNotifierProvider(create: ((context) => OrganizationProvider())),
    ChangeNotifierProvider(create: ((context) => DonationProvider())),
    ChangeNotifierProvider(create: ((context) => DonationDriveProvider()))
  ], child: RootWidget()));
}

class RootWidget extends StatelessWidget {
  const RootWidget({super.key});

  // Root widget for the project
  // Initial route leads to login screen
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Elbi Donation System',
      initialRoute: '/org-donation-drives',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => const LoginPage(),
        '/donors-page': (context) => const DonorHomePage(),
        '/donate-page': (context) => const DonatePage(),
        '/signup': (context) => const SignupPage(),
        '/org-home': (context) => const OrganizationPage(),
        '/org-donation-drives': (context) => const DonationDrivesPage()
        /*'/signup': (context) => const AuthRouteGuard(
            requiredRole: 'organization',
            child: SignupPage(), 
        )*/
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
