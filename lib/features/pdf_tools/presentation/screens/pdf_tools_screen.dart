import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/pdf_operation.dart';
import '../widgets/pdf_tool_card.dart';

/// PDF Tools Screen - Main interface for PDF operations
class PdfToolsScreen extends ConsumerWidget {
  const PdfToolsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.pdfTools,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.picture_as_pdf,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Text('PDF Tools'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              // Navigate to history
            },
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(AppConstants.spacingMd),
        mainAxisSpacing: AppConstants.spacingMd,
        crossAxisSpacing: AppConstants.spacingMd,
        children: [
          PdfToolCard(
            title: 'Merge PDFs',
            description: 'Combine multiple PDFs into one',
            icon: Icons.merge_type,
            color: AppColors.pdfTools,
            onTap: () => _navigateToTool(context, PdfOperationType.merge),
          ),
          PdfToolCard(
            title: 'Split PDF',
            description: 'Extract pages from a PDF',
            icon: Icons.call_split,
            color: AppColors.pdfTools,
            onTap: () => _navigateToTool(context, PdfOperationType.split),
          ),
          PdfToolCard(
            title: 'Compress',
            description: 'Reduce PDF file size',
            icon: Icons.compress,
            color: AppColors.pdfTools,
            onTap: () => _navigateToTool(context, PdfOperationType.compress),
          ),
          PdfToolCard(
            title: 'OCR',
            description: 'Extract text from images',
            icon: Icons.text_fields,
            color: AppColors.pdfTools,
            onTap: () => _navigateToTool(context, PdfOperationType.ocr),
          ),
        ],
      ),
    );
  }

  void _navigateToTool(BuildContext context, PdfOperationType type) {
    // TODO: Navigate to specific tool screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Opening ${type.name}...')),
    );
  }
}
