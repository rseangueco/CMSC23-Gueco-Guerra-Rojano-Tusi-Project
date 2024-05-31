import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cmsc23_project/utils/image_converter.dart';

class ProofUpload extends StatefulWidget {
  final String uploadLabelText;
  final Function callback;

  const ProofUpload(
      {required this.uploadLabelText, required this.callback, super.key});

  @override
  State<ProofUpload> createState() => _ProofUploadState();
}

class _ProofUploadState extends State<ProofUpload> {
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;

  Future<void> _uploadImageFromCamera() async {
    final XFile? returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (returnedImage == null) return;
    setState(() {
      _selectedImage = returnedImage;
    });

    String convertedImage =
        await ImageConverter().convertToBase64(File(returnedImage.path));

    widget.callback({'proof': convertedImage, 'name': returnedImage.name});
  }

  Future<void> _uploadImageFromGallery() async {
    final XFile? returnedImage =
        await _picker.pickImage(source: ImageSource.gallery);

    if (returnedImage == null) return;
    setState(() {
      _selectedImage = returnedImage;
    });

    String convertedImage =
        await ImageConverter().convertToBase64(File(returnedImage.path));

    widget.callback({'proof': convertedImage, 'name': returnedImage.name});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          height: 100,
          alignment: Alignment.center,
          color: const Color.fromRGBO(247, 242, 249, 1),
          child: Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              child: InkWell(
                  onTap: () => showDialog(
                        context: context,
                        builder: (BuildContext context) => Padding(
                            padding: const EdgeInsets.all(20),
                            child: AlertDialog(
                              titlePadding: const EdgeInsets.all(10),
                              backgroundColor:
                                  const Color.fromRGBO(247, 242, 249, 1),
                              title: const Center(
                                  child: Text(
                                      style: TextStyle(fontSize: 20),
                                      'Select Image From')),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    _uploadImageFromCamera();
                                  },
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                          color: Colors.black,
                                          Icons.add_a_photo),
                                      Text(
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18),
                                          'Take a Photo')
                                    ],
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    _uploadImageFromGallery();
                                  },
                                  child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                            color: Colors.black,
                                            Icons.add_photo_alternate_outlined),
                                        Text(
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18),
                                            'Select from Gallery')
                                      ]),
                                ),
                              ],
                            )),
                      ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(size: 40, Icons.upload),
                      const SizedBox(height: 10),
                      Text(
                          style: const TextStyle(
                              color: Colors.black, fontStyle: FontStyle.italic),
                          widget.uploadLabelText)
                    ],
                  ))),
        ));
  }
}
