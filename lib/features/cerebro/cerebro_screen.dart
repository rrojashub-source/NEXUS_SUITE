import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'widgets/chat_message_widget.dart';
import 'widgets/chat_input_widget.dart';
import 'models/chat_message.dart';

/// CEREBRO main screen - Chat interface with NEXUS brain
class CerebroScreen extends StatefulWidget {
  const CerebroScreen({super.key});

  @override
  State<CerebroScreen> createState() => _CerebroScreenState();
}

class _CerebroScreenState extends State<CerebroScreen> {
  final List<ChatMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Add welcome message
    _messages.add(
      ChatMessage(
        content: 'Hola Ricardo! Soy NEXUS. ¿En qué puedo ayudarte hoy?',
        isUser: false,
        timestamp: DateTime.now(),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    // Add user message
    setState(() {
      _messages.add(
        ChatMessage(
          content: text,
          isUser: true,
          timestamp: DateTime.now(),
        ),
      );
      _isLoading = true;
    });

    _scrollToBottom();

    // TODO: Implement actual API call to CEREBRO
    // For now, simulate response
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _messages.add(
        ChatMessage(
          content: 'Entendido. Estoy procesando tu solicitud... (API no conectada aún)',
          isUser: false,
          timestamp: DateTime.now(),
        ),
      );
      _isLoading = false;
    });

    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.psychology, size: 20),
            ),
            const SizedBox(width: 12),
            const Text('CEREBRO'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement memory search
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Memory search coming soon!')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // TODO: Show options menu
            },
          ),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.cerebroGradientStart, AppColors.cerebroGradientEnd],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Messages list
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _messages.length + (_isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _messages.length && _isLoading) {
                  return const _TypingIndicator();
                }
                return ChatMessageWidget(message: _messages[index]);
              },
            ),
          ),
          // Input area
          ChatInputWidget(onSend: _sendMessage),
        ],
      ),
    );
  }
}

/// Typing indicator widget
class _TypingIndicator extends StatelessWidget {
  const _TypingIndicator();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.nexusBubbleDark
                  : AppColors.nexusBubble,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(AppColors.primary),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'NEXUS está pensando...',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
