import 'dart:io';

import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mamamia_uniproject/Auth/model/model.dart';
import 'package:mamamia_uniproject/main.dart';

class ImagePickingDialog extends StatefulWidget {
  const ImagePickingDialog({super.key});

  @override
  State<ImagePickingDialog> createState() => _ImagePickingDialogState();
}

class _ImagePickingDialogState extends State<ImagePickingDialog> {
  Future pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage == null) return;
    _selectedImage = File(returnedImage.path);
    giveselectedImage(_selectedImage!);
    Navigator.pop(context);
  }

  Future pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage == null) return;

    _selectedImage = File(returnedImage.path);
    giveselectedImage(_selectedImage!);
    Navigator.pop(context);
  }

  void giveselectedImage(File img) {
    Get.find<Model>().changeImage(img);
  }

  File? _selectedImage;
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: Model(),
        builder: (controller) => Dialog(
              child: SizedBox(
                width: screenWidth(context) * 0.5,
                height: screenHeight(context) * 0.25,
                child: SimpleDialog(
                  contentPadding: const EdgeInsets.all(0),
                  children: [
                    ListTile(
                      iconColor: Theme.of(context).colorScheme.primary,
                      leading: const Icon(FontAwesomeIcons.image),
                      title: const Text("Gallery Image"),
                      onTap: pickImageFromGallery,
                    ),
                    ListTile(
                      iconColor: Theme.of(context).colorScheme.primary,
                      leading: const Icon(FontAwesomeIcons.camera),
                      title: const Text("Camera Image"),
                      onTap: pickImageFromCamera,
                      // controller.uploadImageRequest(image);
                    ),
                  ],
                ),
              ),
            ));
  }
}
