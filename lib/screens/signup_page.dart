import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget{
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  List<String> types = <String>['Donor', 'Organization'];
  late String signUpType = types.first;

  TextEditingController nameController = TextEditingController();
  TextEditingController orgNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController contactNoController = TextEditingController();
  List<TextEditingController> _addressControllers = [TextEditingController()];
  List<TextEditingController> _proofControllers = [TextEditingController()];
  
  @override
  Widget build(BuildContext context) {
    
    final signUpTypeSelect = DropdownMenu<String>(
      initialSelection: signUpType,
      label: const Text('Sign up as:'),
      dropdownMenuEntries: types.map<DropdownMenuEntry<String>>((String value){
        return DropdownMenuEntry<String>(
          value: value,
          label: value
        );
      }).toList(), 
      onSelected: (String? value) {
        setState(() {
          signUpType = value!;
        });
      }
    );

    final name = TextField(
      key: const Key('nameField'),
      controller: nameController,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.accessibility),
        hintText: "Name",
      ),
    );

    final orgName = TextField(
      key: const Key('orgNameField'),
      controller: orgNameController,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.group),
        hintText: "Organization Name",
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

    final proof = ListView.builder(
      shrinkWrap: true,
      itemCount: _proofControllers.length,
      itemBuilder: (context, index) {
        return TextField(
          controller: _proofControllers[index],
          decoration: const InputDecoration(
          prefixIcon: Icon(Icons.note),
          hintText: "Proof of Legitimacy",
        )
      );}
    );

    final addProofButton = ElevatedButton(
      onPressed: () {
        setState(() {
          _proofControllers.add(TextEditingController());
        });
      },
      child: const Text('Add Proof'),
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
            signUpTypeSelect,
            name,
            (signUpType == 'Organization') ?  orgName : Container(),
            username,
            password,
            contactNo,
            address,
            addAddressButton,
            (signUpType == 'Organization') ? proof : Container(),
            (signUpType == 'Organization') ? addProofButton : Container(),
            signUpButton,
            backButton
          ],
        ),
      ),
    );
  }

}