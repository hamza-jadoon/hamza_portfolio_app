// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:hamza_portfolio_app/core/constants/app_texts.dart';
import 'package:hamza_portfolio_app/core/utils/responsive_helper.dart';
import 'package:hamza_portfolio_app/features/portfolio/data/models/services_model.dart';
import 'package:hamza_portfolio_app/features/portfolio/presentation/widgets/service/service_card.dart';
import 'header_section.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.isDesktop(context) ? 60 : 20,
          vertical: 120,
        ),
        child: Column(
          children: [
            const SectionHeader(title: AppTextContent.navAboutMe),
            const SizedBox(height: 60),
            _buildDescription(),
            const SizedBox(height: 60),
            const SectionHeader(title: AppTextContent.explore),
            const SizedBox(height: 80),
            _buildServicesSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDescription() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 600),
      child: Builder(
        builder: (context) {
          return Text(
            AppTextContent.aboutDescription,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).primaryColor,
              height: 1.6,
            ),
          );
        }
      ),
    );
  }

  // Widget _buildExploreButton() {
  //   return GestureDetector(
  //     onTap: () {
  //       // Handle explore action
  //     },
  //     child: Builder(
  //       builder: (context) {
  //         return Container(
  //           padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
  //           decoration: BoxDecoration(
  //             border: Border.all(
  //               color: Theme.of(context).primaryColor,
  //               width: 1,
  //             ),
  //           ),
  //           child: Text(
  //             AppTextContent.explore,
  //             style: TextStyle(
  //               fontSize: 14,
  //               fontWeight: FontWeight.bold,
  //               color: Theme.of(context).primaryColor,
  //               letterSpacing: 2,
  //             ),
  //           ),
  //         );
  //       }
  //     ),
  //   );
  // }

  Widget _buildServicesSection(BuildContext context) {
    final services = _getServices();
    final isDesktop = ResponsiveHelper.isDesktop(context);

    return Column(
      children: [
        // Services Row 1
        isDesktop
            ? Row(
          children: [
            Expanded(child: ServiceCard(service: services[0])),
            const SizedBox(width: 60),
            Expanded(child: ServiceCard(service: services[1])),
          ],
        )
            : Column(
          children: [
            ServiceCard(service: services[0]),
            const SizedBox(height: 40),
            ServiceCard(service: services[1]),
          ],
        ),
        const SizedBox(height: 60),

        // Services Row 2
        Container(
          constraints: BoxConstraints(
            maxWidth: isDesktop ? 400 : double.infinity,
          ),
          child: ServiceCard(service: services[2]),
        ),
      ],
    );
  }

  List<ServiceModel> _getServices() {
    return [
      ServiceModel(
        title: AppTextContent.development,
        description: AppTextContent.appdevelopdic,
        icon: Icons.code_outlined,

      ),
      ServiceModel(
        title: AppTextContent.design,
        description: AppTextContent.uiuxdic,
        icon: Icons.palette_outlined,
      ),
      ServiceModel(
        title: AppTextContent.maintenance,
        description: AppTextContent.maintenancedic,
        icon: Icons.build_outlined,
      ),


    ];
  }
}