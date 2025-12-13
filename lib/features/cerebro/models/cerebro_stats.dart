/// CEREBRO statistics model
class CerebroStats {
  final int totalEpisodes;
  final int episodesWithEmbeddings;
  final int embeddingsQueueDepth;
  final double embeddingCoverage;
  final String status;

  CerebroStats({
    required this.totalEpisodes,
    required this.episodesWithEmbeddings,
    required this.embeddingsQueueDepth,
    required this.embeddingCoverage,
    required this.status,
  });

  /// Create from API response
  factory CerebroStats.fromJson(Map<String, dynamic> json) {
    final total = json['total_episodes'] as int? ?? 0;
    final withEmb = json['episodes_with_embeddings'] as int? ?? 0;
    
    return CerebroStats(
      totalEpisodes: total,
      episodesWithEmbeddings: withEmb,
      embeddingsQueueDepth: json['embeddings_queue_depth'] as int? ?? 0,
      embeddingCoverage: total > 0 ? (withEmb / total) * 100 : 0,
      status: json['status'] as String? ?? 'unknown',
    );
  }

  /// Default/empty stats
  factory CerebroStats.empty() {
    return CerebroStats(
      totalEpisodes: 0,
      episodesWithEmbeddings: 0,
      embeddingsQueueDepth: 0,
      embeddingCoverage: 0,
      status: 'disconnected',
    );
  }

  /// Check if connected
  bool get isConnected => status == 'healthy' || status == 'ok';

  /// Get formatted episode count
  String get formattedEpisodeCount {
    if (totalEpisodes >= 1000000) {
      return '${(totalEpisodes / 1000000).toStringAsFixed(1)}M';
    } else if (totalEpisodes >= 1000) {
      return '${(totalEpisodes / 1000).toStringAsFixed(1)}K';
    }
    return totalEpisodes.toString();
  }
}
