import 'dart:io';

import 'package:flutter/cupertino.dart';

abstract class UploadReferenceEvent {}

class UpdateReferenceImage extends UploadReferenceEvent {
  final File image;

  UpdateReferenceImage({required this.image});
}

class UpdateShelfImage extends UploadReferenceEvent {
  final File image;

  UpdateShelfImage({required this.image});
}

class CompareImages extends UploadReferenceEvent {
  final BuildContext context;

  CompareImages({required this.context});
}
