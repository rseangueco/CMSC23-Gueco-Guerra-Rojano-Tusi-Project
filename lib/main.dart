import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cmsc23_project/providers/auth_provider.dart';
import 'package:cmsc23_project/screens/login_page.dart';
import 'package:cmsc23_project/screens/donate_page.dart';
import 'package:cmsc23_project/screens/donor_homepage.dart';
import 'package:cmsc23_project/providers/organization_provider.dart';
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
      initialRoute: '/donors-page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => const LoginPage(),
        '/donors-page': (context) => const DonorHomePage(),
        '/donate-page': (context) => const DonatePage(),
      },
    );
  }
}
