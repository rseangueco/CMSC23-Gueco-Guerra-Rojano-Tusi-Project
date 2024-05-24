import 'package:cmsc23_project/providers/organization_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import '../providers/auth_provider.dart';
import '../screens/login_page.dart';
import '../firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:  DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: ((context) => AuthProvider())),
      ChangeNotifierProvider(create: ((context) => OrganizationProvider()))
      ],
      child: RootWidget()
      )
  );
}

class RootWidget extends StatelessWidget {
  const RootWidget({super.key});

  // Root widget for the project
  // Initial route leads to login screen
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Elbi Donation System',
      initialRoute: '/',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => const LoginPage(),
      },
    );
  }
}


