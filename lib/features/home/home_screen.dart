import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../cerebro/cerebro_screen.dart';

/// Home screen with module navigation
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header
            SliverToBoxAdapter(
              child: _buildHeader(context),
            ),
            // Module Grid
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.1,
                ),
                delegate: SliverChildListDelegate([
                  _ModuleCard(
                    title: 'CEREBRO',
                    subtitle: 'Chat & Memory',
                    icon: Icons.psychology,
                    gradient: const [AppColors.cerebroGradientStart, AppColors.cerebroGradientEnd],
                    onTap: () => _navigateToCerebro(context),
                  ),
                  _ModuleCard(
                    title: 'PDF Tools',
                    subtitle: 'Coming Soon',
                    icon: Icons.picture_as_pdf,
                    gradient: [Colors.red.shade400, Colors.orange.shade400],
                    onTap: () => _showComingSoon(context, 'PDF Tools'),
                    enabled: false,
                  ),
                  _ModuleCard(
                    title: 'ARIA',
                    subtitle: 'Coming Soon',
                    icon: Icons.assistant,
                    gradient: [Colors.pink.shade400, Colors.purple.shade400],
                    onTap: () => _showComingSoon(context, 'ARIA'),
                    enabled: false,
                  ),
                  _ModuleCard(
                    title: 'Settings',
                    subtitle: 'Configure',
                    icon: Icons.settings,
                    gradient: [Colors.grey.shade600, Colors.grey.shade800],
                    onTap: () => _showComingSoon(context, 'Settings'),
                    enabled: false,
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.hub,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'NEXUS Suite',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Your AI Ecosystem',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.circle, color: Colors.greenAccent, size: 12),
                const SizedBox(width: 8),
                Text(
                  'NEXUS Brain Connected',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                Text(
                  '51,504 episodes',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToCerebro(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CerebroScreen()),
    );
  }

  void _showComingSoon(BuildContext context, String module) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$module coming soon!'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

/// Module card widget
class _ModuleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final List<Color> gradient;
  final VoidCallback onTap;
  final bool enabled;

  const _ModuleCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.gradient,
    required this.onTap,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1.0 : 0.5,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    icon,
                    color: Colors.white,
                    size: 40,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
