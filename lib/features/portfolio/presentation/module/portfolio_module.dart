// lib/features/portfolio/portfolio_module.dart
import 'package:flutter/material.dart';
import 'package:hamza_portfolio_app/features/portfolio/data/models/portfolio_view_model.dart';
import 'package:hamza_portfolio_app/features/portfolio/data/repositories/portfolio_repository_impl.dart';
import 'package:hamza_portfolio_app/features/portfolio/domain/repositories/portfolio_repository.dart';
import 'package:hamza_portfolio_app/features/portfolio/presentation/pages/sections/portfolio_section.dart';
import 'package:provider/provider.dart';


class PortfolioModule extends StatelessWidget {
  const PortfolioModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PortfolioRepository>(
          create: (_) => PortfolioRepositoryImpl(),
        ),
        ChangeNotifierProvider<PortfolioViewModel>(
          create: (context) => PortfolioViewModel(
            repository: context.read<PortfolioRepository>(),
          ),
        ),
      ],
      builder: (context, child) {
        return const PortfolioSection();
      },
    );
  }
}