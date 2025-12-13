import 'package:equatable/equatable.dart';

/// PDF operation types
enum PdfOperationType {
  merge,
  split,
  compress,
  ocr,
}

/// PDF operation status
enum PdfOperationStatus {
  pending,
  uploading,
  processing,
  completed,
  failed,
}

/// PDF operation entity
class PdfOperation extends Equatable {
  final String id;
  final PdfOperationType type;
  final PdfOperationStatus status;
  final List<String> inputFiles;
  final String? outputFile;
  final double progress;
  final String? error;
  final DateTime createdAt;
  final DateTime? completedAt;

  const PdfOperation({
    required this.id,
    required this.type,
    required this.status,
    required this.inputFiles,
    this.outputFile,
    this.progress = 0.0,
    this.error,
    required this.createdAt,
    this.completedAt,
  });

  @override
  List<Object?> get props => [
        id,
        type,
        status,
        inputFiles,
        outputFile,
        progress,
        error,
        createdAt,
        completedAt,
      ];

  PdfOperation copyWith({
    String? id,
    PdfOperationType? type,
    PdfOperationStatus? status,
    List<String>? inputFiles,
    String? outputFile,
    double? progress,
    String? error,
    DateTime? createdAt,
    DateTime? completedAt,
  }) {
    return PdfOperation(
      id: id ?? this.id,
      type: type ?? this.type,
      status: status ?? this.status,
      inputFiles: inputFiles ?? this.inputFiles,
      outputFile: outputFile ?? this.outputFile,
      progress: progress ?? this.progress,
      error: error ?? this.error,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  /// Get operation type display name
  String get typeName {
    switch (type) {
      case PdfOperationType.merge:
        return 'Merge PDFs';
      case PdfOperationType.split:
        return 'Split PDF';
      case PdfOperationType.compress:
        return 'Compress PDF';
      case PdfOperationType.ocr:
        return 'Extract Text (OCR)';
    }
  }
}
