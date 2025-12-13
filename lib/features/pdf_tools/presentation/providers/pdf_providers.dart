import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../cerebro/presentation/providers/cerebro_providers.dart';
import '../../data/datasources/pdf_remote_datasource.dart';
import '../../data/repositories/pdf_repository_impl.dart';
import '../../domain/entities/pdf_operation.dart';
import '../../domain/repositories/pdf_repository.dart';

// ============================================
// Data Source Providers
// ============================================

final pdfRemoteDataSourceProvider = Provider<PdfRemoteDataSource>((ref) {
  return PdfRemoteDataSource(ref.read(apiServiceProvider));
});

// ============================================
// Repository Provider
// ============================================

final pdfRepositoryProvider = Provider<PdfRepository>((ref) {
  return PdfRepositoryImpl(
    remoteDataSource: ref.read(pdfRemoteDataSourceProvider),
  );
});

// ============================================
// State Providers
// ============================================

/// Current PDF operation state
class PdfOperationNotifier extends StateNotifier<AsyncValue<PdfOperation?>> {
  final PdfRepository _repository;

  PdfOperationNotifier(this._repository) : super(const AsyncValue.data(null));

  Future<void> mergePdfs(List<String> filePaths) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.mergePdfs(
        filePaths,
        onProgress: (progress) {
          // Could update progress here if needed
        },
      );
      state = AsyncValue.data(result);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> splitPdf(String filePath, {List<int>? pageRanges}) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.splitPdf(
        filePath,
        pageRanges: pageRanges,
      );
      state = AsyncValue.data(result);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> compressPdf(String filePath, {int quality = 75}) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.compressPdf(
        filePath,
        quality: quality,
      );
      state = AsyncValue.data(result);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> extractText(String filePath, {String language = 'eng'}) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.extractText(
        filePath,
        language: language,
      );
      state = AsyncValue.data(result);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void clear() {
    state = const AsyncValue.data(null);
  }
}

final pdfOperationProvider =
    StateNotifierProvider<PdfOperationNotifier, AsyncValue<PdfOperation?>>((ref) {
  return PdfOperationNotifier(ref.read(pdfRepositoryProvider));
});

/// PDF history provider
final pdfHistoryProvider = FutureProvider<List<PdfOperation>>((ref) async {
  return ref.read(pdfRepositoryProvider).getHistory();
});

/// Selected files for merge operation
final selectedFilesProvider = StateProvider<List<String>>((ref) => []);
