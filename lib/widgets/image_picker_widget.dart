import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatelessWidget {
  final bool isReferenceImage;
  final Function(File?) onImagePicked;

  const ImagePickerWidget({
    super.key,
    required this.isReferenceImage,
    required this.onImagePicked,
  });

  Future<void> _showImageSourceDialog(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await showDialog<File>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Image Source'),
        actions: [
          TextButton(
            onPressed: () async {
              final pickedFile =
                  await picker.pickImage(source: ImageSource.camera);
              Navigator.pop(
                  context, pickedFile != null ? File(pickedFile.path) : null);
            },
            child: const Text('Camera'),
          ),
          TextButton(
            onPressed: () async {
              final pickedFile =
                  await picker.pickImage(source: ImageSource.gallery);
              Navigator.pop(
                  context, pickedFile != null ? File(pickedFile.path) : null);
            },
            child: const Text('Gallery'),
          ),
        ],
      ),
    );

    if (pickedFile != null) {
      onImagePicked(pickedFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isReferenceImage ? Colors.green : Colors.green,
      ),
      onPressed: () => _showImageSourceDialog(context),
      child: Text(
        isReferenceImage ? 'Upload Reference Image' : 'Capture New Shelf Image',
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
