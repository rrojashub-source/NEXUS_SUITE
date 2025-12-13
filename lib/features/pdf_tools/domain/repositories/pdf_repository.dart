import '../entities/pdf_operation.dart';

/// Abstract repository interface for PDF operations
abstract class PdfRepository {
  /// Merge multiple PDFs into one
  Future<PdfOperation> mergePdfs(
    List<String> filePaths, {
    void Function(double progress)? onProgress,
  });

  /// Split a PDF into multiple files
  Future<PdfOperation> splitPdf(
    String filePath, {
    List<int>? pageRanges,
    void Function(double progress)? onProgress,
  });

  /// Compress a PDF to reduce file size
  Future<PdfOperation> compressPdf(
    String filePath, {
    int quality = 75,
    void Function(double progress)? onProgress,
  });

  /// Extract text from PDF using OCR
  Future<PdfOperation> extractText(
    String filePath, {
    String language = 'eng',
    void Function(double progress)? onProgress,
  });

  /// Get operation history
  Future<List<PdfOperation>> getHistory({int limit = 20});

  /// Clear operation history
  Future<void> clearHistory();
}
