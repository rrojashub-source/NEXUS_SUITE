import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';

/// ARIA Assistant Screen - Coming Soon placeholder
class AriaScreen extends StatelessWidget {
  const AriaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.aria,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.assistant,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Text('ARIA'),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.spacingXl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.aria.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppConstants.radiusXl),
                ),
                child: Icon(
                  Icons.assistant,
                  size: 64,
                  color: AppColors.aria.withValues(alpha: 0.6),
                ),
              ),
              const SizedBox(height: AppConstants.spacingLg),
              Text(
                'ARIA is Coming Soon',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppConstants.spacingSm),
              Text(
                'Your intelligent personal assistant for\nemail, tasks, and reminders.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppConstants.spacingXl),
              _buildFeatureItem(
                context,
                Icons.email_outlined,
                'Email Management',
                'Smart email prioritization and summaries',
              ),
              _buildFeatureItem(
                context,
                Icons.task_alt,
                'Task Sync',
                'ClickUp integration and task tracking',
              ),
              _buildFeatureItem(
                context,
                Icons.calendar_today,
                'Calendar',
                'Schedule and event management',
              ),
              _buildFeatureItem(
                context,
                Icons.notifications_active,
                'Reminders',
                'Smart contextual reminders',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(
    BuildContext context,
    IconData icon,
    String title,
    String description,
  ) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppConstants.spacingSm),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.aria.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
            ),
            child: Icon(
              icon,
              color: AppColors.aria,
              size: 20,
            ),
          ),
          const SizedBox(width: AppConstants.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  description,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
