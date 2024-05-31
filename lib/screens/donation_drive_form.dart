import 'package:flutter/material.dart';

class DonationDriveForm extends StatefulWidget {
  final String? type, title, description;
  const DonationDriveForm(
      {super.key, required this.type, this.title, this.description});

  @override
  State<DonationDriveForm> createState() => _DonationDriveFormState();
}

class _DonationDriveFormState extends State<DonationDriveForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String? formTitle = "";
  String? formDescription = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              "${widget.type == 'create' ? "Create" : "Edit"} Donation Drive"),
        ),
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: Column(children: [
              titleField(),
              descriptionField(),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () => {Navigator.pop(context)},
                        child: const Text("Return"),
                      ),
                      ElevatedButton(
                          onPressed: () => {
                                if (_formKey.currentState!.validate())
                                  {_formKey.currentState?.save()}
                              },
                          style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  Color.fromARGB(255, 60, 165, 44))),
                          child: const Text("Confirm Details",
                              style: TextStyle(color: Colors.white)))
                    ]),
              )
            ]))));
  }

  Widget titleField() {
    if (widget.type == 'edit') {
      titleController.text = widget.title!;
    }
    return Padding(
        padding: const EdgeInsets.all(10),
        child: TextFormField(
          maxLines: null,
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Title of donation drive",
              labelText: "Title"),
          controller: titleController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "This field is needed";
            }
            return null;
          },
        ));
  }

  Widget descriptionField() {
    if (widget.type == 'edit') {
      descriptionController.text = widget.description!;
    }

    return Padding(
        padding: const EdgeInsets.all(10),
        child: TextFormField(
          maxLines: null,
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Description of donation drive",
              labelText: "Description"),
          controller: descriptionController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "This field is needed";
            }
            return null;
          },
        ));
  }
}
