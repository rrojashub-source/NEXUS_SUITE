import '../../../../core/config/api_config.dart';
import '../../../../shared/services/api_service.dart';
import '../../domain/entities/pdf_operation.dart';

/// Remote data source for PDF API calls
class PdfRemoteDataSource {
  final ApiService _apiService;

  PdfRemoteDataSource(this._apiService);

  /// Merge PDFs via API
  Future<Map<String, dynamic>> mergePdfs(
    List<String> filePaths, {
    void Function(int sent, int total)? onProgress,
  }) async {
    // Upload files and merge
    // Note: This is a simplified implementation
    // In production, you might want to upload files separately first

    final response = await _apiService.post<Map<String, dynamic>>(
      ApiConfig.pdfMerge,
      data: {
        'files': filePaths,
      },
    );

    return response.data!;
  }

  /// Split PDF via API
  Future<Map<String, dynamic>> splitPdf(
    String filePath, {
    List<int>? pageRanges,
  }) async {
    final response = await _apiService.uploadFile<Map<String, dynamic>>(
      ApiConfig.pdfSplit,
      filePath: filePath,
      fieldName: 'file',
      additionalData: pageRanges != null ? {'pages': pageRanges} : null,
    );

    return response.data!;
  }

  /// Compress PDF via API
  Future<Map<String, dynamic>> compressPdf(
    String filePath, {
    int quality = 75,
    void Function(int sent, int total)? onProgress,
  }) async {
    final response = await _apiService.uploadFile<Map<String, dynamic>>(
      ApiConfig.pdfCompress,
      filePath: filePath,
      fieldName: 'file',
      additionalData: {'quality': quality},
      onSendProgress: onProgress,
    );

    return response.data!;
  }

  /// OCR PDF via API
  Future<Map<String, dynamic>> ocrPdf(
    String filePath, {
    String language = 'eng',
  }) async {
    final response = await _apiService.uploadFile<Map<String, dynamic>>(
      ApiConfig.pdfOcr,
      filePath: filePath,
      fieldName: 'file',
      additionalData: {'language': language},
    );

    return response.data!;
  }
}
