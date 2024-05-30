import 'package:cmsc23_project/screens/components/saved_address_modal.dart';
import 'package:flutter/material.dart';

class AddressForm extends StatefulWidget {
  final List<String>? addressList;
  const AddressForm({super.key, required this.addressList});

  @override
  State<AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  final List<TextEditingController> _addressControllers = [
    TextEditingController()
  ];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < _addressControllers.length; i++) {
      _addressControllers[i].addListener(() {});
    }
  }

  @override
  void dispose() {
    for (var i = 0; i < _addressControllers.length; i++) {
      _addressControllers[i].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [address, addAddressButton, useSavedAddress]);
  }

  Widget get address => ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _addressControllers.length,
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              maxLength: 300,
              controller: _addressControllers[index],
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.location_on),
                  hintText: "Address for pickup",
                  counterText: "",
                  suffixIcon: _addressControllers.length > 1
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              _addressControllers.removeAt(index);
                            });
                          },
                          icon: const Icon(Icons.clear))
                      : null),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "This field is required";
                } else {
                  return null;
                }
              },
              onSaved: (_) {
                widget.addressList!.add(_addressControllers[index].text);
              },
            ));
      });

  Widget get addAddressButton => ElevatedButton(
        onPressed: () {
          setState(() {
            _addressControllers.add(TextEditingController());
          });
        },
        child: const Text('Add Address'),
      );

  Widget get useSavedAddress => ElevatedButton(
        onPressed: () async {
          List<String> addressModalReceiver = await showDialog(
            context: context,
            builder: (BuildContext context) => const SavedAddressModal(),
          );

          if (addressModalReceiver.isEmpty) {
            return;
          }

          setState(() {
            List<String> currentAddresses = [];
            for (var c in _addressControllers) {
              currentAddresses.add(c.text);
            }

            // remove addresses in receiever if already in fields
            var set1 = Set.from(addressModalReceiver);
            var set2 = Set.from(currentAddresses);
            addressModalReceiver = List.from(set1.difference(set2));

            int counter = 0;
            for (var controller in _addressControllers) {
              if (counter == addressModalReceiver.length) {
                break;
              }

              // if field is empty, insert saved address
              if (controller.text == "") {
                controller.text = addressModalReceiver[counter];
                counter++;
              }
            }

            if (counter < addressModalReceiver.length) {
              for (var i = counter; i < addressModalReceiver.length; i++) {
                TextEditingController temp = TextEditingController();
                temp.text = addressModalReceiver[i];
                _addressControllers.add(temp);
              }
            }
          });
        },
        child: const Text('Use Saved Addresses'),
      );
}
