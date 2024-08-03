import 'dart:io';

import 'package:equatable/equatable.dart';

class UploadReferenceState extends Equatable {
  final File? referenceImage;
  final List<File> shelfImages;
  final String? comparisonResult;
  final bool loading;
  final String? errorMessage;

  const UploadReferenceState({
    this.referenceImage,
    this.shelfImages = const [],
    this.comparisonResult,
    this.loading = false,
    this.errorMessage,
  });

  UploadReferenceState copyWith({
    File? referenceImage,
    List<File>? shelfImages,
    String? comparisonResult,
    bool? loading,
    String? errorMessage,
  }) {
    return UploadReferenceState(
      referenceImage: referenceImage ?? this.referenceImage,
      shelfImages: shelfImages ?? this.shelfImages,
      comparisonResult: comparisonResult,
      loading: loading ?? false,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        referenceImage,
        shelfImages,
        comparisonResult,
        loading,
        errorMessage,
      ];
}
