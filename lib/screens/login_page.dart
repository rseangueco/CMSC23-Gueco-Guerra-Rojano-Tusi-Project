import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _HomePageState();
}

class _HomePageState extends State<LoginPage> {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context){

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
          
        },
        child: const Text('Log In', style: TextStyle(color: Colors.white)),
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
            password,
            loginButton
          ],
        ),
      ),
    );
  }
}