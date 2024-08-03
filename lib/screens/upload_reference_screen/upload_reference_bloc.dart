import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shelf_comparison_app/services/image_comparison_service.dart';

import '../../routes/routes.dart';
import 'upload_reference.dart';

class UploadReferenceBloc
    extends Bloc<UploadReferenceEvent, UploadReferenceState> {
  UploadReferenceBloc() : super(const UploadReferenceState()) {
    registerEvents();
  }

  void registerEvents() {
    on<UpdateReferenceImage>(_onUpdateReferenceImage);
    on<UpdateShelfImage>(_onUpdateShelfImage);
    on<CompareImages>(_onCompareImages);
  }

  void _onUpdateReferenceImage(
      UpdateReferenceImage event, Emitter<UploadReferenceState> emit) {
    emit(state.copyWith(referenceImage: event.image));
  }

  void _onUpdateShelfImage(
      UpdateShelfImage event, Emitter<UploadReferenceState> emit) {
    final updatedShelfImages = List<File>.from(state.shelfImages)
      ..add(event.image);
    emit(state.copyWith(shelfImages: updatedShelfImages));
  }

  Future<void> _onCompareImages(
      CompareImages event, Emitter<UploadReferenceState> emit) async {
    if (state.referenceImage == null) {
      ScaffoldMessenger.of(event.context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
          content: Text('Please upload a reference image.'),
        ),
      );
      emit(state.copyWith(errorMessage: 'Please upload a reference image.'));
      return;
    }

    if (state.shelfImages.isEmpty) {
      ScaffoldMessenger.of(event.context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
          content: Text('Please capture/upload shelf images.'),
        ),
      );
      emit(state.copyWith(errorMessage: 'Please capture/upload shelf images.'));
      return;
    }

    emit(state.copyWith(loading: true));

    await Future.delayed(const Duration(seconds: 2));

    final result = ImageComparisonService.compareImages(
      state.referenceImage!,
      state.shelfImages,
    );

    emit(state.copyWith(comparisonResult: result, loading: false));

    // Navigate to the result screen with the comparison result
    Navigator.pushNamed(
      event.context,
      Routes.resultScreen,
      arguments: result,
    );
  }
}
