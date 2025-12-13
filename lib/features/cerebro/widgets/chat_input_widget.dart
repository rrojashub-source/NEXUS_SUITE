import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// Chat input widget with text field and send button
class ChatInputWidget extends StatefulWidget {
  final Function(String) onSend;

  const ChatInputWidget({super.key, required this.onSend});

  @override
  State<ChatInputWidget> createState() => _ChatInputWidgetState();
}

class _ChatInputWidgetState extends State<ChatInputWidget> {
  final TextEditingController _controller = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _hasText = _controller.text.trim().isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _send() {
    if (_hasText) {
      widget.onSend(_controller.text);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Attachment button
            IconButton(
              icon: const Icon(Icons.attach_file),
              onPressed: () {
                // TODO: Implement file attachment
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('File attachment coming soon!')),
                );
              },
              color: AppColors.textSecondaryLight,
            ),
            // Text field
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Escribe un mensaje...',
                  filled: true,
                  fillColor: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.surfaceDark
                      : AppColors.surfaceLight,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
                textCapitalization: TextCapitalization.sentences,
                maxLines: 4,
                minLines: 1,
                onSubmitted: (_) => _send(),
              ),
            ),
            const SizedBox(width: 8),
            // Send button
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              child: IconButton(
                icon: Icon(
                  _hasText ? Icons.send : Icons.mic,
                  color: _hasText ? AppColors.primary : AppColors.textSecondaryLight,
                ),
                onPressed: _hasText
                    ? _send
                    : () {
                        // TODO: Implement voice input
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Voice input coming soon!')),
                        );
                      },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
