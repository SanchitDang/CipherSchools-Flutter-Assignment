import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../helper/SharedPreferencesService.dart';

class ProfilePageController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    getDetails();
  }

  RxString name=''.obs;
  RxString email=''.obs;

  void getDetails() async {
    name.value = await SharedPreferencesService.getUserNameFromSF() ?? "";
    email.value = await SharedPreferencesService.getUserEmailFromSF() ?? "";
  }

  final picker = ImagePicker();

  String _image = '';
  String _imageUrl = "";

  // Image Picker function to get image from gallery
  Future getImageFromGallery() async {
    try {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        String imageUrl = await uploadImageToFirebase(imageFile);
        // setState(() {
        _image = pickedFile.path;
        _imageUrl = imageUrl;
        // });
      }
    } catch (e) {
      print("Error picking image from gallery: $e");
      // Handle the error as needed
    }
  }

  // Image Picker function to get image from camera
  Future getImageFromCamera() async {
    try {
      final pickedFile = await picker.getImage(source: ImageSource.camera);

      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        String imageUrl = await uploadImageToFirebase(imageFile);
        // setState(() {
        _image = pickedFile.path;
        _imageUrl = imageUrl;
        // });
      }
    } catch (e) {
      print("Error capturing image from camera: $e");
      // Handle the error as needed
    }
  }

  Future showOptions(BuildContext context) async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Photo Gallery'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from gallery
              getImageFromGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from camera
              getImageFromCamera();
            },
          ),
        ],
      ),
    );
  }

  Future<String> uploadImageToFirebase(File imageFile) async {
    try {
      // Create a unique filename for the image
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      // Upload the image to Firebase Storage
      Reference storageReference =
          FirebaseStorage.instance.ref().child('user/images/$fileName');
      UploadTask uploadTask = storageReference.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});

      // Get the URL of the uploaded image
      String imageUrl = await taskSnapshot.ref.getDownloadURL();

      return imageUrl;
    } catch (e) {
      print("Error uploading image to Firebase Storage: $e");
      return "";
    }
  }
}
