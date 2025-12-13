import '../../../../core/utils/logger.dart';
import '../../domain/entities/pdf_operation.dart';
import '../../domain/repositories/pdf_repository.dart';
import '../datasources/pdf_remote_datasource.dart';

/// Implementation of PdfRepository
class PdfRepositoryImpl implements PdfRepository {
  final PdfRemoteDataSource _remoteDataSource;
  final List<PdfOperation> _history = [];

  PdfRepositoryImpl({
    required PdfRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<PdfOperation> mergePdfs(
    List<String> filePaths, {
    void Function(double progress)? onProgress,
  }) async {
    final operation = PdfOperation(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: PdfOperationType.merge,
      status: PdfOperationStatus.uploading,
      inputFiles: filePaths,
      createdAt: DateTime.now(),
    );

    try {
      onProgress?.call(0.1);

      final result = await _remoteDataSource.mergePdfs(
        filePaths,
        onProgress: (sent, total) {
          onProgress?.call(0.1 + (sent / total) * 0.5);
        },
      );

      onProgress?.call(0.9);

      final completed = operation.copyWith(
        status: PdfOperationStatus.completed,
        outputFile: result['output_url'] as String?,
        progress: 1.0,
        completedAt: DateTime.now(),
      );

      _history.insert(0, completed);
      return completed;
    } catch (e, st) {
      AppLogger.e('Failed to merge PDFs', e, st);

      final failed = operation.copyWith(
        status: PdfOperationStatus.failed,
        error: e.toString(),
      );

      _history.insert(0, failed);
      return failed;
    }
  }

  @override
  Future<PdfOperation> splitPdf(
    String filePath, {
    List<int>? pageRanges,
    void Function(double progress)? onProgress,
  }) async {
    final operation = PdfOperation(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: PdfOperationType.split,
      status: PdfOperationStatus.uploading,
      inputFiles: [filePath],
      createdAt: DateTime.now(),
    );

    try {
      onProgress?.call(0.2);

      final result = await _remoteDataSource.splitPdf(
        filePath,
        pageRanges: pageRanges,
      );

      onProgress?.call(1.0);

      final completed = operation.copyWith(
        status: PdfOperationStatus.completed,
        outputFile: result['output_url'] as String?,
        progress: 1.0,
        completedAt: DateTime.now(),
      );

      _history.insert(0, completed);
      return completed;
    } catch (e, st) {
      AppLogger.e('Failed to split PDF', e, st);

      final failed = operation.copyWith(
        status: PdfOperationStatus.failed,
        error: e.toString(),
      );

      _history.insert(0, failed);
      return failed;
    }
  }

  @override
  Future<PdfOperation> compressPdf(
    String filePath, {
    int quality = 75,
    void Function(double progress)? onProgress,
  }) async {
    final operation = PdfOperation(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: PdfOperationType.compress,
      status: PdfOperationStatus.uploading,
      inputFiles: [filePath],
      createdAt: DateTime.now(),
    );

    try {
      final result = await _remoteDataSource.compressPdf(
        filePath,
        quality: quality,
        onProgress: (sent, total) {
          onProgress?.call(sent / total);
        },
      );

      final completed = operation.copyWith(
        status: PdfOperationStatus.completed,
        outputFile: result['output_url'] as String?,
        progress: 1.0,
        completedAt: DateTime.now(),
      );

      _history.insert(0, completed);
      return completed;
    } catch (e, st) {
      AppLogger.e('Failed to compress PDF', e, st);

      final failed = operation.copyWith(
        status: PdfOperationStatus.failed,
        error: e.toString(),
      );

      _history.insert(0, failed);
      return failed;
    }
  }

  @override
  Future<PdfOperation> extractText(
    String filePath, {
    String language = 'eng',
    void Function(double progress)? onProgress,
  }) async {
    final operation = PdfOperation(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: PdfOperationType.ocr,
      status: PdfOperationStatus.uploading,
      inputFiles: [filePath],
      createdAt: DateTime.now(),
    );

    try {
      onProgress?.call(0.2);

      final result = await _remoteDataSource.ocrPdf(
        filePath,
        language: language,
      );

      onProgress?.call(1.0);

      final completed = operation.copyWith(
        status: PdfOperationStatus.completed,
        outputFile: result['text'] as String?,
        progress: 1.0,
        completedAt: DateTime.now(),
      );

      _history.insert(0, completed);
      return completed;
    } catch (e, st) {
      AppLogger.e('Failed to extract text', e, st);

      final failed = operation.copyWith(
        status: PdfOperationStatus.failed,
        error: e.toString(),
      );

      _history.insert(0, failed);
      return failed;
    }
  }

  @override
  Future<List<PdfOperation>> getHistory({int limit = 20}) async {
    return _history.take(limit).toList();
  }

  @override
  Future<void> clearHistory() async {
    _history.clear();
  }
}
