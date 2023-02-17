import 'dart:io';

import 'package:chat_app/utils/constants.dart';
import 'package:chat_app/utils/dimen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({Key? key}) : super(key: key);

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {

  File? _pickedImageFile;

  @override
  void initState() {
    super.initState();
    getLostData();
  }

  void _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _pickedImageFile = File(pickedImage?.path ?? "");
    });
  }

  Future<void> getLostData() async {
    final picker = ImagePicker();
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.files != null) {
      for (final XFile file in (response.files)!) {
        setState(() {
          _pickedImageFile = File(file.path);
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: Dimen.avatarRadius,
          backgroundColor: Theme.of(context).colorScheme.primary,
          backgroundImage: _pickedImageFile != null ? FileImage(_pickedImageFile!) : null,
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: const Icon(Icons.image),
          label: const Text(Constants.labelAddImage),
          style: ButtonStyle(
            foregroundColor: MaterialStatePropertyAll(
                Theme.of(context).colorScheme.primary),
          ),
        ),
      ],
    );
  }
}
