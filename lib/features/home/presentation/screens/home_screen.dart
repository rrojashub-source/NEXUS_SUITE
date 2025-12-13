import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../cerebro/presentation/screens/cerebro_chat_screen.dart';
import '../../../pdf_tools/presentation/screens/pdf_tools_screen.dart';
import '../../../aria/presentation/screens/aria_screen.dart';

/// Home Screen with bottom navigation
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final _screens = const [
    CerebroChatScreen(),
    PdfToolsScreen(),
    AriaScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
        },
        destinations: [
          NavigationDestination(
            icon: Icon(
              Icons.psychology_outlined,
              color: _currentIndex == 0 ? AppColors.cerebro : null,
            ),
            selectedIcon: Icon(
              Icons.psychology,
              color: AppColors.cerebro,
            ),
            label: 'CEREBRO',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.picture_as_pdf_outlined,
              color: _currentIndex == 1 ? AppColors.pdfTools : null,
            ),
            selectedIcon: Icon(
              Icons.picture_as_pdf,
              color: AppColors.pdfTools,
            ),
            label: 'PDF Tools',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.assistant_outlined,
              color: _currentIndex == 2 ? AppColors.aria : null,
            ),
            selectedIcon: Icon(
              Icons.assistant,
              color: AppColors.aria,
            ),
            label: 'ARIA',
          ),
        ],
      ),
    );
  }
}
