import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'features/home/presentation/pages/main_portfolio_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const PortfolioApp(),
    ),
  );
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Hamza Jadoon - Portfolio',
          theme: AppTheme.darkTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.isDarkMode
              ? ThemeMode.dark
              : ThemeMode.light,
          home: const MainPortfolioPage(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

// Wrapper to add theme toggle functionality
// class PortfolioWrapper extends StatelessWidget {
//   const PortfolioWrapper({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);
//
//     return Scaffold(
//       body: const MainPortfolioPage(),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => themeProvider.toggleTheme(),
//         backgroundColor: Theme.of(context).colorScheme.primary,
//         shape: const CircleBorder(),
//         child: AnimatedSwitcher(
//           duration: const Duration(milliseconds: 300),
//           child: Icon(
//             themeProvider.isDarkMode
//                 ? Icons.light_mode_rounded
//                 : Icons.dark_mode_rounded,
//             key: ValueKey(themeProvider.isDarkMode),
//             color: Theme.of(context).colorScheme.onPrimary,
//           ),
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
//
//     );
//   }
// }
