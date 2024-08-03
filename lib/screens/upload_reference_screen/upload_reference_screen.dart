/*import 'dart:io';

import 'package:flutter/material.dart';

import '../../routes/routes.dart';
import '../../services/image_comparison_service.dart';
import '../../widgets/widgets.dart';

// Without use of bloc
class UploadReferenceScreen extends StatefulWidget {
  const UploadReferenceScreen({super.key});

  @override
  _UploadReferenceScreenState createState() => _UploadReferenceScreenState();
}

class _UploadReferenceScreenState extends State<UploadReferenceScreen> {
  File? _referenceImage;
  final List<File> _shelfImages = [];

  void _updateReferenceImage(File? image) {
    setState(() {
      _referenceImage = image;
    });
  }

  void _updateShelfImage(File? image) {
    if (image != null) {
      setState(() {
        _shelfImages.add(image);
      });
    }
  }

  void _compareImages() {
    if (_referenceImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
          content: Text('Please upload a reference image.'),
        ),
      );
      return;
    }

    if (_shelfImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
          content: Text('Please capture/upload shelf images.'),
        ),
      );
      return;
    }

    final result =
        ImageComparisonService.compareImages(_referenceImage!, _shelfImages);
    Navigator.pushNamed(
      context,
      Routes.resultScreen,
      arguments: result,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Reference Planogram')),
      body: Column(
        children: [
          ImagePickerWidget(
            isReferenceImage: true,
            onImagePicked: _updateReferenceImage,
          ),
          if (_referenceImage != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.file(_referenceImage!),
            ),
          const SizedBox(height: 16),
          ImagePickerWidget(
            isReferenceImage: false,
            onImagePicked: _updateShelfImage,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _shelfImages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.file(_shelfImages[index]),
                );
              },
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
            onPressed: _compareImages,
            child: const Text(
              'Compare Images',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shelf_comparison_app/screens/upload_reference_screen/upload_reference.dart';

import '../../widgets/widgets.dart';

class UploadReferenceScreen extends StatelessWidget {
  const UploadReferenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UploadReferenceBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Upload Reference Planogram')),
        body: BlocBuilder<UploadReferenceBloc, UploadReferenceState>(
          builder: (context, state) {
            return Column(
              children: [
                ImagePickerWidget(
                  isReferenceImage: true,
                  onImagePicked: (image) {
                    context
                        .read<UploadReferenceBloc>()
                        .add(UpdateReferenceImage(image: image!));
                  },
                ),
                if (state.referenceImage != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.file(state.referenceImage!),
                  ),
                const SizedBox(height: 16),
                ImagePickerWidget(
                  isReferenceImage: false,
                  onImagePicked: (image) {
                    context
                        .read<UploadReferenceBloc>()
                        .add(UpdateShelfImage(image: image!));
                  },
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.shelfImages.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.file(state.shelfImages[index]),
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    surfaceTintColor: Colors.transparent,
                  ),
                  onPressed: state.loading
                      ? null
                      : () {
                          context
                              .read<UploadReferenceBloc>()
                              .add(CompareImages(context: context));
                        },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (!state.loading)
                        const Text(
                          'Compare Images',
                          style: TextStyle(color: Colors.white),
                        ),
                      if (state.loading)
                        const CircularProgressIndicator(
                          color: Colors.white,
                        ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
