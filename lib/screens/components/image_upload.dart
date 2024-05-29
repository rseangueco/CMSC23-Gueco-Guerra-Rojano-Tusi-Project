import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ImageUpload extends StatefulWidget {
  final String uploadLabelText;

  const ImageUpload({required this.uploadLabelText, super.key});

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;

  Future<void> _uploadImageFromCamera() async {
    final XFile? returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (returnedImage == null) return;
    setState(() {
      _selectedImage = returnedImage;
    });
  }

  Future<void> _uploadImageFromGallery() async {
    final XFile? returnedImage =
        await _picker.pickImage(source: ImageSource.gallery);

    if (returnedImage == null) return;
    setState(() {
      _selectedImage = returnedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          height: 200,
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
                  child: _selectedImage != null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontStyle: FontStyle.italic,
                                          fontSize: 12),
                                      'Tap to Replace Image')),
                              Expanded(
                                child: Image.file(File(_selectedImage!.path)),
                              )
                            ])
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(size: 40, Icons.upload),
                            Text(
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontStyle: FontStyle.italic),
                                widget.uploadLabelText)
                          ],
                        ))),
        ));
  }
}
