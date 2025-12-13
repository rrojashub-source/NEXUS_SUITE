import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/episode.dart';
import '../models/cerebro_stats.dart';
import '../models/chat_message.dart';
import '../services/cerebro_service.dart';

/// Chat messages state provider
final chatMessagesProvider = StateNotifierProvider<ChatMessagesNotifier, List<ChatMessage>>((ref) {
  return ChatMessagesNotifier(ref);
});

/// Chat messages state notifier
class ChatMessagesNotifier extends StateNotifier<List<ChatMessage>> {
  final Ref _ref;

  ChatMessagesNotifier(this._ref) : super([]) {
    // Add welcome message
    state = [
      ChatMessage(
        content: 'Hola! Soy NEXUS. ¿En qué puedo ayudarte hoy?',
        isUser: false,
        timestamp: DateTime.now(),
      ),
    ];
  }

  /// Send message and get response
  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    // Add user message
    final userMessage = ChatMessage(
      content: text,
      isUser: true,
      timestamp: DateTime.now(),
    );
    state = [...state, userMessage];

    // Get response from CEREBRO
    final cerebroService = _ref.read(cerebroServiceProvider);
    final response = await cerebroService.sendMessage(text);
    
    state = [...state, response];
  }

  /// Clear chat history
  void clearChat() {
    state = [
      ChatMessage(
        content: 'Chat limpiado. ¿En qué puedo ayudarte?',
        isUser: false,
        timestamp: DateTime.now(),
      ),
    ];
  }
}

/// Loading state provider
final isLoadingProvider = StateProvider<bool>((ref) => false);

/// CEREBRO stats provider
final cerebroStatsProvider = FutureProvider<CerebroStats>((ref) async {
  final cerebroService = ref.watch(cerebroServiceProvider);
  return cerebroService.getStats();
});

/// Recent episodes provider
final recentEpisodesProvider = FutureProvider<List<Episode>>((ref) async {
  final cerebroService = ref.watch(cerebroServiceProvider);
  return cerebroService.getRecentEpisodes(limit: 20);
});

/// Search results provider
final searchQueryProvider = StateProvider<String>((ref) => '');

final searchResultsProvider = FutureProvider<List<Episode>>((ref) async {
  final query = ref.watch(searchQueryProvider);
  if (query.isEmpty) return [];

  final cerebroService = ref.watch(cerebroServiceProvider);
  return cerebroService.searchMemory(query, limit: 20);
});

/// Connection status provider
final connectionStatusProvider = FutureProvider<bool>((ref) async {
  final cerebroService = ref.watch(cerebroServiceProvider);
  return cerebroService.checkHealth();
});
