import 'package:cmsc23_project/providers/user_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _HomePageState();
}

class _HomePageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showUsernameErrorMessage = false;
  bool showPasswordErrorMessage = false;
  bool showSignInErrorMessage = false;

  @override
  Widget build(BuildContext context) {
    // Text fields for username and password

    final username = TextField(
      key: const Key('usernameField'),
      controller: usernameController,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.account_circle),
        hintText: "Username",
      ),
    );

    final password = TextField(
      key: const Key('passwordField'),
      controller: passwordController,
      obscureText: true,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.key),
        hintText: "Password",
      ),
    );

    final loginButton = Padding(
      key: const Key('loginButton'),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        ),
        onPressed: () async {
          if (usernameController.text.isEmpty &&
              passwordController.text.isEmpty) {
            setState(() {
              showUsernameErrorMessage = true;
              showPasswordErrorMessage = true;
            });
          } else {
            setState(() {
              showUsernameErrorMessage = false;
              showPasswordErrorMessage = false;
            });
            if (usernameController.text.isEmpty) {
              setState(() {
                showUsernameErrorMessage = true;
              });
            } else {
              setState(() {
                showUsernameErrorMessage = false;
              });

              if (passwordController.text.isEmpty) {
                setState(() {
                  showPasswordErrorMessage = true;
                });
              } else {
                setState(() {
                  showPasswordErrorMessage = false;
                });
              }
            }
          }
          if (usernameController.text.isNotEmpty &&
              passwordController.text.isNotEmpty) {
            final usernameAsEmail =
                '${usernameController.text}@donationsampledomain.com';

            final result = await context
                .read<AuthProvider>()
                .signIn(usernameAsEmail, passwordController.text);

            print(result['message']);
            if (result['success'] == false) {
              showSignInErrorMessage = true;
            } else {
              showSignInErrorMessage = false;
              String id = result['message'];
              if (context.mounted) {
                if (id == "administrator") {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, '/admin-page', arguments: id);
                }
                final userType =
                    await context.read<UserDetailsProvider>().getUserType(id);
                print(userType);
                if (context.mounted) {
                  if (userType['success'] == true) {
                    if (userType['message'] == "Donor") {
                      Navigator.of(context).pop();
                      Navigator.pushNamed(context, '/donors-page',
                          arguments: id);
                    } else if (userType['message'] == "Organization") {
                      Navigator.of(context).pop();
                      Navigator.pushNamed(context, '/sign-up', arguments: id);
                    }
                  }
                }
              }
            }
          }
        },
        child: const Text('Log In', style: TextStyle(color: Colors.white)),
      ),
    );

    // Sign up button leads to sign up page

    final signUpButton = Padding(
      key: const Key('signUpButton'),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        ),
        onPressed: () async {
          Navigator.pushNamed(context, '/signup');
        },
        child: const Text('Sign Up', style: TextStyle(color: Colors.white)),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 40.0, right: 40.0),
          children: <Widget>[
            const Text(
              "Login",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25),
            ),
            username,
            showUsernameErrorMessage ? usernameErrorMessage : Container(),
            password,
            showPasswordErrorMessage ? passwordErrorMessage : Container(),
            loginButton,
            showSignInErrorMessage ? signInErrorMessage : Container(),
            signUpButton
          ],
        ),
      ),
    );
  }

  Widget get usernameErrorMessage => const Padding(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        child: Text(
          "Please enter your username",
          style: TextStyle(color: Colors.red),
        ),
      );

  Widget get passwordErrorMessage => const Padding(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        child: Text(
          "Please enter your password",
          style: TextStyle(color: Colors.red),
        ),
      );

  Widget get signInErrorMessage => const Padding(
        padding: EdgeInsets.only(bottom: 30),
        child: Text(
          "Invalid email or password",
          style: TextStyle(color: Colors.red),
        ),
      );
}
