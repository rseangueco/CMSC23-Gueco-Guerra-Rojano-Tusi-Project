import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget{
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController contactNoController = TextEditingController();
  List<TextEditingController> _addressControllers = [TextEditingController()];
  
  @override
  Widget build(BuildContext context) {
    
    final name = TextField(
      key: const Key('nameField'),
      controller: nameController,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.accessibility),
        hintText: "Name",
      ),
    );

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

    final contactNo = TextField(
      key: const Key('nameField'),
      controller: contactNoController,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.contact_phone),
        hintText: "Contact No",
      ),
    );

    final address = ListView.builder(
      shrinkWrap: true,
      itemCount: _addressControllers.length,
      itemBuilder: (context, index) {
        return TextField(
          controller: _addressControllers[index],
          decoration: const InputDecoration(
          prefixIcon: Icon(Icons.location_on),
          hintText: "Address",
        )
      );}
    );

    final addAddressButton = ElevatedButton(
      onPressed: () {
        setState(() {
          _addressControllers.add(TextEditingController());
        });
      },
      child: const Text('Add Address'),
    );


    final signUpButton = Padding(
      key: const Key('signUpButton'),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        ),
        onPressed: () async {
          
        },
        child: const Text('Sign Up', style: TextStyle(color: Colors.white)),
      ),
    );

    final backButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        ),
        onPressed: () async {
          Navigator.pop(context);
        },
        child: const Text('Back', style: TextStyle(color: Colors.white)),
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
              "Sign Up",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25),
            ),
            name,
            username,
            password,
            contactNo,
            address,
            addAddressButton,
            signUpButton,
            backButton
          ],
        ),
      ),
    );
  }

}