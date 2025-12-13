import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/services/api_service.dart';
import '../../../../shared/services/storage_service.dart';
import '../../data/datasources/cerebro_local_datasource.dart';
import '../../data/datasources/cerebro_remote_datasource.dart';
import '../../data/repositories/cerebro_repository_impl.dart';
import '../../domain/entities/chat_message.dart';
import '../../domain/entities/episode.dart';
import '../../domain/repositories/cerebro_repository.dart';

// ============================================
// Service Providers
// ============================================

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService.instance;
});

// ============================================
// Data Source Providers
// ============================================

final cerebroRemoteDataSourceProvider = Provider<CerebroRemoteDataSource>((ref) {
  return CerebroRemoteDataSource(ref.read(apiServiceProvider));
});

final cerebroLocalDataSourceProvider = Provider<CerebroLocalDataSource>((ref) {
  return CerebroLocalDataSource(ref.read(storageServiceProvider));
});

// ============================================
// Repository Provider
// ============================================

final cerebroRepositoryProvider = Provider<CerebroRepository>((ref) {
  return CerebroRepositoryImpl(
    remoteDataSource: ref.read(cerebroRemoteDataSourceProvider),
    localDataSource: ref.read(cerebroLocalDataSourceProvider),
  );
});

// ============================================
// State Notifiers
// ============================================

/// Chat messages state
class ChatNotifier extends StateNotifier<AsyncValue<List<ChatMessage>>> {
  final CerebroRepository _repository;

  ChatNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadHistory();
  }

  Future<void> loadHistory() async {
    state = const AsyncValue.loading();
    try {
      final history = await _repository.getChatHistory();
      state = AsyncValue.data(history);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> sendMessage(String message) async {
    final currentMessages = state.value ?? [];

    // Add user message
    final userMessage = ChatMessage.user(message);
    state = AsyncValue.data([...currentMessages, userMessage]);

    // Add loading indicator
    final loadingMessage = ChatMessage.loading();
    state = AsyncValue.data([...currentMessages, userMessage, loadingMessage]);

    try {
      final response = await _repository.sendMessage(message);

      // Replace loading with actual response
      final messages = state.value ?? [];
      final updatedMessages = messages
          .where((m) => !m.isLoading)
          .toList()
        ..add(response);

      state = AsyncValue.data(updatedMessages);
    } catch (e, st) {
      // Remove loading on error
      final messages = state.value ?? [];
      state = AsyncValue.data(messages.where((m) => !m.isLoading).toList());
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> clearHistory() async {
    await _repository.clearChatHistory();
    state = const AsyncValue.data([]);
  }
}

final chatProvider =
    StateNotifierProvider<ChatNotifier, AsyncValue<List<ChatMessage>>>((ref) {
  return ChatNotifier(ref.read(cerebroRepositoryProvider));
});

/// Episodes state
class EpisodesNotifier extends StateNotifier<AsyncValue<List<Episode>>> {
  final CerebroRepository _repository;

  EpisodesNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadEpisodes();
  }

  Future<void> loadEpisodes({int limit = 20, int offset = 0}) async {
    state = const AsyncValue.loading();
    try {
      final episodes = await _repository.getEpisodes(limit: limit, offset: offset);
      state = AsyncValue.data(episodes);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> search(String query) async {
    state = const AsyncValue.loading();
    try {
      final episodes = await _repository.searchEpisodes(query);
      state = AsyncValue.data(episodes);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() async {
    await loadEpisodes();
  }
}

final episodesProvider =
    StateNotifierProvider<EpisodesNotifier, AsyncValue<List<Episode>>>((ref) {
  return EpisodesNotifier(ref.read(cerebroRepositoryProvider));
});

/// Search query state
final searchQueryProvider = StateProvider<String>((ref) => '');
