import 'package:cmsc23_project/screens/components/proof_upload.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:cmsc23_project/models/userdetails_model.dart';
import 'package:cmsc23_project/providers/auth_provider.dart';
import 'package:cmsc23_project/providers/organization_provider.dart';
import 'dart:async';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _signupFormKey = GlobalKey<FormState>();
  List<String> types = <String>['Donor', 'Organization'];
  late String signUpType = types.first;
  String? _usernameErrorMessage;
  String? _passwordErrorMessage;
  List<String> _proofsName = [];
  List<String> _legitimacyProofs = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController orgNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController contactNoController = TextEditingController();
  final List<TextEditingController> _addressControllers = [
    TextEditingController()
  ];

  // final List<TextEditingController> _proofControllers = [TextEditingController()];

  final completer = Completer<String?>();

  bool isValidContactNo(String contactNo) {
    RegExp validContactNo = RegExp("[0-9]{10}");

    return validContactNo.hasMatch(contactNo);
  }

  bool showProofErrorMessage = false;

  @override
  Widget build(BuildContext context) {
    final signUpTypeSelect = DropdownMenu<String>(
        initialSelection: signUpType,
        label: const Text('Sign up as:'),
        dropdownMenuEntries:
            types.map<DropdownMenuEntry<String>>((String value) {
          return DropdownMenuEntry<String>(value: value, label: value);
        }).toList(),
        onSelected: (String? value) {
          setState(() {
            signUpType = value!;
          });
        });

    final name = TextFormField(
        key: const Key('nameField'),
        controller: nameController,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.accessibility),
          hintText: "Name",
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "This field is required";
          } else {
            return null;
          }
        });

    final orgName = TextFormField(
        key: const Key('orgNameField'),
        controller: orgNameController,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.group),
          hintText: "Organization Name",
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "This field is required";
          } else {
            return null;
          }
        });

    final username = TextFormField(
        key: const Key('usernameField'),
        controller: usernameController,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          hintText: "Username",
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            _usernameErrorMessage = "This field is required";
          } else if (_usernameErrorMessage == "Username is already in use.") {
            return _usernameErrorMessage;
          } else {
            _usernameErrorMessage = null;
          }

          return _usernameErrorMessage;
        });

    final password = TextFormField(
        key: const Key('passwordField'),
        controller: passwordController,
        obscureText: true,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.key),
          hintText: "Password",
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            _passwordErrorMessage = "This field is required";
          } else if (_passwordErrorMessage ==
              "Password must be at least 6 characters.") {
            return _passwordErrorMessage;
          } else {
            _passwordErrorMessage = null;
          }

          return _passwordErrorMessage;
        });

    final contactNo = TextFormField(
        key: const Key('contactNoField'),
        controller: contactNoController,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.contact_phone),
          hintText: "Contact No",
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "This field is required";
          } else if (!isValidContactNo(value)) {
            return "Invalid form. Please enter an 11 digit contact number.";
          } else {
            return null;
          }
        });

    // Address and proof of autheticity fields allow for multiple user inputs using listbuilder

    final address = ListView.builder(
        shrinkWrap: true,
        itemCount: _addressControllers.length,
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Expanded(
                  child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                        controller: _addressControllers[index],
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.location_on),
                          hintText: "Address",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "This field is required";
                          } else {
                            return null;
                          }
                        }),
                  ),
                  if (index > 0)
                    IconButton(
                      icon: const Icon(Icons.remove_circle),
                      onPressed: () {
                        setState(() {
                          _addressControllers.removeAt(index);
                        });
                      },
                    ),
                ],
              )));
        });

    final addAddressButton = ElevatedButton(
      onPressed: () {
        setState(() {
          _addressControllers.add(TextEditingController());
        });
      },
      child: const Text('Add Address'),
    );

    final proofs = ListView.builder(
        shrinkWrap: true,
        itemCount: _proofsName.length,
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.all(5),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Expanded(child: Text(_proofsName[index])),
                IconButton(
                  icon: const Icon(Icons.remove_circle),
                  onPressed: () {
                    setState(() {
                      _proofsName.removeAt(index);
                    });
                  },
                ),
              ]));
        });

    // final addProofButton = ElevatedButton(
    //   onPressed: () {
    //     setState(() {
    //       _proofControllers.add(TextEditingController());
    //     });
    //   },
    //   child: const Text('Add Proof'),
    // );

    // final proof = ListView.builder(
    //     shrinkWrap: true,
    //     itemCount: _proofControllers.length,
    //     itemBuilder: (context, index) {
    //       return Padding(
    //           padding: const EdgeInsets.all(10.0),
    //           child: Expanded(
    //               child: Row(children: [
    //             Expanded(
    //                 child: TextFormField(
    //                     controller: _proofControllers[index],
    //                     decoration: const InputDecoration(
    //                       prefixIcon: Icon(Icons.note),
    //                       hintText: "Proof of Legitimacy",
    //                     ),
    //                     validator: (value) {
    //                       if (value == null || value.isEmpty) {
    //                         return "This field is required";
    //                       } else {
    //                         return null;
    //                       }
    //                     })),
    //             if (index > 0)
    //               IconButton(
    //                 icon: const Icon(Icons.remove_circle),
    //                 onPressed: () {
    //                   setState(() {
    //                     _proofControllers.removeAt(index);
    //                   });
    //                 },
    //               ),
    //           ])));
    //     });

    final signUpButton = Padding(
      key: const Key('signUpButton'),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        ),
        onPressed: () async {
          _usernameErrorMessage = null;
          _passwordErrorMessage = null;

          _signupFormKey.currentState!.validate();

          if (signUpType == 'Donor') {
            if (_usernameErrorMessage == null &&
                _passwordErrorMessage == null) {
              UserDetails userDetails = UserDetails(
                username: usernameController.text,
                name: nameController.text,
                contactNo: contactNoController.text,
                address: _addressControllers
                    .map((controller) => controller.text)
                    .toList(),
                type: signUpType,
              );
              final usernameAsEmail =
                  '${usernameController.text}@donationsampledomain.com';

              var signupResult = await context.read<AuthProvider>().signUp(
                  usernameAsEmail, passwordController.text, userDetails);

              if (signupResult['error'] == 'weak-password') {
                _passwordErrorMessage =
                    'Password must be at least 6 characters.';
              } else if (signupResult['error'] == 'email-already-in-use') {
                _usernameErrorMessage = 'Username is already in use.';
              }
              if (signupResult['error'] == null ||
                  signupResult['error'] == '') {
                if (_signupFormKey.currentState!.validate()) {
                  if (context.mounted) Navigator.pop(context);
                }
              }
            }
          } else {
            if (_legitimacyProofs.isEmpty) {
              setState(() {
                showProofErrorMessage = true;
              });
            } else {
              setState(() {
                showProofErrorMessage = false;
              });
              if (_usernameErrorMessage == null &&
                  _passwordErrorMessage == null) {
                UserDetails userDetails = UserDetails(
                  username: usernameController.text,
                  name: nameController.text,
                  contactNo: contactNoController.text,
                  address: _addressControllers
                      .map((controller) => controller.text)
                      .toList(),
                  type: signUpType,
                );
                final usernameAsEmail =
                    '${usernameController.text}@donationsampledomain.com';

                var signupResult = await context.read<AuthProvider>().signUp(
                    usernameAsEmail, passwordController.text, userDetails);

                if (signupResult['error'] == 'weak-password') {
                  _passwordErrorMessage =
                      'Password must be at least 6 characters.';
                } else if (signupResult['error'] == 'email-already-in-use') {
                  _usernameErrorMessage = 'Username is already in use.';
                }

                if ((signupResult['error'] == null ||
                        signupResult['error'] == '') &&
                    signUpType == 'Organization') {
                  String userID = signupResult['userId'];
                  if (context.mounted) {
                    String? orgId = '';

                    context.read<OrganizationProvider>().addOrganization(
                        orgNameController.text, _legitimacyProofs, userID,
                        (String? docId) {
                      completer.complete(docId);
                    });
                    orgId = await completer.future;

                    if (context.mounted) {
                      await context
                          .read<AuthProvider>()
                          .addOrgId(userID, orgId!);
                    }
                  }
                }

                if (_signupFormKey.currentState!.validate()) {
                  if (context.mounted) Navigator.pop(context);
                }
              }
            }
          }
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
            Form(
                key: _signupFormKey,
                child: SingleChildScrollView(
                  child: Column(children: [
                    signUpTypeSelect,
                    name,
                    (signUpType == 'Organization') ? orgName : Container(),
                    username,
                    password,
                    contactNo,
                    address,
                    addAddressButton,
                    (signUpType == 'Organization')
                        ? ProofUpload(
                            uploadLabelText: 'Add Proof of Legitimacy',
                            callback: (Map<String, String> proof) {
                              setState(() {
                                _legitimacyProofs.add(proof['proof']!);
                                _proofsName.add(proof['name']!);
                                showProofErrorMessage = false;
                              });
                            })
                        : Container(),
                    showProofErrorMessage ? proofErrorMessage : Container(),
                    (signUpType == 'Organization') ? proofs : Container(),
                    signUpButton,
                    backButton
                  ]),
                ))
          ],
        ),
      ),
    );
  }

  Widget get proofErrorMessage => const Padding(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Text(
          "Proof of legitimacy is required!",
          style: TextStyle(color: Colors.red),
        ),
      );
}
