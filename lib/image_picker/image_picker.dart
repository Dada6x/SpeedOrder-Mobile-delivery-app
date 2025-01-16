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
  File? _selectedImage;
  //! image from gallery
  Future<void> pickImageFromGallery() async {
    try {
      final returnedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (returnedImage == null) return;
      setState(() {
        _selectedImage = File(returnedImage.path);
      });
      giveselectedImage(_selectedImage!);
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to pick image from gallery: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  //! image from Camera
  Future<void> pickImageFromCamera() async {
    try {
      final returnedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (returnedImage == null) return;
      setState(() {
        _selectedImage = File(returnedImage.path);
      });
      giveselectedImage(_selectedImage!);
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to capture image from camera: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void giveselectedImage(File img) {
    Get.find<Model>().changeImage(img);
    Get.find<Model>().uploadImageRequest(img);
    Navigator.pop(context);
  }
  //! Delete image
  void deleteSelectedImage() {
    setState(() {
      _selectedImage = null;
    });
    Get.snackbar(
      "Image Deleted",
      "The selected image has been removed.",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Model(),
      builder: (controller) => Dialog(
        child: SizedBox(
          width: screenWidth(context) * 0.5,
          height: _selectedImage == null
              ? screenHeight(context) * 0.25
              : screenHeight(context) * 0.4,
          child: Column(
            children: [
              if (_selectedImage != null)
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Image.file(
                    _selectedImage!,
                    height: screenHeight(context) * 0.15,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              Expanded(
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
