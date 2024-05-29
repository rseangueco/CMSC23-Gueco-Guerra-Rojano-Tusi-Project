import '../providers/auth_provider.dart' as ap;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRouteGuard extends StatelessWidget {
  final Widget child;
  final String requiredRole;

  const AuthRouteGuard({required this.child, required this.requiredRole, super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<ap.AuthProvider>(context);

    return StreamBuilder<User?>(
      stream: authProvider.userStream,
      builder: (context, snapshot) {
        print(authProvider.userStream);
        print('Connection state: ${snapshot.connectionState}');
        print('Snapshot data: ${snapshot.data}');

        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          print('User: $user');
          print('User Details: ${authProvider.userDetails}');

          if (user == null) {
            return const Scaffold(
              body: Center(child: Text('Access denied: User not logged in'))
            );
          } else if (requiredRole.isNotEmpty && authProvider.userDetails?.type != requiredRole) {
            return const Scaffold(
              body: Center(child: Text('Access denied: Insufficient permissions')),
            );
          } else {
            return child;
          }
        } else {
          return const Scaffold();
        }
      }
    );
  }
}