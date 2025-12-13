import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/loading_indicator.dart';
import '../../../../shared/widgets/error_view.dart';
import '../providers/cerebro_providers.dart';
import '../widgets/episode_card.dart';

/// CEREBRO Search Screen - Search through NEXUS memories
class CerebroSearchScreen extends ConsumerStatefulWidget {
  const CerebroSearchScreen({super.key});

  @override
  ConsumerState<CerebroSearchScreen> createState() => _CerebroSearchScreenState();
}

class _CerebroSearchScreenState extends ConsumerState<CerebroSearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch() {
    final query = _searchController.text.trim();
    if (query.isEmpty) {
      ref.read(episodesProvider.notifier).loadEpisodes();
    } else {
      ref.read(episodesProvider.notifier).search(query);
    }
    ref.read(searchQueryProvider.notifier).state = query;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final episodesState = ref.watch(episodesProvider);
    final searchQuery = ref.watch(searchQueryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search CEREBRO'),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search memories...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _performSearch();
                        },
                      )
                    : null,
                filled: true,
                fillColor: theme.colorScheme.surfaceContainerHighest,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppConstants.radiusXl),
                  borderSide: BorderSide.none,
                ),
              ),
              onSubmitted: (_) => _performSearch(),
            ),
          ),

          // Results
          Expanded(
            child: episodesState.when(
              loading: () => const LoadingIndicator(message: 'Searching...'),
              error: (error, _) => ErrorView(
                message: 'Search failed',
                details: error.toString(),
                onRetry: _performSearch,
              ),
              data: (episodes) {
                if (episodes.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: AppColors.cerebro.withValues(alpha: 0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          searchQuery.isEmpty
                              ? 'Enter a search query'
                              : 'No memories found',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () => ref.read(episodesProvider.notifier).refresh(),
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.spacingMd,
                    ),
                    itemCount: episodes.length,
                    itemBuilder: (context, index) {
                      return EpisodeCard(episode: episodes[index]);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
